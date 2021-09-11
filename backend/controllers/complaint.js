import ComplaintModel from '../models/complaint.js'
import ComplainantModel from '../models/complainant.js'
import ResponseModel from '../models/response.js'
export const createComplaint = async(req,res)=>{
    console.log(req.body)

    try {
        const complaintInfo = req.body
        console.log("complaint info")
        console.log(complaintInfo)
        const complaint = await ComplaintModel.create(complaintInfo)
       if(complaint){
            const madeby = await ComplainantModel.findOne({_id:complaintInfo.madeby})
            if(madeby){
                madeby.mycomplaints.push(complaint)
                await madeby.save()
              return res.status(201).json({complaint})
            }else{
                return res.status(403).json({message:"user doesn't exist"})
            }
            
       }
       return res.status(403).json({message:"Failed to create Complaint"})
        
    } catch (error) {
        console.log(error.message)
        return res.status(500).json({message:error.message})
    }

}

export const getAllComplaints = async(req,res)=>{
    console.log("complaint request is comming")
    try { 
        const allcomplaints =await ComplaintModel.find()
        const allcomplantswithUser = [] 
        console.log(allcomplaints)
        if(allcomplaints.length>0){
            allcomplaints.map(async(complaint,index)=>{
                const user = await ComplainantModel.findById(complaint.madeby)
                if(!complaint.fixed){
                allcomplantswithUser.push({...complaint,name:user.fullName})}
                if(index == allcomplaints.length - 1){
                     console.log('all complaints')
                    console.log(allcomplantswithUser)
                    return res.status(200).json({allcomplaints:allcomplantswithUser})
                }
            })  

        }
        else {return res.status(200).json({allcomplaints})}
    } catch (error) {
        return res.status(500).json({message:error.message})
    }
}
export const getFixedComplaints = async(req,res)=>{
    console.log("fixed complaint request is comming")
    try { 
        const allcomplaints =await ComplaintModel.find()
        const allcomplantswithUser = [] 
        console.log('allcomplaints')
        console.log(allcomplaints)
        
        if(allcomplaints.length>0){
            allcomplaints.map(async(complaint,index)=>{
                const user = await ComplainantModel.findById(complaint.madeby)
                if(complaint.fixed){
                    console.log('true')
                const rep = await ResponseModel.findById(complaint.response)
                console.log('all complaints length')
                allcomplantswithUser.push({...complaint,response:rep,name:user.fullName})
                console.log(allcomplantswithUser.length)
                console.log(`index ${index}`)
                console.log(`all complaints idex ${allcomplaints.length}`)
            }
                if(index == 0){
                    console.log("last")
                    console.log(allcomplantswithUser.length)
                    return res.status(200).json({allcomplaints:allcomplantswithUser})
                }
            })  

        }
        else {return res.status(200).json({allcomplaints})}
    } catch (error) {
        return res.status(500).json({message:error.message})
    }
}













export const getAllmyComplaints = async(req,res)=>{
    try{
        const id = req.params.id
        console.log(`id ${id}`)

        const user = await ComplainantModel.findById(id);
        if(user){
            const myCompliantIds = user.mycomplaints
            const mycomplaints = []
            if(myCompliantIds.length > 0){
            myCompliantIds.map(async(id,index)=>{
                const complaint = await ComplaintModel.findById(id)
                mycomplaints.push(complaint)
                if(index == myCompliantIds.length - 1){
                return res.status(200).json({mycomplaints})
                }
            })
        } else{return res.status(200).json({mycomplaints}) }
        }else{
            return res.status(404).json({message:"user doen't exist"})
        }

    }catch(e){
        console.log(e.message)
        return res.send(500).json({message:e.message})
    }
}

export const getmyFixedComplaints = async(req,res)=>{
    try{
        const id = req.params.id
        const user = await ComplainantModel.findById(id);
        console.log(user)
        if(user){
            const myCompliantIds = user.mycomplaints
            const myfixedcomplaints = []
            if(myCompliantIds.length > 0){
            myCompliantIds.map(async(id,index)=>{
                const complaint = await ComplaintModel.findById(id)
                if(complaint.fixed){
                const responseId = complaint.response
                const response = await ResponseModel.findById(responseId)
                const responseInfo = {complaint,response}
                myfixedcomplaints.push(responseInfo)
            }
                console.log(`Fixed ${complaint.fixed}`)
                console.log(myfixedcomplaints)
                if(index == myCompliantIds.length - 1){
                return res.status(200).json({myfixedcomplaints})
                }
            })
        }else return res.status(200).json({myfixedcomplaints})
        }else{
            return res.status(404).json({message:"user doen't exist"})
        }

    }catch(e){
        console.log(e.message)
        return res.send(500).json({message:e.message})
    }
}






export const getComplaint = async(req,res)=>{

    try {
        
        const id = req.params.id
        const complaint =await ComplaintModel.findById(id)
        if(complaint){
            return res.status(200).json({complaint})
        }else{
            return res.status(404).json({message:"Complaint is not found"})
        }
    } catch (error) {
        return res.status(500).json({message:error.message})
    }
}
export const updateComplaint = async(req,res)=>{
    try {
        const updateInfo = req.body 
        const id = req.params.id
        console.log("update request is commig")
        const complaint = await ComplaintModel.findById(id)
        if(complaint){
            const updatedComplaint = await ComplaintModel.findByIdAndUpdate(complaint.id, {$set: updateInfo})
            console.log(`Complaint updated",${updatedComplaint}`)
            res.status(201).json({message:"Complaint updated",updatedComplaint})
        }else{
            return res.status(404).json({message:"Complaint not found"})
        }
    } catch (error) {
        res.status(500).json({message:error.message})
    }
    
}
export const deleteComplaint = async(req,res)=>{
    try {
        console.log("delete request is commig")
        const id = req.params.id
        const complaint = await ComplaintModel.findById(id)
        if(complaint){
            const userId = complaint.madeby
            const wasmadeby = await ComplainantModel.findById(userId)
            wasmadeby.mycomplaints.pull(complaint)
            await wasmadeby.save()
            await ComplaintModel.findByIdAndDelete(complaint)
            res.status(200).json({message:"Complaint delted",deltedComplaint:complaint})
        }else{
            return res.status(404).json({message:"Complaint not found"})
        }
    } catch (error) {
        res.status(500).json({message:error.message})
    }
    
}
