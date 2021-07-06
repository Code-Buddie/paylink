import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:paylink_app/models/parking_info.dart';
import 'package:paylink_app/shared/color_constants.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QRScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Position _currentPosition;
  String _currentAddress;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  /*
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  } */

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                    Center(
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorConstants.kgreenColor,
                            width: 2,
                          ),
                          // borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text('Scan a code'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      if (scanData.code.toLowerCase().contains("http")) {
        // if it contains parking, send post request to initiate payment in area
        if (scanData.code.toLowerCase().contains("parking")) {
          _initializeParkingPayment();
        } else {
          await launch(scanData.code);
        }

        controller.resumeCamera();
      } else if (await canLaunch(scanData.code.toLowerCase())) {
        await launch(scanData.code);
        controller.resumeCamera();
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Could not find viable url'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Barcode Type: ${describeEnum(scanData.format)}'),
                    Text('Data: ${scanData.code}'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        ).then((value) => controller.resumeCamera());
      }
    });
  }

  _getCurrentLocation() async {
    await Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  void _initializeParkingPayment() async {
    ParkingInfo parkInfo = ParkingInfo('KBX 142Q', '400', _currentAddress);
    String parkInfoS = parkInfo.toString().toUpperCase();
    String al = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-%&";

    List<String> splitData = splitStringByLength(parkInfoS, 8);
    List<int> keys = [];
    List<int> keys2 = [];

    var rnd = new Random();
    for (var i = 0; i < splitData.length; i++) {
      int x = rnd.nextInt(5);
      if (x < 1) x = 1;
      keys.add(x);
    }

    print(keys.toString());
    String result = "Park:";
    for (int i = 0; i < keys.length; i++) {
      int x = rnd.nextInt(4);
      keys2.add(keys[i] + x);
      keys2.add(x);
    }

    for (int i = 0; i < keys2.length; i++) {
      result += keys2[i].toString();
    }

    result += ":";

    for (int i = 0; i < splitData.length; i++) {
      String curr = splitData.elementAt(i);
      for (int j = 0; j < curr.length; j++) {
        var char = curr[j].toUpperCase();
        int index = al.indexOf(char);
        switch (char) {
          case",":
            result += "-";
            break;
          case ":":
            result += "%";
            break;
          case " ":
            result += "&";
            break;
          default:
            if (index + keys.elementAt(i) >= al.length) {
              result += al[index + keys.elementAt(i) - al.length].toLowerCase();
            } else {
              result += al[index + keys.elementAt(i)];
            }
            break;
        }
      }
    }

    print(result);


    Navigator.pushNamed(
      context,
      "/make-payment",
      arguments: parkInfo,
    );
  }

  // Splits only at first 8 cjars
  List<String> splitStringByLength(String str, int length) =>
      [str.substring(0, length), str.substring(length)];

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
