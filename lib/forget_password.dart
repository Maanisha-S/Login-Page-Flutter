import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'otp.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;

class ForgetPassword extends StatefulWidget {
  static TextEditingController emailController = TextEditingController();
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  void forgetPassword(String email) async {
    try {
      http.Response response = await http.post(
          Uri.parse('https://vinsupinfotech.com/FMS/public/api/forgot'),
          body: {
            'email': email,
          });
      if (response.statusCode == 200) {
        print('Forget Password Sucessfully ');
        Navigator.push(context, MaterialPageRoute(builder: (context) => Otp()));
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
          icon: Icon(
            Icons.email_outlined,
            color: Colors.black,
            size: 30,
          ),
          titleText: Text(
            'Not Register',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          message: 'Please enter proper email',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ).show(context);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  late String _email;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.indigo.shade100,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Forget Password'),
        ),
        body: Column(children: <Widget>[
          // Image.asset('images/login3.png'),
          Hero(
            tag: 'login',
            child: Container(
              margin: EdgeInsets.only(top: 50.0),
              child: Image.asset('images/login12.png'),
              height: 250.0,
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
                    Text(
                      'Enter your Email and we will send you a OTP... ',
                      style: TextStyle(
                        fontSize: 20.0,
                        //fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                        controller: ForgetPassword.emailController,
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? 'Enter a valid email'
                                : null,
                        onSaved: (value) => _email = value!,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email,
                              color: Color.fromRGBO(50, 62, 72, 1.0)
                              //color: Colors.indigo,
                              ),
                          hintText: 'Email',
                          // contentPadding:
                          //     EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(20.0)),
                        )),
                    SizedBox(
                      height: 30.0,
                    ),
                    MaterialButton(
                      onPressed: () {
                        final form = _formKey.currentState;
                        if (_formKey.currentState!.validate()) {
                          form?.save();
                          forgetPassword(
                              ForgetPassword.emailController.text.toString());
                        }
                        // Navigator.push(context,
                        // MaterialPageRoute(builder: (context) => Otp()));
                      },
                      textColor: Colors.white,
                      color: Colors.indigo,
                      child: SizedBox(
                        width: 300,
                        child: Text(
                          'Reset Password',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      height: 45,
                      minWidth: 800,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}
