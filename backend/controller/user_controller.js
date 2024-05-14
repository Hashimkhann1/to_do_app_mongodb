const UserServices = require('../services/user_services');

exports.register = async (req , res , next) => {
    try{
        const {email , password} = req.body;
        const adad = await UserServices.registerUser(email, password);
        
        res.json({status: true,success: "User register Successfully"});
    }catch(err){
        throw err;
    }
}
