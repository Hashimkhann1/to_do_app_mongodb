const router = require('express').Router();
const todoController = require('../controller/todo_controller');


router.post('/createTodo',todoController.createTodo);
router.get('/getUserTodos',todoController.getUserTodos);

module.exports = router;