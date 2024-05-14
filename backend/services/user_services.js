const UserModel = require('../model/user_model');

class UserServices {

    static async registerUser(email , password) {
        try{
            const createUser = new UserModel({email,password});
            return await createUser.save();
        }catch(error){
            throw error;
        }
    }

}

module.exports = UserServices;