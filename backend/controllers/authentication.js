
import {BaseUserModel} from '../models/baseUser.js'
import ComplainantModel from '../models/complainant.js'
import AdminModel from '../models/admin.js'
import bcryptjs from 'bcryptjs'
import jwt from 'jsonwebtoken' 
import ComplaintModel from '../models/complaint.js'
export const getAllUsers = async (req, res) => {
    console.log('Request is comming');
    try {
        const allusers = await BaseUserModel.find()
        res.status(200).json({allusers})
    } catch (error) {
        res.status(404).json({ message: error.message })
    }
} 

export const getSingleUser = (req, res) => {
    if (res.user) {
        res.send(res.user);
    }
}
export const signUp = async (req, res) => {
    try {
        console.log(req.body)
        const { email, confirmPassword, password,username,fullName,role } = req.body
        if(!(email && password && confirmPassword && username && fullName && role)){
            console.log("All fields are required")
            return res.status(403).send("All fields are required")
        }
    const ifExists = await BaseUserModel.findOne({email})
    if (ifExists) { 
        console.log("Account already exists.")
        return res.status(409).send("User allready exists") }
    if (password !== confirmPassword) { 
        console.log("Password doesn't match")
        return res.status(409).send("Password doesn't match") }
        const hashedPassword = await bcryptjs.hash(password, 12)
        const newUser = req.body
        newUser.password = hashedPassword
    try {
        console.log(`role ${newUser.role}`)
        if(newUser.role !== 'admin' && newUser.role !== 'complainant'){
            console.log("role invalid")
            return res.status(403).json({message:"role invalid"})
        }
        if(newUser.role === 'admin'){
           const createdUser = await AdminModel.create(newUser)
           console.log("Register success")
            res.status(201).json({createdUser})
        }
        if(newUser.role === 'complainant'){
           console.log("Register success")
           const createdUser = await ComplainantModel.create(newUser)
            res.status(201).json({createdUser})
        }

    } catch (err) {
        console.log(err.message)
        res.send(err.message)
    }
    } catch (error) {
        console.log(error.message)
        res.status(500).send(error.message)
    }
}
export const login = async (req, res) => {
    console.log("login request is comming");
    try {
        const { email, password } = req.body
        if (!(email && password)) { return res.status(400).send("All fields are required") }

        const currentUser = await BaseUserModel.findOne({ email })
        const comparePassword = await bcryptjs.compare(password, currentUser.password)
        console.log(`Compare password is ${comparePassword}`)
        if (currentUser && comparePassword) {
            const Generate_Token = jwt.sign(
                { currentUser },
                process.env.ACCESS_TOKEN_SECRET,
                {
                    expiresIn: '30m'
                }
            )
            console.log('Login success')
            res.status(200).json({ accessToken: Generate_Token, user: currentUser })
        }
        else{
            return res.status(400).json({message:"email or password not correct"})
        }
    } catch (error) {
        return res.status(400).json({message:"email or password not correct"})
    }
}
export const updateProfile = async (req, res) => {
    console.log(`res user ${res.user}`)
    try {
        const updateInfo = req.body
        const currentInfo = res.user
        console.log(currentInfo)
        if (currentInfo) {
            await BaseUserModel.findOneAndUpdate(currentInfo, { $set: updateInfo })
            res.status(201).send("Account Updated!")

        }
    } catch (error) {
        res.status(500).send(error.message)
    }
}
export const deleteProfile = async (req, res) => {
    console.log(res.user)
    try {
        const checkUser = res.user
        if (checkUser) {
            await BaseUserModel.findOneAndDelete(checkUser);
            res.status(200).send("user successfully deleted")
        }
    } catch (err) {
        res.status(500).send(err.message)
    }
}
