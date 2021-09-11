import jwt from 'jsonwebtoken'
import dotenv from 'dotenv'
dotenv.config()
export const authMiddleWare = (req, res, next) => {
    console.log("some request is commig");
    const tokenHeader = req.headers.authorization
    console.log(tokenHeader)
    const token = tokenHeader && tokenHeader.split(' ')[1]
    console.log(`token ${token}`)
    if (token) {
        jwt.verify( 
            token,
            process.env.ACCESS_TOKEN_SECRET,
            (err, authData) => {
                if (err) {
                    console.log('error')
                    console.log(err.message)
                    return res.status(403).send(err.message)
                }
                else {
                    console.log(`user ${authData}`)
                    res.user = authData
                    next()
                }
            }
        )
    } else {
        res.status(403).json({"message":"can't get token"})
    }
}