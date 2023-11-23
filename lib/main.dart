import 'package:flutter/material.dart';
import 'package:login_demo/forget_password.dart';
import 'login.dart';
import 'register.dart';
import 'forget_password.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login Registration',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: Login(),
        routes: {
          '/login': (context) => Login(),
          '/register': (context) => Register(),
          // '/forget_password': (context) => ForgetPassword(),
        });
  }
}
