import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:login_demo/register.dart';
import 'widget.dart';
import 'forget_password.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'register.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, password) async {
    try {
      Response response = await post(
          Uri.parse('https://vinsupinfotech.com/FMS/public/api/login'),
          body: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Login successfully');
        Flushbar(
          backgroundGradient: LinearGradient(
            colors: [
              Colors.indigo.shade500,
              Colors.indigo.shade300,
              Colors.indigo.shade100
            ],
            stops: [0.4, 0.7, 1],
          ),
          titleText: Text(
            ' Login Successully',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          message: '  👍',
          duration: Duration(seconds: 3),
        ).show(context);
      } else {
        print('failed');
        if (response.statusCode == 401) {
          Flushbar(
            backgroundGradient: LinearGradient(
              colors: [
                Colors.red.shade500,
                Colors.red.shade300,
                Colors.red.shade100
              ],
              stops: [0.4, 0.7, 1],
            ),
            titleText: Text(
              'check your email and password',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            message: 'Please enter proper email and password',
            duration: Duration(seconds: 3),
          ).show(context);
        }

        /*ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Account not register'),
          ),
        );*/
      }
    } catch (e) {
      print(e.toString());
    }
  }

  final _formKey = GlobalKey<FormState>();
  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ElevatedButton(
          // padding: EdgeInsets.all(0.0),
          child: Text("Forgot password?",
              style: TextStyle(
                  color: Colors.black45, fontWeight: FontWeight.w500)),
          onPressed: () {
            //Navigator.pushReplacementNamed(context, '/forget-password');
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ForgetPassword()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        ElevatedButton(
          //padding: EdgeInsets.only(left: 0.0),
          child: Text("Sign up",
              style: TextStyle(
                  color: Colors.black45, fontWeight: FontWeight.w500)),
          onPressed: () {
            //Navigator.pushReplacementNamed(context, '/register');
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Register()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ],
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(children: <Widget>[
        // Image.asset('images/login3.png'),
        Hero(
          tag: 'login',
          child: Container(
            margin: EdgeInsets.only(top: 50.0),
            child: Image.asset('images/login23.png'),
            height: 170.0,
          ),
        ),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(40.0),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5.0,
                    ),
                    Text('Email'),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      controller: emailController,
                      autofocus: false,
                      // validator: EmailValidator.validate,
                      // validator: (value) =>
                      //     value!.isEmpty ? 'Your Email is required' : null,
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Enter a valid email'
                              : null,
                      onSaved: (value) => _email = value!,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email,
                            color: Color.fromRGBO(50, 62, 72, 1.0)),
                        hintText: 'Enter Email',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text('Password'),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      controller: passwordController,
                      autofocus: false,
                      obscureText: _obscureText,
                      // validator: (value) =>
                      //     value!.isEmpty ? 'Please Enter password' : null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value!,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock,
                            color: Color.fromRGBO(50, 62, 72, 1.0)),
                        suffixIcon: IconButton(
                          onPressed: _toggle,
                          icon: Icon(_obscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        hintText: 'Enter Password',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      // buildInputDecoration('Enter Password', Icons.lock),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    //longButtons('Login', doLogin),
                    MaterialButton(
                      onPressed: () {
                        final form = _formKey.currentState;
                        if (form!.validate()) {
                          form.save();
                          login(emailController.text.toString(),
                              passwordController.text.toString());
                        }
                      },
                      textColor: Colors.white,
                      color: Colors.indigo,
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          'login',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      height: 45,
                      minWidth: 800,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    forgotLabel,
                  ]),
            ),
          ),
        ),
      ]),
    );
  }
}
