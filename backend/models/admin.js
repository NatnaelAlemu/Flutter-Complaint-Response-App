import mongoose from 'mongoose'
import {BaseUserModel} from './baseUser.js'
const Schema = mongoose.Schema
const AdminModel = BaseUserModel.discriminator("Admin",
    new Schema({
        myresponses:[
            {
                type:Schema.Types.ObjectId,
                ref:"Response"
            }
        ] 
    })
)
export default AdminModel
