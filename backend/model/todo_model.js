const mongoose = require('mongoose');
const db = require('../config/db');
const UserModel = require('./user_model');

const { Schema } = mongoose;

const todoSchema = Schema({
    userId: {
        type: Schema.Types.ObjectId,
        ref:UserModel.modelName
    },
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