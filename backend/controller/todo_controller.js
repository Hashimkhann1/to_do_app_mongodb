const TodoServices = require('../services/todo_services');


exports.createTodo = async (req,res,next) => {
    try {
        const {userId , title , desc} = req.body;

        const todo = TodoServices.createTodo(userId , title , desc);
        res.json({status:true,success:todo});

    } catch (error) {
        next(error);
        throw error;
    }
}


exports.getUserTodos = async (req,res,next) => {
    try {

        const {userId} = req.query;
        let todo = await TodoServices.gettodos(userId);
        
        res.json({status:true,success:todo});
    } catch (error) {
        throw error;
    }
}