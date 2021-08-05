import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paylink_app/shared/color_constants.dart';
import 'package:paylink_app/widgets/custom_button.dart';
import 'package:paylink_app/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

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
                        itemValue: 'Michael Makali',
                        bottomSheetFun: fullNameBottomSheet),
                    Divider(),
                    profileItem(
                        itemKey: 'Id Number',
                        itemValue: '34584572',
                        bottomSheetFun: emailBottomSheet),
                    Divider(),
                    profileItem(
                        itemKey: 'Email',
                        itemValue: 'makali@gmail.com',
                        bottomSheetFun: emailBottomSheet),
                    Divider(),
                    profileItem(
                        itemKey: 'Password',
                        itemValue: '••••••••••',
                        bottomSheetFun: passwordBottomSheet),
                    Divider(),
                    SizedBox(
                      height: 7.0.h,
                    ),
                    LimitedBox(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            title: 'Logout',
                            onPressed: () {
                              logoutUser();
                            })
                      ],
                    )),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          itemKey,
          style: TextStyle(color: Colors.grey),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top:.7.h, bottom: .7.h),
              alignment: Alignment.centerLeft,
              child: Text(
                itemValue,
                style: TextStyle(fontSize: 14.0.sp),
              ),
            ),
            InkWell(
              onTap: () {
                _scaffoldKey.currentState
                    .showBottomSheet((context) => bottomSheetFun(context));
              },
              child: Icon(
                Icons.edit,
                size: 20.0,
              ),
            ),
          ],
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
            topLeft: const Radius.circular(10.0),
            topRight: const Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.kgreenColor.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            )
          ]),
      width: 100.0.w,
      height: 25.0.h,
      child: Padding(
        padding: EdgeInsets.only(
            top: 8.0.w, bottom: 4.0.w, left: 4.0.w, right: 4.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update your Full Name',
              style: TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.bold),
            ),
            CustomTextField(hint: 'Please enter your full name'),
            CustomButton(
                color: ColorConstants.kgreenColor,
                textColor: Colors.white,
                title: 'Update name'.toUpperCase(),
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
            topLeft: const Radius.circular(10.0),
            topRight: const Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.kgreenColor.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            )
          ]),
      width: 100.0.w,
      height: 24.0.h,
      child: Padding(
        padding: EdgeInsets.only(
            top: 8.0.w, bottom: 4.0.w, left: 4.0.w, right: 4.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update your Email address',
              style: TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.bold),
            ),
            CustomTextField(hint: 'Please enter your new email address'),
            CustomButton(
                color: ColorConstants.kgreenColor,
                textColor: Colors.white,
                title: 'Update email address'.toUpperCase(),
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
            topLeft: const Radius.circular(10.0),
            topRight: const Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.kgreenColor.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            )
          ]),
      width: 100.0.w,
      height: 40.0.h,
      child: Padding(
        padding: EdgeInsets.only(
            top: 8.0.w, bottom: 4.0.w, left: 4.0.w, right: 4.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update your Password',
              style: TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.bold),
            ),
            CustomTextField(hint: 'Please enter your current password'),
            CustomTextField(hint: 'Please enter your new password'),
            CustomTextField(hint: 'Please re-enter your new password'),
            CustomButton(
                color: ColorConstants.kgreenColor,
                textColor: Colors.white,
                title: 'Update Password',
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
            topLeft: const Radius.circular(10.0),
            topRight: const Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.kRedColor.withOpacity(0.5),
              spreadRadius: 9,
              blurRadius: 10,
              offset: Offset(0, 3), // changes position of shadow
            )
          ]),
      width: 100.0.w,
      height: 27.0.h,
      child: Padding(
        padding: EdgeInsets.only(top:8.0.w, left:4.0.w, right: 4.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delete your Account',
              style: TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.bold),
            ),
            CustomTextField(hint: 'Please enter your password'),
            CustomButton(
                color: ColorConstants.kRedColor,
                textColor: Colors.white,
                title: 'Confirm',
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
