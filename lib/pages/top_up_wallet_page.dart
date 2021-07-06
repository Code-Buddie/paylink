import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:paylink_app/shared/color_constants.dart';
import 'package:paylink_app/widgets/card_widget.dart';
import 'package:paylink_app/widgets/title_text.dart';

class TopUpWalletPage extends StatefulWidget {
  @override
  _TopUpWalletState createState() => _TopUpWalletState();
}

class _TopUpWalletState extends State<TopUpWalletPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amount = TextEditingController();

  String amount;

  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorizedOrNot = 'Not Authorized';
  bool _isAuthenticating = false;

  @override
  void initState() {
    _checkBiometrics();
    _getAvailableBiometrics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: ColorConstants.kwhiteColor,
                    ),
                    Icon(
                      Icons.more_vert,
                      color: ColorConstants.kwhiteColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Top up your Card',
                  style: GoogleFonts.spartan(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.kgreenColor,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                CardWidget(),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstants.kwhiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstants.kgreenColor.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(3, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Top up \nAmount",
                          style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: ColorConstants.kgreyColor)),
                      Form(
                        key: _formKey,
                        child: Container(
                          width: 300,
                          child: TextFormField(
                            readOnly: true,
                            showCursor: false,
                            controller: _amount,
                            style: GoogleFonts.lato(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                color: ColorConstants.kgreenColor),
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              hintText: 'Enter Amount',
                              border: InputBorder.none,
                              // prefixText: 'Kes'
                              // labelText: 'Enter Amount',
                              // border: new OutlineInputBorder(
                              //     borderSide: new BorderSide(
                              //         color: ColorConstants.kgreenColor)),
                            ),
                            validator: (amount) {
                              if (amount == null || amount.isEmpty) {
                                return 'Please enter a valid amount';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .5,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      _transferButton(),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1.75,
                          // padding: EdgeInsets.symmetric(horizontal: 30),
                          children: <Widget>[
                            _countButton("1"),
                            _countButton("2"),
                            _countButton("3"),
                            _countButton("4"),
                            _countButton("5"),
                            _countButton("6"),
                            _countButton("7"),
                            _countButton("8"),
                            _countButton("9"),
                            _countButton(""),
                            _countButton("0"),
                            _icon(Icons.backspace, false)
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _transferButton() {
    return InkWell(
      onTap: () {
        completeTransaction();
      },
      child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: ColorConstants.kgreenColor,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Transform.rotate(
                angle: 70,
                child: Icon(
                  Icons.swap_calls,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10),
              Text("Top up Card",
                  style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white)),
            ],
          )),
    );
  }

  Widget _icon(IconData icon, bool isBackground) {
    return Container(
        margin: EdgeInsets.all(10),
        child: InkWell(
            onTap: () {
              if (_amount.text != null && _amount.text.length > 0) {
                _amount.text =
                    _amount.text.substring(0, _amount.text.length - 1);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Icon(
                icon,
                color: ColorConstants.kgreyColor,
              ),
            )));
  }

  Widget _countButton(String text) {
    return Material(
        child: InkWell(
            onTap: () {
              if (_amount.text.length == 0 && text == "0") {
              } else {
                _amount.text += text;
              }
            },
            child: Container(
              alignment: Alignment.center,
              child: TitleText(
                text: text,
              ),
            )));
  }

  void completeTransaction() async {
    await _checkBiometrics();
    if (_canCheckBiometrics) {
      await _getAvailableBiometrics();
      if (_availableBiometrics.contains(BiometricType.fingerprint)) {
        await _authenticate();
      }
    }
  }

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    // 8. this method opens a dialog for fingerprint authentication.
    //    we do not need to create a dialog nut it popsup from device natively.
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        biometricOnly: false,
        localizedReason: "Enter your fingerprint to proceed",
        // message for dialog
        useErrorDialogs: true,
        // show error in dialog
        stickyAuth: true, // native process
      );
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _authorizedOrNot = authenticated ? "Authorized" : "Not Authorized";
    });
    Navigator.pushNamed(
      context,
      "/process",
      arguments: _amount.text,
    );
  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }
}
