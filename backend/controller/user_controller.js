const UserServices = require('../services/user_services');
const UserModel = require('../model/user_model')

exports.register = async (req , res , next) => {
    try{
        const {email , password} = req.body;
        const adad = await UserServices.registerUser(email, password);
        
        res.json({status: true,success: "User register Successfully"});
    }catch(err){
        throw err;
    }
}

exports.login = async (req , res , next) => {
    try{
        const {email , password} = req.body;
        
        const user = await UserServices.checkUser(email);

        if(!user){
            throw new Error("User note exist!");
        }

        const isMatch = await user.comparePassword(password);
        if(isMatch === false){
            throw new Error("Password is Invalid");
        }

        let tokenData = {_id:user._id,email:user.email};
        const token = await UserServices.generateToken(tokenData , "secretKey" , "1h");

        res.status(200).json({status:true,token:token});

    }catch(err){
        console.log('error' + err);
        throw err;
        
    }
}
