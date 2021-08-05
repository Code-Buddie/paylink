import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paylink_app/shared/color_constants.dart';
import 'package:paylink_app/widgets/custom_button.dart';
import 'package:paylink_app/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final storage = FlutterSecureStorage();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 40.0.w, bottom: 2.0.h, top: 2.0.h),
                    child: Text(
                      'My Profile',
                      style: TextStyle(
                        fontSize: 15.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      logoutUser();
                    },
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 33.0.w),
                width: 100.0.w,
                child: Stack(
                  children: [
                    Container(
                      width: 30.0.w,
                      height: 20.0.h,
                      child: _image != null
                          ? FittedBox(
                              fit: BoxFit.cover,
                              child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: FileImage(_image)),
                            )
                          : FittedBox(
                              fit: BoxFit.cover,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    AssetImage('assets/images/app_logo.png'),
                              ),
                            ),
                    ),
                    Positioned(
                      left: 25.0.w,
                      bottom: 7.0.h,
                      width: 10.0.w,
                      child: InkWell(
                        onTap: () {
                          _scaffoldKey.currentState.showBottomSheet(
                              (context) => showPicker(context));
                        },
                        child:
                            Image.asset('assets/images/ic_change_picture.png'),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                'John Doe',
                style:
                    TextStyle(fontSize: 25.0.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4.0.h,
              ),
              Padding(
                padding: EdgeInsets.all(4.0.w),
                child: Column(
                  children: [
                    profileItem(
                        itemKey: 'Full Name',
                        itemValue: 'John Doe',
                        bottomSheetFun: fullNameBottomSheet),
                    SizedBox(
                      height: 4.0.h,
                    ),
                    profileItem(
                        itemKey: 'Email',
                        itemValue: 'johndoe@gmail.com',
                        bottomSheetFun: emailBottomSheet),
                    SizedBox(
                      height: 4.0.h,
                    ),
                    profileItem(
                        itemKey: 'Gender',
                        itemValue: 'Male',
                        bottomSheetFun: genderBottomSheet),
                    CustomButton(
                        color: ColorConstants.kgreenColor,
                        textColor: Colors.white,
                        title: 'Change Password',
                        onPressed: () {
                          _scaffoldKey.currentState.showBottomSheet(
                              (context) => passwordBottomSheet(context));
                        }),
                    CustomButton(
                        color: Colors.red,
                        textColor: Colors.white,
                        title: 'Remove Account',
                        onPressed: () {
                          _scaffoldKey.currentState.showBottomSheet(
                              (context) => accountBottomSheet(context));
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _imgFromCamera() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }

  _imgFromGallery() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }

  Widget profileItem({itemKey, itemValue, Function bottomSheetFun}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              itemKey,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 0.015.h,
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState
                    .showBottomSheet((context) => bottomSheetFun(context));
              },
              child: Text(
                'Edit',
                style: TextStyle(
                    color: Color(0xffFD8D6A), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 2.0.h,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            itemValue,
            style: TextStyle(fontSize: 14.0.sp),
          ),
        ),
      ],
    );
  }

  Widget showPicker(context) {
    return Container(
      child: Wrap(
        children: <Widget>[
          ListTile(
              leading: new Icon(Icons.photo_library),
              title: new Text('Photo Library'),
              onTap: () {
                _imgFromGallery();
                Navigator.of(context).pop();
              }),
          ListTile(
            leading: Icon(Icons.photo_camera),
            title: Text('Camera'),
            onTap: () {
              _imgFromCamera();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget fullNameBottomSheet(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(40.0),
            topRight: const Radius.circular(40.0),
          )),
      width: 100.0.w,
      height: 45.0.h,
      child: Padding(
        padding: EdgeInsets.all(10.0.w),
        child: Column(
          children: [
            Text(
              'Edit Full Name',
              style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
            ),
            CustomTextField(hint: 'Please enter your full name'),
            CustomButton(
                color: ColorConstants.kgreenColor,
                textColor: Colors.white,
                title: 'Edit',
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }

  Widget emailBottomSheet(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorConstants.kwhiteColor,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(40.0),
            topRight: const Radius.circular(40.0),
          )),
      width: 100.0.w,
      height: 45.0.h,
      child: Padding(
        padding: EdgeInsets.all(10.0.w),
        child: Column(
          children: [
            Text(
              'Edit Email',
              style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
            ),
            CustomTextField(hint: 'Please enter your email'),
            CustomButton(
                color: ColorConstants.kgreenColor,
                textColor: Colors.white,
                title: 'Edit',
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }

  Widget genderBottomSheet(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorConstants.kwhiteColor,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(40.0),
            topRight: const Radius.circular(40.0),
          )),
      width: 100.0.w,
      height: 40.0.h,
      child: Padding(
        padding: EdgeInsets.all(10.0.w),
        child: Column(
          children: [
            Text(
              'Edit Gender',
              style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0.w),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      color: ColorConstants.kgreenColor,
                      textColor: Colors.white,
                      title: 'Male',
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Expanded(
                    child: CustomButton(
                      color: ColorConstants.kgreenColor,
                      textColor: Colors.white,
                      title: 'Female',
                    ),
                  )
                ],
              ),
            ),
            CustomButton(
                color: ColorConstants.kgreenColor,
                textColor: Colors.white,
                title: 'Edit',
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }

  Widget passwordBottomSheet(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorConstants.kwhiteColor,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(40.0),
            topRight: const Radius.circular(40.0),
          )),
      width: 100.0.w,
      height: 70.0.h,
      child: Padding(
        padding: EdgeInsets.all(10.0.w),
        child: Column(
          children: [
            Text(
              'Edit Password',
              style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
            ),
            CustomTextField(hint: 'Please enter your current password'),
            CustomTextField(hint: 'Please enter your new password'),
            CustomTextField(hint: 'Please re-enter your new password'),
            CustomButton(
                color: ColorConstants.kgreenColor,
                textColor: Colors.white,
                title: 'Edit',
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }

  Widget accountBottomSheet(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorConstants.kwhiteColor,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(40.0),
            topRight: const Radius.circular(40.0),
          )),
      width: 100.0.w,
      height: 45.0.h,
      child: Padding(
        padding: EdgeInsets.all(10.0.w),
        child: Column(
          children: [
            Text(
              'Remove Account',
              style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
            ),
            CustomTextField(hint: 'Please enter your password'),
            CustomButton(
                color: ColorConstants.kRedColor,
                textColor: Colors.white,
                title: 'Logout',
                onPressed: () {
                  logoutUser();
                })
          ],
        ),
      ),
    );
  }

  void logoutUser() async {
    await storage.deleteAll();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }
}
