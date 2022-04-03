import { z } from 'zod'


export const todoSchema = z.object({
    title: z.string({
        required_error: 'title is required',
        invalid_type_error: 'must be a string'
        
    }),
    description: z.string({
        required_error: 'description ir requiered',
        invalid_type_error: 'must be a string'
    }), 
    isDone: z.boolean({
        required_error: 'isDone is required',
        invalid_type_error: 'must be a boolean',
    }).default(false) 
})



