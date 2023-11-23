import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'forget_password.dart';
import 'change_password.dart';
import 'get_otp_res_data.dart';

class Otp extends StatefulWidget {
  static var userId;
  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();
  TextEditingController otpController5 = TextEditingController();
  TextEditingController otpController6 = TextEditingController();

  void otp(String email, otp) async {
    try {
      var getotpuri = Uri.https('www.vinsupinfotech.com',
          '/FMS/public/api/get_otp', {'email': email, 'otp': otp});
      debugPrint("${getotpuri}");
      http.Response response = await http.post(getotpuri);
      debugPrint("${response.body}");
      if (jsonDecode(response.body) == "OTP Invalid") {
        print('failed');

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
            'Invalid OTP',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          message: 'Please enter proper OTP',
          duration: Duration(seconds: 3),
        ).show(context);
      } else {
        try {
          var jsonDecodeResponse = jsonDecode(response.body);
          GetOtpResData getOtpResData =
              GetOtpResData.fromJson(jsonDecodeResponse);
          Otp.userId = getOtpResData.details?.userId;

          if (getOtpResData.status == "OTP Valid") {
            print("Otp Verified");
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => ChangePassword(),
              ),
            );
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  late Timer countdownTimer;
  bool invalidOtp = false;
  int resendTime = 60;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        resendTime = resendTime - 1;
      });
      if (resendTime < 1) {
        countdownTimer.cancel();
      }
    });
  }

  stopTimer() {
    if (countdownTimer.isActive) {
      countdownTimer.cancel();
    }
  }

  String strFormatting(n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.indigo.shade100,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('OTP Verification'),
        ),
        body: Column(children: <Widget>[
          // Image.asset('images/login3.png'),
          Hero(
            tag: 'login12',
            child: Container(
              margin: EdgeInsets.only(top: 50.0),
              child: Image.asset('images/login8.png'),
              height: 220.0,
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
                      'Verification Code',
                      style: TextStyle(
                        fontSize: 40.0,
                        //fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    SizedBox(
                      height: 60.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        myInputBox(context, otpController1),
                        myInputBox(context, otpController2),
                        myInputBox(context, otpController3),
                        myInputBox(context, otpController4),
                        myInputBox(context, otpController5),
                        myInputBox(context, otpController6)
                      ],
                    ),
                    SizedBox(height: 40),
                    /* Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Haven't received OTP yet?",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: 10),
                        resendTime == 0
                            ? InkWell(
                                onTap: () {
                                  // Resend OTP Code
                                  invalidOtp = false;
                                  resendTime = 60;
                                  startTimer();
                                  //
                                },
                                child: Text(
                                  'Resend',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : SizedBox()
                      ],
                    ),
                    const SizedBox(height: 10),
                    resendTime != 0
                        ? Text(
                            'You can resend OTP after ${strFormatting(resendTime)} second(s)',
                            style: TextStyle(fontSize: 18),
                          )
                        : SizedBox(),
                    SizedBox(height: 5),
                    Text(
                      invalidOtp ? 'Invalid otp!' : '',
                      style: const TextStyle(fontSize: 20, color: Colors.red),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 30.0,
                    ),*/
                    MaterialButton(
                      onPressed: () {
                        final otps = otpController1.text +
                            otpController2.text +
                            otpController3.text +
                            otpController4.text +
                            otpController5.text +
                            otpController6.text;

                        final form = _formKey.currentState;
                        if (_formKey.currentState!.validate()) {
                          form?.save();
                        }
                        if (otpController1.text.isNotEmpty &&
                            otpController2.text.isNotEmpty &&
                            otpController3.text.isNotEmpty &&
                            otpController4.text.isNotEmpty &&
                            otpController5.text.isNotEmpty &&
                            otpController6.text.isNotEmpty) {
                          otp(ForgetPassword.emailController.text.toString(),
                              otps.toString());
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ChangePassword()));
                        } else if (otpController1.text.isEmpty ||
                            otpController2.text.isEmpty ||
                            otpController3.text.isEmpty ||
                            otpController4.text.isEmpty ||
                            otpController5.text.isEmpty ||
                            otpController6.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Alert"),
                              content: const Text("Enter OTP"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Container(
                                    // color: Colors.green,
                                    padding: const EdgeInsets.all(14),
                                    child: const Text("okay"),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      textColor: Colors.white,
                      color: Colors.indigo,
                      child: SizedBox(
                        width: 300,
                        child: Text(
                          'Submit',
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

Widget myInputBox(BuildContext context, TextEditingController controller) {
  return Container(
    height: 50,
    width: 40,
    decoration: BoxDecoration(
      border: Border.all(width: 1),
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    child: TextField(
        controller: controller,
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 35),
        decoration: InputDecoration(
          counterText: '',
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        }),
  );
}
