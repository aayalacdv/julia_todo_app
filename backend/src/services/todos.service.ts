import { ITodo } from "../models/todos.model";
import Todo from "../models/todos.model";

//Definimos funciones para hacer queries a la base de datos y manejar los posibles errores
//Get all Todos
export async function getAllTodos() : Promise<ITodo[]>{
  return Todo.find().catch((error : any) => {
    console.error("Error encontrando libros", error);
  });
}

//Create Todo
export async function createTodo(todo: ITodo) : Promise<ITodo | void>{
//creamos un libro pasándole un objeto de la interfaz definida anteriormente
  return Todo.create(todo).catch((error : any) => {
    console.error("Error crando un libro ", error);
  });
}

//Get a Todo for id :
export async function getTodo(todoId: string) : Promise<ITodo | void >{
//Devolvemos un libro con un id determinado 
  return Todo.findById(todoId).catch((error : any) => {
    console.error("Error encontradndo todo con id: " + todoId, error);
  });
}

//Delete Todo
export async function deleteTodo(todoId: string) : Promise<ITodo | void>{
//borramos el libro en el id determinado
  return Todo.findOneAndDelete( { _id : todoId} )
  .catch((error : any) => {
    console.error("Error borrando libro con id: " + todoId, error);
  });
}

//Update a Todo
export async function updateTodo(todo: ITodo, todoId: string) : Promise<ITodo | void> {
    //pasamos un filtro para la base de datos primero en este caso es el id del libro que queremos cambiar 
    //lo segundo es un objeto con las propiedades que queramos cambiar en este caso enviaremos todo un libro pero podría ser solo el nombre por ejemplo
  return Todo.findByIdAndUpdate(
    todoId ,
    todo, { 
      returnDocument: "after",
      new: true,
      useFindAndModify: false } 
  )
    .catch((error : any) => {
      console.error("Error borrando todo con id: " + todoId, error);
    });
}
