import mongoose from "mongoose";
import config from 'config';


const dbUri : string = config.get('dbUri') as string; 
const connect = async () => {
    await mongoose.connect(dbUri)
    .then(() => {
        console.log("Conexión establecida ^^ !"); 
    })
    .catch((error) => {
        console.log("Error de conexión con la base de datos :( "); 
    })
}

export default connect; 

