
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'applogo.dart';
import 'loginPage.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;

  void registerUser() async {
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){

      var registerBody = {
        "email" : emailController.text,
        "password" : passwordController.text
      };

      var responce = await http.post(Uri.parse(registration),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(registerBody)
      );

      var jsonResponce = jsonDecode(responce.body);

      if(jsonResponce['status']){
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
      }else{
        print("Something went wrong");
      }

    }else{
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Sign Up" ,style: TextStyle(color: Colors.green,fontSize: 30,fontWeight: FontWeight.bold),),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        errorStyle: const TextStyle(color: Colors.white),
                        errorText: _isNotValidate ? "Enter email" : null,
                        hintText: "Email",
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ).p4().px24(),
                  TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(icon: const Icon(Icons.copy),onPressed: (){
                          final data = ClipboardData(text: passwordController.text);
                          Clipboard.setData(data);
                        },),
                        prefixIcon: IconButton(icon: const Icon(Icons.password),onPressed: (){
                          String passGen =  generatePassword();
                          passwordController.text = passGen;
                          setState(() {

                          });
                        },),
                        filled: true,
                        fillColor: Colors.white,
                        errorStyle: const TextStyle(color: Colors.white),
                        errorText: _isNotValidate ? "Enter password" : null,
                        hintText: "Password",
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ).p4().px24(),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.02,),
                  GestureDetector(
                      onTap: ()=>{
                        registerUser()
                      },
                      child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.sizeOf(context).width * 0.50,
                          height: MediaQuery.sizeOf(context).width * 0.10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.green
                          ),
                          child: Text("Sign up",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight:FontWeight.w600),))
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInPage()));
                    },
                    child: HStack([
                      "Already Registered?".text.make(),
                      " Sign In".text.green800.make()
                    ]).centered(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String generatePassword() {
  String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  String lower = 'abcdefghijklmnopqrstuvwxyz';
  String numbers = '1234567890';
  String symbols = '!@#\$%^&*()<>,./';

  String password = '';

  int passLength = 20;

  String seed = upper + lower + numbers + symbols;

  List<String> list = seed.split('').toList();

  Random rand = Random();

  for (int i = 0; i < passLength; i++) {
    int index = rand.nextInt(list.length);
    password += list[index];
  }
  return password;
}
