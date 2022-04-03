import { Express, Request, Response, Router } from "express";
import {
  createOneHandler,
  deleteOneHandler,
  getAllHandler,
  getOneHandler,
  updateOneHandler,
} from "../src/controller/todo.controller";
import { validateTodo } from "../src/middleware/validateTodo";

const router = Router();

//DEFAULT ROUTE
router.get("/", getAllHandler);

//POST METHOD
router.post("/todos", validateTodo, createOneHandler);

//GET METHOD
router.get("/todos/:id", getOneHandler);

//DELETE METHOD
router.delete("/todos/:id", deleteOneHandler);

//PUTH METHOD
router.put("/todos/:id", validateTodo, updateOneHandler);

export default router;
