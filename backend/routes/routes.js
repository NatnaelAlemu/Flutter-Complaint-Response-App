import express from 'express'
import {getUser} from '../middlewares/getuser.js'
import { createComplaint,getFixedComplaints,getmyFixedComplaints,getAllmyComplaints,getComplaint,getAllComplaints,updateComplaint,deleteComplaint } from '../controllers/complaint.js'
import { getAllUsers,getSingleUser,signUp,login,updateProfile,deleteProfile } from '../controllers/authentication.js'
import{createResponse,getAllResponses,updateResponse,getResponse,deleteResponse} from '../controllers/response.js'

import {authMiddleWare} from '../middlewares/authmiddleware.js'
import dotenv from 'dotenv'
dotenv.config()
const router = express.Router();

router.get('/getallusers',getAllUsers)
router.get('/getuser/:id',getUser,getSingleUser)
router.post('/signup',signUp )
router.post('/login',login)
router.put('/updateprofile/:id',[getUser,authMiddleWare],updateProfile )
router.delete('/deleteprofile/:id',[authMiddleWare,getUser],deleteProfile)
//////////////
router.post('/createcomplaint',createComplaint)
router.get('/getallcomplaints',getAllComplaints)
router.get('/getcomplaint/:id',getComplaint)
router.put('/updatecomplaint/:id',updateComplaint)
router.delete('/deletecomplaint/:id',deleteComplaint)
router.get('/getallmycomplaints/:id',getAllmyComplaints)
router.get('/getmyfixedComplaints/:id',getmyFixedComplaints)
router.get('/getfixedComplaints/',getFixedComplaints)


/////////////////////
router.post('/createresponse',createResponse)
router.get('/getallresponses',getAllResponses)
router.get('/getresponse/:id',getResponse)
router.put('/updateresponse/:id',updateResponse)
router.delete('/deleteresponse/:id',deleteResponse)
export default router