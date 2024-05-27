const app = require('./app');
const db = require('./config/db')
const userModel = require('./model/user_model');
const TodoModel = require('./model/todo_model');

app.get('/',(req , res) => {
    res.send("Hi, server is connected :)");
});

const port = 5000;

app.listen(port,() => {
    console.log('Server is running on port: ' + port);
})