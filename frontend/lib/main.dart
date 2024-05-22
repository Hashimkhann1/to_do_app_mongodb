import 'package:flutter/material.dart';
import 'package:frontend/dashboard.dart';
import 'package:frontend/loginPage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  runApp(MyApp(token: preferences.getString('token'),));
}

class MyApp extends StatelessWidget {
  final token;
   MyApp({
    @required this.token,
    Key? key,
  }): super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          primaryColor: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: (token != null && JwtDecoder.isExpired(token) == false )?Dashboard(token: token):SignInPage()
    );
  }
}
