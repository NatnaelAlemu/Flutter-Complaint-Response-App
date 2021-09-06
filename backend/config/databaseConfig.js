import mongoose from 'mongoose'
import dotenv from 'dotenv'
dotenv.config()
export const dbConfig = () => {
    mongoose.connect(process.env.DATABASE_URI, {
        useNewUrlParser: true,
        useUnifiedTopology:true,
    })
    const connection = mongoose.connection
    connection.on('error',(err)=>console.log(err.message))
    connection.once('open',()=>console.log('Database connection success'))
    
}