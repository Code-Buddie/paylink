import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paylink_app/shared/api_constants.dart';
import 'package:paylink_app/shared/color_constants.dart';
import 'package:paylink_app/shared/validators.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _busy = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ColorConstants.kblackColor,
        ),
        title: Text("Forgot Password",
            style: TextStyle(
              color: ColorConstants.kblackColor,
              fontWeight: FontWeight.w500,
            )),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          iconSize: 14,
          onPressed: () => {if (!_busy) Navigator.of(context).pop()},
        ),
        centerTitle: true,
        backgroundColor: ColorConstants.kwhiteColor,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 40, right: 8, left: 8),
        color: ColorConstants.kwhiteColor,
        child: AbsorbPointer(
            absorbing: _busy,
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Reset Password",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.kblackColor,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Enter your email address to reset your password",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: ColorConstants.kblackColor,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: ColorConstants.kgreenColor)),
                      ),
                      validator: (emailOrId) {
                        return Validators.isValidEmailOrId(emailOrId);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _busy = true;
                          });
                          resetPassword();
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorConstants.kgreenColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: _busy
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : Text(
                                "Send password reset email",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ))),
      ),
    );
  }

  Future<http.Response> resetPassword() async {
    final response = await http.post(
      Uri.parse(ApiConstants.apiEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{"email": _emailController.text}),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      Navigator.pushNamed(context, "/login");
      // return jsonDecode(response.body);
    } else {
      setState(() {
        _busy = false;
      });
      return Future.error("Failed to login user",
          StackTrace.fromString("Invalid Response from Server"));
    }
  }
}
