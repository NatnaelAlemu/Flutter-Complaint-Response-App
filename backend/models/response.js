import mongoose from 'mongoose'
import Base from './responseComplaintBase.js'
const Schema = mongoose.Schema 

const ResponseModel = Base.discriminator("Response",
    new Schema({
        issuedby:{
            type:Schema.Types.ObjectId,
            ref:"Admin",
            required:true
        },
        forcomplaint:{
            type:Schema.Types.ObjectId,
            ref:"Complaint",
            required:true
        }
        
    })
)
export default ResponseModel