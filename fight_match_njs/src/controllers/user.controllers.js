import { User } from "../models/user.model.js";
import mongoose from "mongoose";
import jwt from "jsonwebtoken";
import fs from 'fs';
import path from 'path';

import { ApiError } from "../utils/api.error.js"

const generateAccessAndRefereshTokens = async (userId) => {
    try {
        const user = await User.findById(userId)
        const accessToken = user.generateAccessToken()
        const refreshToken = user.generateRefreshToken()
        user.refreshToken = refreshToken
        await user.save({ validateBeforeSave: false })
        return { accessToken, refreshToken }
    } catch (error) {
        throw new ApiError(500, "Something went wrong while generating referesh and access token")
    }
}

const createUser = async (req, res) => {
    try {
        const { userName, email, password, fullName, dob, profession, gender, country, state, city } = req.body;
        const avatar = req.files?.avatar?.[0]?.path;
        const cover = req.files?.cover?.[0]?.path || "";
        if (!userName || !email || !password || !fullName || !dob || !profession || !avatar || !gender || !country || !state || !city) {
            return res.status(400).json({ message: "Missing required fields." });
        }
        const existingUserName = await User.findOne({ userName });
        if (existingUserName) {
            if (avatar) fs.unlinkSync(avatar);
            if (cover) fs.unlinkSync(cover);
            return res.status(400).json({
                message: `UserName ${userName} is already taken.`,
            });
        }
        const existingEmail = await User.findOne({ email });
        if (existingEmail) {
            if (avatar) fs.unlinkSync(avatar);
            if (cover) fs.unlinkSync(cover);
            return res.status(400).json({
                message: `Email ${email} is already in use.`,
            });
        }
        const createdUser = await User.create({
            userName,
            email,
            password,
            fullName,
            dob,
            profession,
            avatar,
            cover,
            gender,
            country,
            state,
            city
        });
        await createdUser.save({ validateBeforeSave: false });
        const userWithoutSensitiveData = await User.findById(createdUser._id).select("-password -refreshToken");
        return res.status(201).json({
            message: "Account created successfully.",
            user: userWithoutSensitiveData,
        });
    } catch (error) {
        console.error("Error creating user:", error.message);
        if (error.code === 11000) {
            return res.status(400).json({
                message: `Duplicate field: ${Object.keys(error.keyValue).join(", ")} already exists.`,
            });
        }
        res.status(500).json({ message: "Could not create account.", error: error.message });
    }
};

const loginUser = async (req, res) => {
    const { email, password } = req.body
    if (!email) {
        res.status(400).json({ message: "Credential is missing." });
    }
    const user = await User.findOne({
        $or: [{ email }]
    })
    if (!user) {
        res.status(404).json({ message: "User does not exist" });
    }
    const isPasswordValid = await user.isPasswordCorrect(password)
    if (!isPasswordValid) {
        res.status(401).json({ message: "Invalid user credentials" });
    }
    const { accessToken, refreshToken } = await generateAccessAndRefereshTokens(user._id)
    const loggedInUser = await User.findById(user._id).select("-password -refreshToken")
    const options = {
        httpOnly: true,
        secure: true
    }
    return res.status(200).cookie("accessToken", accessToken, options)
        .cookie("refreshToken", refreshToken, options).json({
            message: "User logged In Successfully.",
            user: loggedInUser, jwt: accessToken, rwt: refreshToken,
        });
}

const logOut = async (req, res) => {
    await User.findByIdAndUpdate(
        req.user._id, {
        $set: {
            refreshToken: undefined,
        }
    },
        { new: true }
    )
    const options = {
        httpOnly: true,
        secure: true
    }
    return res
        .status(200)
        .clearCookie("accessToken", options)
        .clearCookie("refreshToken", options)
        .json({
            message: "User logged Out.",
        })

}

const refreshAccessToken = async (req, res) => {
    const incomingRefreshToken = req.cookies.refreshToken || req.body.refreshToken
    try {
        const decodedToken = jwt.verify(incomingRefreshToken, process.env.REFRESH_TOKEN_SECRET)
        const user = await User.findById(decodedToken?._id)
        if (!user) {
            res.status(401).json({ message: "Invalid Refresh Token" });
        }
        if (incomingRefreshToken !== user?.refreshToken) {
            res.status(401).json({ message: "Token expired!" });
        }
        const options = {
            httpOnly: true,
            secure: true
        }
        const { accessToken, refreshToken: newRefreshToken } = await generateAccessAndRefereshTokens(user._id)
        return res.status(200).cookie("accessToken", accessToken, options)
            .cookie("refreshToken", newRefreshToken, options).json({
                message: "New Refresh Token Generated.",
                jwt: accessToken, rwt: newRefreshToken,
            });
    } catch (error) {
        res.status(500).json({ message: "Something went wrong, while generating the token!" });
    }
}

const changePassword = async (req, res) => {
    const { oldPassword, newPassword } = req.body;
    if (oldPassword === newPassword) {
        throw new ApiError(401, "Please enter a new password!")
    }
    const user = await User.findById(req.user?._id)
    if (!user) {
        throw new ApiError(401, "Couldnot find user.")
    }
    const isPasswordValid = await user.isPasswordCorrect(oldPassword)
    if (!isPasswordValid) {
        throw new ApiError(401, "Incorrect old password.")
    }
    user.password = newPassword
    await user.save({ validateBeforeSave: false })
    return res.status(200).json({ "message": "Password Changed." })
}

const changeUsername = async (req, res) => {
    const { userName } = req.body;
    if (userName.length < 3) {
        throw new ApiError(401, "Username cannot be less than 3 units.")
    }
    const user = await User.findById(req.user?._id)
    if (!user) {
        throw new ApiError(401, "Couldnot find user.")
    }
    user.userName = userName
    await user.save({ validateBeforeSave: false })
    return res.status(200).json({ "message": "Username updated.", "userName": username })
}

const changeEmail = async (req, res) => {
    const { email } = req.body;
    if (email.length < 8) {
        throw new ApiError(401, "Please enter a valid email.")
    }
    const user = await User.findById(req.user?._id)
    if (!user) {
        throw new ApiError(401, "Couldnot find user.")
    }
    user.email = email
    await user.save({ validateBeforeSave: false })
    return res.status(200).json({ "message": "Email updated.", "email": email })
}

const getCurrentUser = async (req, res) => {
    const user = await User.findById(req.user?._id)
    if (!user) {
        res.status(404).json({ message: "User does not exist" });
    }
    const { accessToken, refreshToken } = await generateAccessAndRefereshTokens(user._id)
    const loggedInUser = await User.findById(user._id).select("-password -refreshToken")
    const options = {
        httpOnly: true,
        secure: true
    }
    return res.status(200).cookie("accessToken", accessToken, options)
        .cookie("refreshToken", refreshToken, options).json({
            message: "Current User Details.",
            user: loggedInUser, jwt: accessToken, rwt: refreshToken,
        });
}

const updateUserAvatar = async (req, res) => {
    try {
        const { userId } = req.body;
        const avatar = req.file?.path;
        if (!userId || !avatar) {
            return res.status(400).json({ message: "Missing required fields: userId or avatar." });
        }
        if (!mongoose.isValidObjectId(userId)) {
            return res.status(400).json({ message: "Invalid userId ID." });
        }
        const updatedUser = await User.findByIdAndUpdate(
            userId,
            { avatar },
            { new: true }
        );
        if (!updatedUser) {
            return res.status(404).json({ message: "User not found." });
        }
        return res.status(200).json({
            message: "Avatar updated successfully.",
            user: updatedUser,
        });
    } catch (error) {
        console.error("Error updating avatar:", error.message);
        res.status(500).json({ message: "Could not update avatar.", error: error.message });
    }
};

const updateUserCover = async (req, res) => {
    try {
        const { userId } = req.body;
        const cover = req.file?.path;
        if (!userId || !cover) {
            return res.status(400).json({ message: "Missing required fields: userId or cover." });
        }
        if (!mongoose.isValidObjectId(userId)) {
            return res.status(400).json({ message: "Invalid userId ID." });
        }
        const updatedUser = await User.findByIdAndUpdate(
            userId,
            { cover },
            { new: true }
        );
        if (!updatedUser) {
            return res.status(404).json({ message: "User not found." });
        }
        return res.status(200).json({
            message: "Cover updated successfully.",
            user: updatedUser,
        });
    } catch (error) {
        console.error("Error updating cover:", error.message);
        res.status(500).json({ message: "Could not update cover.", error: error.message });
    }
};

const updateUserDetails = async (req, res) => {
    try {
        const { userId, ...updateData } = req.body;

        if (!userId || !mongoose.isValidObjectId(userId)) {
            return res.status(400).json({ message: "Invalid or missing userID." });
        }

        if (updateData._id || updateData.userName || updateData.user) {
            return res.status(400).json({ message: "Cannot update _id(userId), user(userId), userName." });
        }

        const updatedUser = await User.findByIdAndUpdate(
            userId,
            { $set: updateData },
            { new: true, runValidators: true }
        );
        if (!updatedUser) {
            return res.status(404).json({ message: "User not found." });
        }
        return res.status(200).json({
            message: "User updated successfully.",
            user: updatedUser,
        });
    } catch (error) {
        console.error("Error updating user details:", error.message);
        res.status(500).json({ message: "Could not update user.", error: error.message });
    }
};

const getUserByUserIdDetails = async (req, res) => {
    const { userId } = req.params;
    try {
        const user = await User.findById(userId);
        if (!user) {
            return res.status(404).json({ message: "User not found." });
        }
        return res.status(200).json({ user });
    } catch (error) {
        console.error("Error getting user details:", error.message);
        res.status(500).json({ message: "Could not retrieve user details.", error: error.message });
    }
};

const getFollowers = async (req, res) => {
    const { userId } = req.params;
    try {
        const user = await User.findById(userId).populate("followers");
        if (!user) {
            return res.status(404).json({ message: "User not found." });
        }
        return res.status(200).json({ followers: user.followers });
    } catch (error) {
        console.error("Error getting followers:", error.message);
        res.status(500).json({ message: "Could not retrieve followers.", error: error.message });
    }
};

const getFollowing = async (req, res) => {
    const { userId } = req.params;
    try {
        const user = await User.findById(userId).populate("followerings");
        if (!user) {
            return res.status(404).json({ message: "User not found." });
        }
        return res.status(200).json({ following: user.followerings });
    } catch (error) {
        console.error("Error getting following:", error.message);
        res.status(500).json({ message: "Could not retrieve following list.", error: error.message });
    }
};

const followUser = async (req, res) => {
    try {
        const { userId } = req.params;
        const senderId = req.user.id;
        if (userId === senderId) {
            return res.status(400).json({ message: "You cannot follow your own profile." });
        }
        // Find the profiles for both the sender and the receiver
        const senderProfile = await User.findOne({ user: senderId });
        const receiverProfile = await User.findOne({ user: userId });
        if (!senderProfile || !receiverProfile) {
            return res.status(404).json({ message: "Profile not found." });
        }
        if (receiverProfile.isPrivateProfile) {
            if (!senderProfile.sentFollowRequests.includes(userId)) {
                senderProfile.sentFollowRequests.push(userId);
                await senderProfile.save();
                receiverProfile.recievedFollowRequests.push(senderId);
                await receiverProfile.save();
                return res.status(200).json({ message: "Follow request sent successfully." });
            } else {
                return res.status(400).json({ message: "Follow request already sent." });
            }
        } else {
            if (!senderProfile.followerings.includes(userId)) {
                senderProfile.followerings.push(userId);
                await senderProfile.save();
                if (!receiverProfile.followers.includes(senderId)) {
                    receiverProfile.followers.push(senderId);
                    await receiverProfile.save();
                }
                return res.status(200).json({
                    message: "Followed successfully. Direct relationship established.",
                });
            } else {
                return res.status(400).json({ message: "Already following this user." });
            }
        }
    } catch (error) {
        console.error("Error following user:", error.message);
        res.status(500).json({ message: "Could not follow user.", error: error.message });
    }
};

const followRequestDecision = async (req, res) => {
    const { userId } = req.params;
    const senderId = req.user.id;
    try {
        const receiverProfile = await User.findOne({ user: userId });
        const senderProfile = await User.findOne({ user: senderId });
        if (!receiverProfile || !senderProfile) {
            return res.status(404).json({ message: "Profile not found." });
        }
        const followRequestIndex = receiverProfile.recievedFollowRequests.indexOf(senderId);
        if (followRequestIndex === -1) {
            return res.status(400).json({ message: "No follow request found from this user." });
        }
        receiverProfile.recievedFollowRequests.splice(followRequestIndex, 1);
        await receiverProfile.save();
        const { decision } = req.body;
        if (decision === true) {
            if (!senderProfile.followerings.includes(userId)) {
                senderProfile.followerings.push(userId);
                await senderProfile.save();
            }
            if (!receiverProfile.followers.includes(senderId)) {
                receiverProfile.followers.push(senderId);
                await receiverProfile.save();
            }
            return res.status(200).json({ message: "Follow request accepted." });
        } else if (decision === false) {
            return res.status(200).json({ message: "Follow request denied." });
        } else {
            return res.status(400).json({ message: "Invalid decision. Use 'true' for accept or 'false' for deny." });
        }
    } catch (error) {
        console.error("Error processing follow request:", error.message);
        res.status(500).json({ message: "Could not process follow request.", error: error.message });
    }
};

const unfollowUser = async (req, res) => {
    const { userId } = req.params;
    const senderId = req.user.id;
    try {
        const receiverProfile = await User.findOne({ user: userId });
        const senderProfile = await User.findOne({ user: senderId });
        if (!receiverProfile || !senderProfile) {
            return res.status(404).json({ message: "Profile not found." });
        }
        if (!senderProfile.followerings.includes(userId)) {
            return res.status(400).json({ message: "You are not following this user." });
        }
        senderProfile.followerings = senderProfile.followerings.filter(id => id.toString() !== userId);
        receiverProfile.followers = receiverProfile.followers.filter(id => id.toString() !== senderId);
        await senderProfile.save();
        await receiverProfile.save();
        return res.status(200).json({ message: "Unfollowed successfully." });
    } catch (error) {
        console.error("Error unfollowing user:", error.message);
        res.status(500).json({ message: "Could not unfollow user.", error: error.message });
    }
};

const blockUser = async (req, res) => {
    const { userId } = req.params;
    const senderId = req.user.id;
    try {
        const receiverProfile = await User.findOne({ user: userId });
        const senderProfile = await User.findOne({ user: senderId });
        if (!receiverProfile || !senderProfile) {
            return res.status(404).json({ message: "User not found." });
        }
        if (senderProfile.blockList.includes(userId)) {
            return res.status(400).json({ message: "You have already blocked this user." });
        }
        senderProfile.blockList.push(userId);
        await senderProfile.save();
        senderProfile.followerings = senderProfile.followerings.filter(id => id.toString() !== userId);
        receiverProfile.followers = receiverProfile.followers.filter(id => id.toString() !== senderId);
        await senderProfile.save();
        await receiverProfile.save();
        return res.status(200).json({ message: "User blocked successfully." });
    } catch (error) {
        console.error("Error blocking user:", error.message);
        res.status(500).json({ message: "Could not block user.", error: error.message });
    }
};

const unblockUser = async (req, res) => {
    const { userId } = req.params;
    const senderId = req.user.id;
    try {
        const receiverProfile = await User.findOne({ user: userId });
        const senderProfile = await User.findOne({ user: senderId });
        if (!receiverProfile || !senderProfile) {
            return res.status(404).json({ message: "Profile not found." });
        }
        if (!senderProfile.blockList.includes(userId)) {
            return res.status(400).json({ message: "You are not blocking this user." });
        }
        senderProfile.blockList = senderProfile.blockList.filter(id => id.toString() !== userId);
        await senderProfile.save();
        return res.status(200).json({ message: "User unblocked successfully." });
    } catch (error) {
        console.error("Error unblocking user:", error.message);
        res.status(500).json({ message: "Could not unblock user.", error: error.message });
    }
};

const searchUsers = async (req, res) => {
    const { query } = req.query;
    if (!query) {
        return res.status(400).json({ message: "Search query is required." });
    }
    try {
        const userResults = await User.find({
            $or: [
                { userName: { $regex: query, $options: "i" } },
                { fullName: { $regex: query, $options: "i" } },
                { email: { $regex: query, $options: "i" } }
            ]
        });
        if (userResults.length === 0) {
            return res.status(404).json({ message: "No users found matching the search query." });
        }
        const users = await User.find({
            user: { $in: userResults.map(user => user._id) }
        });
        return res.status(200).json({
            message: "Users found.",
            users: users,
        });
    } catch (error) {
        console.error("Error searching users:", error.message);
        res.status(500).json({ message: "Could not perform search.", error: error.message });
    }
};

export {
    createUser,
    loginUser,
    logOut,
    refreshAccessToken,
    changePassword,
    changeUsername,
    changeEmail,
    getCurrentUser,
    updateUserAvatar,
    updateUserCover,
    updateUserDetails,
    getUserByUserIdDetails,
    getFollowers,
    getFollowing,
    followUser,
    followRequestDecision,
    unfollowUser,
    blockUser,
    unblockUser,
    searchUsers
};