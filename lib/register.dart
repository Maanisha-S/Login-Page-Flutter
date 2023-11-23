import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
//import 'validator.dart';
import 'package:email_validator/email_validator.dart';
import 'widget.dart';
import 'package:http/http.dart' as http;
import 'package:another_flushbar/flushbar.dart';
import 'login.dart';

class Register extends StatefulWidget {
  static TextEditingController emailController = TextEditingController();
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController c_passwordController = TextEditingController();

  void login(String email, password, c_password, name) async {
    try {
      http.Response response = await http.post(
          Uri.parse('https://vinsupinfotech.com/FMS/public/api/register'),
          body: {
            'name': name,
            'email': email,
            'password': password,
            'c_password': c_password,
          });
      if (response.statusCode == 200) {
        print('Register Sucessfully ');
        Flushbar(
          backgroundGradient: LinearGradient(
            colors: [
              Colors.indigo.shade500,
              Colors.indigo.shade300,
              Colors.indigo.shade100
            ],
            stops: [0.4, 0.7, 1],
          ),
          icon: Icon(
            Icons.email_outlined,
            color: Colors.black,
            size: 30,
          ),
          titleText: Text(
            'Register Successully',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          message: '  👍',
          duration: Duration(seconds: 5),
        ).show(context);
      } else {
        print('Failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  bool _obscureText = true;
  bool _obsText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _tog() {
    setState(() {
      _obsText = !_obsText;
    });
  }

  final _formKey = GlobalKey<FormState>();
  late String _username, _email, _password, _confirmPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Column(
        children: <Widget>[
          // Image.asset('images/login3.png'),
          Hero(
            tag: 'login',
            child: Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Image.asset('images/login23.png'),
              height: 150.0,
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
                    Text('Username'),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      controller: usernameController,
                      autofocus: true,
                      validator: (value) =>
                          value!.isEmpty ? 'Your Username is required' : null,
                      onSaved: (value) => _username = value!,
                      decoration: buildInputDecoration(
                          "Enter Username", Icons.account_box_rounded),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text('Email'),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      controller: emailController,
                      autofocus: false,
                      // validator: (value) =>
                      //     value!.isEmpty ? 'Your Email is required' : null,
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Enter a valid email'
                              : null,
                      onSaved: (value) => _email = value!,
                      decoration:
                          buildInputDecoration("Enter Email", Icons.email),
                    ),
                    SizedBox(
                      height: 10.0,
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
                      //     value!.isEmpty ? 'Please enter password' : null,
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
                      //buildInputDecoration("Enter Password", Icons.lock),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text('Confirm Password'),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      controller: c_passwordController,
                      autofocus: false,
                      obscureText: _obsText,
                      validator: (value) =>
                          value!.isEmpty ? 'Your password is required' : null,

                      onSaved: (value) => _confirmPassword = value!,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock,
                            color: Color.fromRGBO(50, 62, 72, 1.0)),
                        suffixIcon: IconButton(
                          onPressed: _tog,
                          icon: Icon(_obsText
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        hintText: 'Enter Confirm Password',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      // buildInputDecoration("Enter Confirm Password", Icons.lock),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    MaterialButton(
                      onPressed: () {
                        print('on doRegister');

                        final form = _formKey.currentState;
                        if (_formKey.currentState!.validate()) {
                          form?.save();
                          login(
                              emailController.text.toString(),
                              passwordController.text.toString(),
                              c_passwordController.text.toString(),
                              usernameController.text.toString());

                          //   print(_username);
                          //   print(_password);
                          //   print(_confirmPassword);
                          //    login(emailController.text.toString(),
                          //        passwordController.text.toString(),c_passwordController.text.toString());
                          if (_password != (_confirmPassword)) {
                            Flushbar(
                              backgroundGradient: LinearGradient(
                                colors: [
                                  Colors.grey.shade500,
                                  Colors.grey.shade300,
                                  Colors.grey.shade100
                                ],
                                stops: [0.4, 0.7, 1],
                              ),
                              title: 'Mismatch',
                              message: c_passwordController.text.toString(),
                              duration: Duration(seconds: 10),
                            ).show(context);
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          }
                        } else {
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
                              'Invalid Form',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            message: 'Please Complete form properly',
                            duration: Duration(seconds: 3),
                          ).show(context);
                        }
                      },
                      textColor: Colors.white,
                      color: Colors.indigo,
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Register',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      height: 45,
                      minWidth: 600,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          // padding: EdgeInsets.all(0.0),

                          child: Text("Next",
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          onPressed: () {
                            //Navigator.pushReplacementNamed(context, '/forget-password');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
