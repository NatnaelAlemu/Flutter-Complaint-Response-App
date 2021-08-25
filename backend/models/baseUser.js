import mongoose from 'mongoose'

export const BaseUserModel = mongoose.model(
    'User', 
    new mongoose.Schema({
    fullName:{
        type: String,
        required: true
    },
    email: {
        type:String,
        required:true
    },
    username:{
        type:String, 
        required:true
    },
    password: {
        type:String,
        required:true
    },
    role:{
        type:String,
        required:true
    }
},{
    discriminatorKey: 'userIs', 
    collection: 'users', 
},
{timestamps:true}
)
)

