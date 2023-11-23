import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'otp.dart';
import 'get_otp_res_data.dart';

import 'login.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController useridController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  List<dynamic> users = [];

  void changepassword(String user_id, password) async {
    try {
      http.Response response = await http.post(
          Uri.parse(
              'https://vinsupinfotech.com/FMS/public/api/change_password'),
          body: {
            'user_id': user_id,
            'password': password,
          });

      if (response.statusCode == 200) {
        print('Reset Password Successfully ');
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
            ' Changed Password Successully',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          message: '  👍',
          duration: Duration(seconds: 3),
        ).show(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      } else {
        print('Failed');
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
            'Invalid UserID',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          message: 'Enter the proper UserID',
          duration: Duration(seconds: 3),
        ).show(context);
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

  @override
  void initState() {
    setState(() {
      useridController = new TextEditingController(text: Otp.userId.toString());
    });
    // TODO: implement initState
    super.initState();
  }

  void _tog() {
    setState(() {
      _obsText = !_obsText;
    });
  }

  late String _password, _confirmPassword, _userid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Column(children: <Widget>[
        Hero(
          tag: 'login8',
          child: Container(
            margin: EdgeInsets.only(top: 50.0, left: 10.0),
            child: Image.asset('images/login21.png'),
            height: 200.0,
          ),
        ),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    Text('User Id'),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      controller: useridController,
                      autovalidateMode: AutovalidateMode.always,
                      readOnly: true,

                      validator: (value) =>
                          value!.isEmpty ? 'please enter Userid' : null,
                      onSaved: (value) => _userid = value!,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle_outlined,
                            color: Color.fromRGBO(50, 62, 72, 1.0)),
                        hintText: Otp.userId.toString(),
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
                      height: 15.0,
                    ),
                    Text('Confirm Password'),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      controller: cpasswordController,
                      autofocus: false,
                      obscureText: _obsText,
                      validator: (value) => value!.isEmpty
                          ? 'Please enter confirm password '
                          : null,
                      onSaved: (value) => _confirmPassword = value!,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock,
                            color: Color.fromRGBO(50, 62, 72, 1.0)),
                        // prefixIcon: IconButton(
                        //   onPressed: _tog,
                        //   icon: Icon(_obsText ? Icons.lock_open : Icons.lock),
                        // ),
                        suffixIcon: IconButton(
                          onPressed: _tog,
                          icon: Icon(_obsText
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        hintText: 'Retype Password',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      // buildInputDecoration("Enter Confirm Password", Icons.lock),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    MaterialButton(
                      onPressed: () {
                        final form = _formKey.currentState;
                        if (_formKey.currentState!.validate()) {
                          if (passwordController.text !=
                              cpasswordController.text) {
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
                              message: 'Enter the same password',
                              duration: Duration(seconds: 10),
                            ).show(context);
                          } else {
                            changepassword(useridController.text.toString(),
                                passwordController.text.toString());
                          }
                        }
                      },
                      textColor: Colors.white,
                      color: Colors.indigo,
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Change Password',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      height: 45,
                      minWidth: 800,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  ]),
            ),
          ),
        ),
      ]),
    );
  }
}
