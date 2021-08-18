import UserModel from '../models/user.js'

export const getUser = async(req,res,next)=>{
    let user 
    try {
         user = await UserModel.findById(req.params.id)
        if(user == null) return res.status(404).send("User not found")
    }catch (error) {
       return res.status(500).send(error.message)
    }
    res.user = user
    next()
}

