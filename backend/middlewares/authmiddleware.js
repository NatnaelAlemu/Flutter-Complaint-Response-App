import jwt from 'jsonwebtoken'
import dotenv from 'dotenv'
dotenv.config()
export const authMiddleWare = (req, res, next) => {
    const tokenHeader = req.headers.authorization
    const token = tokenHeader && tokenHeader.split(' ')[1]
    if (token) {
        jwt.verify(
            token,
            process.env.ACCESS_TOKEN_SECRET,
            (err, authData) => {
                if (err) {
                    return res.status(403).send(err.message)
                }
                else {
                    res.user = authData
                    next()
                }
            }
        )
    } else {
        res.status(403).send("can't get token")
    }
}