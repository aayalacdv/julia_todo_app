import config from 'config'; 
import express from 'express'; 
import routes from '../routes/routes';
import connect from './connection/connect';
import cors from 'cors'; 

const host : string = config.get("host") as string; 
const port : number = config.get("port") as number; 

const app = express(); 

app.use(cors()); 
app.use( express.json()); 
app.use( express.urlencoded({ extended: false})); 

app.listen(port, host, () => {
    console.log(`escuchando en http://${host}:${port}`);
    connect(); 
    routes(app); 
    
})

