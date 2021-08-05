import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:paylink_app/shared/api_constants.dart';
import 'package:paylink_app/shared/color_constants.dart';
import 'package:paylink_app/shared/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final storage = FlutterSecureStorage();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _busy = false;
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _busy = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.only(top: 100),
        padding: EdgeInsets.all(8),
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
                      "Welcome",
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
                      "Enter your email address or ID number to sign in",
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
                        labelText: 'Email / ID Number',
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: ColorConstants.kgreenColor)),
                      ),
                      validator: (emailOrId) {
                        return Validators.isValidEmailOrId(emailOrId);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: ColorConstants.kwhiteColor)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: ColorConstants.kcMediumGreyColor,
                          ),
                          onPressed: () {
                            setState(() {
                              FocusScope.of(context).requestFocus(FocusNode());
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: _passwordVisible,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/forgot");
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: ColorConstants.kcMediumGreyColor,
                            fontSize: 16,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
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
                          FocusScope.of(context).unfocus();
                          loginUser();
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
                                "SIGN IN",
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/sign-up");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?'),
                          SizedBox(width: 5.0),
                          Text(
                            'Create an account',
                            style: TextStyle(color: ColorConstants.kgreenColor),
                          )
                        ],
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }

  Future<http.Response> loginUser() async {
    final response = await http.post(
      Uri.parse(ApiConstants.apiEndpoint + "auth/signin"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "username": _emailController.text,
        "password": _passwordController.text
      }),
    );

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        _busy = false;
      });
      var resp = response.body;
      if (resp != null) {
        Map<String, dynamic> user = jsonDecode(resp);
        storage.write(key: "token", value: user['accessToken']);
        storage.write(key: "user", value: user['username']);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(prepareSnackBar("Invalid credentials"));
      }
    } else {
      setState(() {
        _busy = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(prepareSnackBar("Unable to log you in"));
      return Future.error("Failed to login user",
          StackTrace.fromString("Invalid Response from Server"));
    }
  }

  SnackBar prepareSnackBar(String mess) {
    return SnackBar(
      content: Text(
        mess,
        style: TextStyle(
          color: ColorConstants.kRedColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
