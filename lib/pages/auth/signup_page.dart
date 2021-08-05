import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:paylink_app/shared/api_constants.dart';
import 'package:paylink_app/shared/color_constants.dart';
import 'package:paylink_app/shared/validators.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _busy = false;
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ColorConstants.kblackColor,
        ),
        title: Text("Create Account",
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
        padding: EdgeInsets.only(top: 50, left: 8, right: 8),
        color: ColorConstants.kwhiteColor,
        child: AbsorbPointer(
            absorbing: _busy,
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Create Account",
                      style: GoogleFonts.openSans(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.kblackColor,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Enter your name, id number, phone number, \nemail and password for sign up",
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.kblackColor,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: ColorConstants.kgreenColor)),
                      ),
                      validator: (name) {
                        if (name == null ||
                            name.isEmpty ||
                            !name.contains(" ")) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _idController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'ID Number',
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: ColorConstants.kgreenColor)),
                      ),
                      validator: (idNumber) {
                        return Validators.isValidIdNumber(idNumber);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: ColorConstants.kgreenColor)),
                      ),
                      validator: (phoneNumber) {
                        return Validators.isValidPhoneNumber(phoneNumber);
                      },
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
                      validator: (email) {
                        return Validators.isValidEmail(email);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: ColorConstants.kgreenColor)),
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
                          createUser();
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
                    Text(
                      'By signing up you agree to our terms, conditions and privacy Policy.',
                      style: TextStyle(
                        color: ColorConstants.kblackColor,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ))),
      ),
    );
  }

  Future<http.Response> createUser() async {
    final response = await http.post(
      Uri.parse(ApiConstants.apiEndpoint + "auth/signup"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "name": _nameController.text,
        "phone": _phoneController.text,
        "username": _idController.text,
        "roles": ["user"],
        "email": _emailController.text,
        "password": _passwordController.text
      }),
    );

    if (response.statusCode == 200) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    } else {
      setState(() {
        _busy = false;
      });
      return Future.error("Failed to create user",
          StackTrace.fromString("Invalid Response from Server"));
    }
  }
}
