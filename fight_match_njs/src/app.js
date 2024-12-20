import express from "express";
import cors from "cors";
import cookieParser from "cookie-parser"

const app = express();
// --
app.use(cors({ origin: process.env.CORS_ORIGIN, credentials: true, }))
app.use(express.json({ limit: "16Kb" }))
app.use(express.urlencoded({ extended: true, limit: "16Kb" }))
app.use("/api/v1/public", express.static("public"));
app.use(cookieParser())
// --
import userRouter from "./routes/user.routes.js"
import postRouter from "./routes/post.routes.js"
import commentRouter from "./routes/comment.routes.js"
// --
app.use("/api/v1/ping", (_, res) => {
    return res.send("Backend is Running")
})
app.use("/api/v1/user", userRouter)
app.use("/api/v1/post", postRouter)
app.use("/api/v1/comment", commentRouter)

export { app };