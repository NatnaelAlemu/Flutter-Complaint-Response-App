import mongoose from 'mongoose'

import {BaseUserModel} from './baseUser.js'
const Schema = mongoose.Schema
const ComplainantModel = BaseUserModel.discriminator('Complainant',
    new Schema({
        mycomplaints:[
            {
                type:Schema.Types.ObjectId,
                ref:"Complaint"
            }
        ]
    })
)
export default ComplainantModel