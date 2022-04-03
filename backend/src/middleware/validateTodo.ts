import { todoSchema } from "./../schemas/todo.schema";
import { Request, Response, NextFunction } from "express";

export async function validateTodo(req: Request, res: Response, next: NextFunction) {
  try {
    todoSchema.parse(req.body);
    next();
  } catch (error: any) {
      return res.status(400).send({message : error.message}); 
  }

}
