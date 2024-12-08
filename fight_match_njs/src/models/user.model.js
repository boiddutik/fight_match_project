// import mongoose from "mongoose"
// import bcrypt from "bcrypt";
// import jwt from "jsonwebtoken";

// const userSchema = new mongoose.Schema({
//     userName: {
//         type: String,
//         required: [true, "UserName is required."],
//         unique: true,
//         index: true
//     },
//     email: {
//         type: String,
//         required: [true, "Email is required."],
//         unique: true,
//         trim: true,
//         index: true
//     },
//     password: {
//         type: String,
//         required: [true, "Password is required."],
//     },
//     fullName: {
//         type: String,
//         required: [true, "FullName is required."],
//         trim: true
//     },
//     gender: {
//         type: String,
//         required: [true, "Gender is required."],
//         enum: ["Male", "Female"]
//     },
//     dob: {
//         type: Date,
//         required: [true, "Dob is required."]
//     },
//     country: {
//         type: String,
//         required: [true, "Country is required."]
//     },
//     state: {
//         type: String,
//         required: [true, "State is required."]
//     },
//     city: {
//         type: String,
//         required: [true, "City is required."]
//     },
//     profession: {
//         type: String,
//         required: [true, "Profession is required."],
//         trim: true
//     },
//     bio: {
//         type: String,
//         default: "",
//         trim: true
//     },
//     avatar: {
//         type: String,
//         required: true
//     },
//     cover: {
//         type: String,
//         default: ""
//     },

//     // Physical Attributes
//     height: {
//         type: Number,
//         default: null
//     },
//     weight: {
//         type: Number
//     },

//     // Additional Data
//     intensity: {
//         type: String,
//         trim: true
//     },
//     goal: {
//         type: String,
//         trim: true
//     },
//     practicing: {
//         type: String,
//         trim: true
//     },

//     // Posts and Engagement
//     conversations: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Conversation', default: [] }],
//     posts: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Post', default: [] }],
//     pinnedPosts: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Post', default: [] }],
//     likedPosts: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Post', default: [] }],
//     unLikedPosts: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Post', default: [] }],
//     commentedPosts: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Comment', default: [] }],
//     sharedPosts: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Post', default: [] }],
//     // Relationships
//     sentFollowRequests: {
//         type: [mongoose.Schema.Types.ObjectId],
//         ref: "Profile",
//         default: []
//     },
//     recievedFollowRequests: {
//         type: [mongoose.Schema.Types.ObjectId],
//         ref: "Profile",
//         default: []
//     },
//     followers: {
//         type: [mongoose.Schema.Types.ObjectId],
//         ref: "Profile",
//         default: []
//     },
//     followerings: {
//         type: [mongoose.Schema.Types.ObjectId],
//         ref: "Profile",
//         default: []
//     },
//     blockList: {
//         type: [mongoose.Schema.Types.ObjectId],
//         ref: "Profile",
//         default: []
//     },
//     // Activity Tracking
//     isOnline: {
//         type: Boolean,
//         default: true
//     },
//     lastOnlineAt: {
//         type: Date
//     },
//     lastOnlineAtVisible: {
//         type: Boolean,
//         default: true
//     },
//     activityCount: {
//         type: Number,
//         default: 0
//     },
//     isPrivateProfile: {
//         // People must send follow-request 
//         // to see this profile's contents
//         type: Boolean,
//         default: false
//     },
//     isProfileMatchable: {
//         // This must be true (unaffected by isPrivateProfile)
//         // if want to match with fighters
//         type: Boolean,
//         default: true
//     },
//     // Related Entities
//     wallets: {
//         type: [mongoose.Schema.Types.ObjectId],
//         ref: "Wallet",
//         default: []
//     },
//     sponsors: {
//         type: [mongoose.Schema.Types.ObjectId],
//         ref: "Sponsor",
//         default: []
//     },
//     fights: {
//         type: [mongoose.Schema.Types.ObjectId],
//         ref: "Fight",
//         default: []
//     },
//     achievements: {
//         type: [mongoose.Schema.Types.ObjectId],
//         ref: "Achievement",
//         default: []
//     },
//     refreshToken: {
//         type: String
//     }
// }, { timestamps: true })



// userSchema.pre("save", async function (next) {
//     if (this.isModified("password")) {
//         this.password = await bcrypt.hash(this.password, 10);
//     }
//     next();
// });


// userSchema.methods.isPasswordCorrect = async function (password) {
//     return await bcrypt.compare(password, this.password)
// }

// userSchema.methods.generateAccessToken = function () {
//     return jwt.sign(
//         {
//             _id: this._id,
//             userName: this.userName,
//         },
//         process.env.ACCESS_TOKEN_SECRET,
//         {
//             expiresIn: process.env.ACCESS_TOKEN_EXPIRY
//         }
//     )
// }

// userSchema.methods.generateRefreshToken = function () {
//     return jwt.sign(
//         {
//             _id: this._id,
//             userName: this.userName,
//         },
//         process.env.REFRESH_TOKEN_SECRET,
//         {
//             expiresIn: process.env.REFRESH_TOKEN_EXPIRY
//         }
//     )
// }

// export const User = mongoose.model("User", userSchema)

import mongoose from "mongoose";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

const userSchema = new mongoose.Schema(
    {
        userName: {
            type: String,
            required: [true, "UserName is required."],
            unique: true,
            index: true,
        },
        email: {
            type: String,
            required: [true, "Email is required."],
            unique: true,
            trim: true,
            index: true,
        },
        password: {
            type: String,
            required: [true, "Password is required."],
        },
        fullName: {
            type: String,
            required: [true, "FullName is required."],
            trim: true,
            default: "",
        },
        gender: {
            type: String,
            required: [true, "Gender is required."],
            enum: ["Male", "Female"],
            default: "Male",
        },
        dob: {
            type: Date,
            required: [true, "Dob is required."],
            default: new Date(0), // Default to Unix epoch
        },
        country: {
            type: String,
            required: [true, "Country is required."],
            default: "",
        },
        state: {
            type: String,
            required: [true, "State is required."],
            default: "",
        },
        city: {
            type: String,
            required: [true, "City is required."],
            default: "",
        },
        profession: {
            type: String,
            required: [true, "Profession is required."],
            trim: true,
            default: "",
        },
        bio: {
            type: String,
            trim: true,
            default: "",
        },
        avatar: {
            type: String,
            required: true,
            default: "",
        },
        cover: {
            type: String,
            default: "",
        },

        // Physical Attributes
        height: {
            type: Number,
            default: null,
        },
        weight: {
            type: Number,
            default: null,
        },

        // Additional Data
        intensity: {
            type: String,
            trim: true,
            default: "",
        },
        goal: {
            type: String,
            trim: true,
            default: "",
        },
        practicing: {
            type: String,
            trim: true,
            default: "",
        },

        // Posts and Engagement
        conversations: {
            type: [{ type: mongoose.Schema.Types.ObjectId, ref: "Conversation" }],
            default: [],
        },
        posts: {
            type: [{ type: mongoose.Schema.Types.ObjectId, ref: "Post" }],
            default: [],
        },
        pinnedPosts: {
            type: [{ type: mongoose.Schema.Types.ObjectId, ref: "Post" }],
            default: [],
        },
        likedPosts: {
            type: [{ type: mongoose.Schema.Types.ObjectId, ref: "Post" }],
            default: [],
        },
        unLikedPosts: {
            type: [{ type: mongoose.Schema.Types.ObjectId, ref: "Post" }],
            default: [],
        },
        commentedPosts: {
            type: [{ type: mongoose.Schema.Types.ObjectId, ref: "Comment" }],
            default: [],
        },
        sharedPosts: {
            type: [{ type: mongoose.Schema.Types.ObjectId, ref: "Post" }],
            default: [],
        },

        // Relationships
        sentFollowRequests: {
            type: [mongoose.Schema.Types.ObjectId],
            ref: "Profile",
            default: [],
        },
        recievedFollowRequests: {
            type: [mongoose.Schema.Types.ObjectId],
            ref: "Profile",
            default: [],
        },
        followers: {
            type: [mongoose.Schema.Types.ObjectId],
            ref: "Profile",
            default: [],
        },
        followerings: {
            type: [mongoose.Schema.Types.ObjectId],
            ref: "Profile",
            default: [],
        },
        blockList: {
            type: [mongoose.Schema.Types.ObjectId],
            ref: "Profile",
            default: [],
        },

        // Activity Tracking
        isOnline: {
            type: Boolean,
            default: false,
        },
        lastOnlineAt: {
            type: Date,
            default: null,
        },
        lastOnlineAtVisible: {
            type: Boolean,
            default: true,
        },
        activityCount: {
            type: Number,
            default: 0,
        },
        isPrivateProfile: {
            type: Boolean,
            default: false,
        },
        isProfileMatchable: {
            type: Boolean,
            default: true,
        },

        // Related Entities
        wallets: {
            type: [mongoose.Schema.Types.ObjectId],
            ref: "Wallet",
            default: [],
        },
        sponsors: {
            type: [mongoose.Schema.Types.ObjectId],
            ref: "Sponsor",
            default: [],
        },
        fights: {
            type: [mongoose.Schema.Types.ObjectId],
            ref: "Fight",
            default: [],
        },
        achievements: {
            type: [mongoose.Schema.Types.ObjectId],
            ref: "Achievement",
            default: [],
        },

        refreshToken: {
            type: String,
            default: "",
        },
    },
    { timestamps: true }
);

userSchema.pre("save", async function (next) {
    if (this.isModified("password")) {
        this.password = await bcrypt.hash(this.password, 10);
    }
    next();
});

userSchema.methods.isPasswordCorrect = async function (password) {
    return await bcrypt.compare(password, this.password);
};

userSchema.methods.generateAccessToken = function () {
    return jwt.sign(
        {
            _id: this._id,
            userName: this.userName,
        },
        process.env.ACCESS_TOKEN_SECRET,
        {
            expiresIn: process.env.ACCESS_TOKEN_EXPIRY,
        }
    );
};

userSchema.methods.generateRefreshToken = function () {
    return jwt.sign(
        {
            _id: this._id,
            userName: this.userName,
        },
        process.env.REFRESH_TOKEN_SECRET,
        {
            expiresIn: process.env.REFRESH_TOKEN_EXPIRY,
        }
    );
};

export const User = mongoose.model("User", userSchema);
