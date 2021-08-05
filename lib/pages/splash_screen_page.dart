import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paylink_app/shared/color_constants.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Timer _timer;
  int _loaderDuration = 5;

  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.kwhiteColor,
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset('assets/images/nakuru.png'),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(30),
                child: FutureBuilder(
                    future: jwtOrEmpty,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return LinearProgressIndicator();
                      if (snapshot.data != "") {
                        var str = snapshot.data;
                        var jwt = str.split(".");
                        if (jwt.length != 3) {
                          return Container();
                        } else {
                          var payload = json.decode(ascii
                              .decode(base64.decode(base64.normalize(jwt[1]))));
                          if (DateTime.fromMillisecondsSinceEpoch(
                                  payload["exp"] * 1000)
                              .isAfter(DateTime.now())) {
                            return Container();
                          } else {
                            return Container();
                          }
                        }
                      } else {
                        return Container();
                      }
                    }),
              ))
        ],
      ),
    );
  }

  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "token");
    if (jwt == null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      return "";
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }

    return jwt;
  }

  Future<void> fetchData() async {
    try {
      final result = await InternetAddress.lookup("twitter.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        await startTimer();
      } else {
        await startTimer();
        // _showAlert();
      }
    } on SocketException catch (_) {
      // _showAlert();
      await startTimer();
    }
  }

  Future<void> startTimer() async {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_loaderDuration == 0) {
          timer.cancel();
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/login', (Route<dynamic> route) => false);
        } else {
          _loaderDuration--;
        }
      },
    );
  }

  void _showErrorAlert() async {
    await Future.delayed(Duration(microseconds: 1));
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              title: Text("No internet"),
              content:
                  Text("Are you offline? \nWe are unable to load your data"),
              actions: [
                TextButton(
                    style: TextButton.styleFrom(
                      primary: ColorConstants.kgreenColor,
                    ),
                    onPressed: () {
                      pop(animated: true);
                    },
                    child: Text(
                      "Exit",
                      style: GoogleFonts.spartan(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.kgreenColor,
                      ),
                    )),
                TextButton(
                    style: TextButton.styleFrom(
                      primary: ColorConstants.kgreenColor,
                    ),
                    onPressed: () {
                      pop(animated: true);
                    },
                    child: Text(
                      "Open Settings",
                      style: GoogleFonts.spartan(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.kgreyColor,
                      ),
                    )),
              ],
            ));
  }

  static Future<void> pop({bool animated}) async {
    await SystemChannels.platform
        .invokeMethod<void>('SystemNavigator.pop', animated);
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }

    super.dispose();
  }
}
