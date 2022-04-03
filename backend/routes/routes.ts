import { Express } from "express";
import todoRouter from "./todo.routes";

export default function routes ( app: Express){

    app.use('/api',todoRouter); 

}

