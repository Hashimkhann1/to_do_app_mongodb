const express = require('express');
const bodyParser = require('body-parser');
const userRouter = require('./routers/user_routes');
const todoRouter = require('./routers/todo_routes');

const app = express();

app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());
app.use("/",userRouter);
app.use("/",todoRouter);

module.exports = app;
