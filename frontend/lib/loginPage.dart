
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/dashboard.dart';
import 'package:frontend/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'applogo.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPreferences();
  }

  void initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }


  void loginUser() async {
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){

      var registerBody = {
        "email" : emailController.text,
        "password" : passwordController.text
      };

      var responce = await http.post(Uri.parse(login),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(registerBody)
      );

      var jsonResponce = jsonDecode(responce.body);
      if(jsonResponce['status']){
        var myToken = jsonResponce['token'];
        prefs.setString('token', myToken);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(token: myToken)));
      }else{
        print('Some thing went wrong');
      }

    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // CommonLogo(),
                  // HeightBox(10),
                  Text("Sign in" ,style: TextStyle(color: Colors.green,fontSize: 30,fontWeight: FontWeight.bold),),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Email",
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ).p4().px24(),
                  TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Password",
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ).p4().px24(),

                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.02,),
                  GestureDetector(
                    onTap: (){
                      loginUser();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.sizeOf(context).width * 0.50, 
                        height: MediaQuery.sizeOf(context).width * 0.10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.green
                      ),
                        child: Text("Sign in",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight:FontWeight.w600),))
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Registration()));
          },
          child: Container(
            alignment: Alignment.center,
              height: 25,
              // color: Colors.lightBlue,
              child: Text("Create a new Account..! Sign Up",style: TextStyle(color: Colors.black,fontSize: 18),)
          ),
        ),
      ),
    );
  }
}
