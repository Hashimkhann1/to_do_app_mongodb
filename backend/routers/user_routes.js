const router = require('express').Router();
const userController = require('../controller/user_controller');

router.post('/registration',userController.register);

module.exports = router