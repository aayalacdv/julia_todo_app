import mongoose, { Schema, Model, Document } from "mongoose";

//Primeramente creamos una interfaz con los datos del modelo
//es aconsejable exportar la interfaz para poder usarla en otros archivos
export interface ITodo extends Document {
  title: string;
  description: string;
  isDone: boolean;
}


//Cremaos un schema y lo asignamos al tipo de la interfaz anterior
const todosSchema = new Schema<ITodo>(
  {
//Definimos las propiedades que pusimos antes en la interfaz
    title: { type: String, required: true },
    description: { type: String, required: true },
    isDone: { type: Boolean, default: false, required: true, min: 0 },
  },
//podemos pasar otro objeto de manera opcional con otras propiedades que pone la librería
  { timestamps: true }
);


// definimos un modelo que es lo que usaremos para hacer queries a la base de datos y lo que tendrá toddas las propiedades definidas antes. 
const Todos = mongoose.model('Todos',todosSchema); 

export default Todos; 
