import mongoose from 'mongoose'
import Base  from './responseComplaintBase.js'
const Schema = mongoose.Schema


const ComplaintModel = Base.discriminator(
    "Complaint",
    new Schema({
     
        fixed:{
            type:Boolean,
            default:false,
        },
        madeby:{
            type:Schema.Types.ObjectId,
            required:true,
            ref:'Complainant'
        }, 
        response:{  
            type:Schema.Types.ObjectId,
            ref:"Response"
        }
    }
    )
)
export default ComplaintModel