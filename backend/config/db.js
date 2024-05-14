const mongose = require('mongoose');

const mongoConnection = mongose.createConnection('mongodb+srv://hashimkhan199999:<Password>@cluster0.bpgtyqt.mongodb.net/Todo').on('open',() => {
    console.log('Mongodb is Connected');
}).on('error',()=> {
    console.log('Mongodb is not connected error');
});

module.exports = mongoConnection;