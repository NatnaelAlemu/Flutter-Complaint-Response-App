import ResponseModel from '../models/response.js'
import AdminModel from '../models/admin.js'
import ComplaintModel from '../models/complaint.js'

export const createResponse = async(req,res)=>{
    console.log("request creat is commig")
    console.log(req.body)
    try {
        const responseInfo = req.body
        const response = await ResponseModel.create(responseInfo)
       if(response){
            const forComplaint = await ComplaintModel.findById(response.forcomplaint)
            if(forComplaint == null){
                return res.status(403).json({messgae:"complaint not found"})
            }
            forComplaint.response = response
            forComplaint.fixed = true
            await forComplaint.save()
            const issuedby = await AdminModel.findOne({_id:responseInfo.issuedby})
            if(issuedby){
                issuedby.myresponses.push(response)
                await issuedby.save()
            
            return res.status(201).json({response})
            }else{
                return res.status(403).json({message:"admin doesn't exist"})
            }
            
       }
       return res.status(403).json({message:"Failed to create response"})
        
    } catch (error) {
        console.log(error.message)
        res.status(500).json({message:error.message})
    }

}

export const getAllResponses = async(req,res)=>{

    try {
        const allresponses =await ResponseModel.find()
        res.status(200).json({allresponses})
    } catch (error) {
        res.status(500).json({message:error.message})
    }
}
export const getResponse = async(req,res)=>{

    try {
        
        const id = req.params.id
        const response =await ResponseModel.findById(id)
        if(response){
            return res.status(200).json({response})
        }else{
            return res.status(404).json({message:"User is not found"})
        }
    } catch (error) {
        return res.status(500).json({message:error.message})
    }
}
export const updateResponse = async(req,res)=>{
    try {
        const updateInfo = req.body 
        const id = req.params.id
        const response = await ResponseModel.findById(id)
        if(response){
            const updatedresponse = await ResponseModel.findOneAndUpdate(response, {$set: updateInfo})
            res.status(201).json({message:"response updated",updatedresponse})
        }else{
            return res.status(404).json({message:"response not found"})
        }
    } catch (error) {
        res.status(500).json({message:error.message})
    }
    
}
export const deleteResponse = async(req,res)=>{
    try {
        const id = req.params.id
        const response = await ResponseModel.findById(id)
        if(response){
            const adminId = response.issuedby
            const issuedby = await AdminModel.findById(adminId)
            issuedby.myresponses.pull(response)
            await issuedby.save()
            const complaintId = response.forcomplaint
            console.log(`complaintId ${complaintId}`)
            const forcomplaint = await ComplaintModel.findById(complaintId)
            console.log(`forcomplaint ${forcomplaint}`)
            forcomplaint.response = null
            await forcomplaint.save()
            console.log("last")
            await ResponseModel.findByIdAndDelete(response)
            res.status(200).json({message:"Response deleted",deltedResponse:response})
        }else{
            return res.status(404).json({message:"Response not found"})
        }
    } catch (error) {
        res.status(500).json({message:error.message})
    }
    
}
