import { ITodo} from "../models/todos.model";
import {
  createTodo,
  deleteTodo,
  getAllTodos,
  getTodo,
  updateTodo,
} from "../services/todos.service";
import { Request, Response } from "express";

//el controlador es otro fichero donde separamos más la lógica de la app, en este caso lidiamos con las peticiones del cliente
//pasamos los objetos de request y response para poder responder a cada peticion del cliente

export async function getAllHandler (req: Request, res: Response) {
  const results = await getAllTodos();
  return res.send(results).status(200);
}

export async function createOneHandler(req: Request, res: Response) {
  const todo = req.body as ITodo;
  console.log(req.body);
  await createTodo(todo)
    .then((result) => {
      if(result) return res.json(result).status(201);
      return res.status(403).send({mensaje : "Cuerpo inválido"}); 
    })
    .catch((error: any) => {
      return res.status(500).send({ Error: error });
    });
}

export async function getOneHandler(req: Request, res: Response) {
  const id = req.params.id;
  await getTodo(id)
    .then((todo) => {
      if (todo) return res.json(todo).status(200);
      return res.status(404).send({mensaje: "Todo no encontrado"});
    })
    .catch((error) => res.status(500).send("Error del servidor"));
}


export async function deleteOneHandler(req: Request, res: Response) {
  const id = req.params.id;
  await deleteTodo(id)
    .then((todo: any) => {
      if(!todo){
        return res.status(404).send({mensaje: "libro no encontrado"}); 
      }else {
        return res.status(200).send({ Mensaje: "Libro borrado con éxito" });
      }
    })
    .catch((error) => res.status(500).send("Error"));
}


export async function updateOneHandler(req: Request, res: Response) {
  const id = req.params.id;
  const todo = req.body as ITodo;
  
  await updateTodo(todo, id)
    .then((result: any) => {
      if (result) return res.status(200).json(result);
      return res.status(404).send({ mensaje: "Libro no encontrado " }); 
    })
    .catch((error) => res.status(500).send(error));
}
