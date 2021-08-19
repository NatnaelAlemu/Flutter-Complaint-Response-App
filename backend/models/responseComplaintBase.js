import mongoose from 'mongoose'

const Schema = mongoose.Schema

const ComplaintResponseBaseModel = mongoose.model("BaseModel",new Schema({
    title:{
        type:String,
        required:true
    },
    description:{
        type:String,
        required:true
    },
    seen:{
        type:Boolean,
        default:false,
    }, 

},
{   
    discriminatorKey: 'messageIs', 
    collection: 'responsesandcomplaints', 
},{timestamps:true}
))
export default ComplaintResponseBaseModel