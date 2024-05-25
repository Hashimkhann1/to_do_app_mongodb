const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const todoSchema = Schema({
    title: {
        type:String
    },
    desc:{
        type:String,
        require:true
    },
    date:{
        type: Date,
        default: Date.now
    }
});

const ToDoModel = db.model('todo',todoSchema);
module.exports = ToDoModel;