import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/config.dart';
import 'package:frontend/loginPage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Dashboard extends StatefulWidget {
  final token;
  const Dashboard({@required this.token,Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  late String userId;
  late SharedPreferences prefs;
  final TextEditingController titleControleer = TextEditingController();
  final TextEditingController descControleer = TextEditingController();
  List? todosList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String , dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    userId = jwtDecodedToken['_id'];
    getTodos();
  }

  Future addToDo() async {
    if(titleControleer.text.isNotEmpty && descControleer.text.isNotEmpty){
      var regBody = {
        "userId": userId,
        "title" : titleControleer.text.toString(),
        "desc" : descControleer.text.toString(),
      };

      var responce = await http.post(Uri.parse(addtodo),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(regBody)
      );

      var jsonResponce = jsonDecode(responce.body);

      if(jsonResponce['status']){
        titleControleer.clear();
        descControleer.clear();
        Navigator.pop(context);
      }else{
        print("Something went wrong");
      }

    }
}

  Future getTodos() async {
    Map regBody = {"userId": userId};

    var responce = await http.get(Uri.parse("http://10.0.2.2:5000/getUserTodos?userId=$userId"),
      headers: {"Content-Type":"application/json"},
    );
    
    if(responce.statusCode == 200){
      var jsonResponse = jsonDecode(responce.body);
      todosList = jsonResponse['success'];
      setState(() {});
      // print(jsonResponse);
      print(todosList);
    }else{
      print(">>>>>>> error from get todos >>>>>>>>");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed: () async {
            await prefs.remove('token');
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
          }, icon: Icon(Icons.logout,color: Colors.white,))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Expanded(
             child: ListView.builder(
               // itemCount: todosList.length,
              itemBuilder: (context , index) {
             return Container(

             );
             }),
           ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){_displayTextInputDialog(context);},
        tooltip: "Add-ToDo",
        child: Icon(Icons.add,color: Colors.white,),backgroundColor: Colors.green,),
    );
  }
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add To-Do"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleControleer,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
                const SizedBox(height: 8,),
                TextField(
                  controller: descControleer,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Descripition",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
                const SizedBox(height: 8,),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green
                  ),
                  onPressed: (){
                    addToDo();

                  },
                  child: Text("Add",style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          );
        });
  }
}