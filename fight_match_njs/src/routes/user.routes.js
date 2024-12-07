import { Router } from "express";
import { upload } from "../middlewares/multer.middleware.js"
import {
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
} from "../controllers/user.controllers.js";
import { verifyJWT } from "../middlewares/auth.middleware.js"

const router = Router();

router.route("/create-user").post(upload, createUser)
router.route("/login").post(loginUser)

// secured routes
router.route("/logout").post(verifyJWT, logOut)
router.route("/refresh-access-token").post(verifyJWT, refreshAccessToken)
router.route("/change-password").post(verifyJWT, changePassword)
router.route("/change-usernamen").post(verifyJWT, changeUsername)
router.route("/change-email").post(verifyJWT, changeEmail)
router.route("/get-current-user").post(verifyJWT, getCurrentUser)

// secured routes
router.route("/me").get(verifyJWT, getCurrentUser);
router.route("/update-user-avatar").post(verifyJWT, upload, updateUserAvatar)
router.route("/update-user-cover").post(verifyJWT, upload, updateUserCover)
router.route("/change-user-detail").post(verifyJWT, updateUserDetails)
router.route("/:userId").get(verifyJWT, getUserByUserIdDetails);
router.route("/:userId/followers").get(verifyJWT, getFollowers);
router.route("/:userId/following").get(verifyJWT, getFollowing);
router.route("/follow/:userId").post(verifyJWT, followUser)
router.route("/follow-request-dicision/:userId").post(verifyJWT, followRequestDecision)
router.route("/unfollow/:userId").post(verifyJWT, unfollowUser);
router.route("/block/:userId").post(verifyJWT, blockUser);
router.route("/unblock/:userId").post(verifyJWT, unblockUser);
router.route("/search").get(verifyJWT, searchUsers);


export default router