import express from 'express'
import {getUser} from '../middlewares/getuser.js'
import { getAllUsers,getSingleUser,signUp,login,updateProfile,deleteProfile } from '../controllers/auth.js'
import {authMiddleWare} from '../middlewares/authmiddleware.js'
import dotenv from 'dotenv'
dotenv.config()
const router = express.Router();

router.get('/getall',getAllUsers)
router.get('/:id',getUser,getSingleUser)
router.post('/signup',signUp )

router.post('/login',login)
router.put('/updateprofile/:id',[getUser,authMiddleWare],updateProfile )
router.delete('/deleteprofile/:id',[authMiddleWare,getUser],deleteProfile)
export default router