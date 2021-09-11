import express from 'express'
import dotenv from 'dotenv'
import Router from './routes/routes.js'
import {dbConfig} from './config/databaseConfig.js'
dotenv.config()
const app = express();
app.use(express.json())
dbConfig()

app.use('/api',Router)

app.listen(process.env.PORT,()=>console.log(`Server is listening at http://localhost://${process.env.PORT}`))