const UserModel = require('../model/user_model');
const jwt = require('jsonwebtoken');

class UserServices {

    /// register user method
    static async registerUser(email , password) {
        try{
            const createUser = new UserModel({email,password});
            return await createUser.save();
        }catch(error){
            throw error;
        }
    }

    /// login method but checking thata user exist or not with enter email
    static async checkUser(email) {
        try{
            return await UserModel.findOne({email});
        }catch(err){
            throw err;
        }
    }

    static async generateToken(tokenData , secretKey , jwt_expire) {
        return jwt.sign(tokenData , secretKey , {expiresIn: jwt_expire})
    }

}

module.exports = UserServices;