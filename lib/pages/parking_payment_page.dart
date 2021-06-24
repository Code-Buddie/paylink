import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:paylink_app/models/parking_info.dart';
import 'package:paylink_app/shared/color_constants.dart';

class ParkingPaymentPage extends StatefulWidget {
  const ParkingPaymentPage({Key key}) : super(key: key);

  @override
  _ParkingPaymentPageState createState() => _ParkingPaymentPageState();
}

class _ParkingPaymentPageState extends State<ParkingPaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _carPlates = TextEditingController();

  String _selectedArea = 'Nakuru West';
  bool _busy = false;

  var _currencies = [
    "Gilgil",
    "Kuresoi North",
    "Kuresoi South",
    "Molo",
    "Naivasha",
    "Nakuru East",
    "Nakuru North",
    "Nakuru West",
    "Njoro",
    "Rongai",
    "Subukia",
  ];

  GoogleMapController _controller;
  String _mapStyle;

  static final CameraPosition _kNakuru = CameraPosition(
    target: LatLng(-0.303099, 36.080025),
    zoom: 14.4746,
  );

  Location _location = Location();

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/maps/map_style.json')
        .then((string) {
      this._mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.kwhiteColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Make Parking payments",
                      style: GoogleFonts.spartan(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.kblackColor,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 8, right: 8),
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
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.5,
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: ColorConstants.kwhiteColor,
                                      ),
                                      child: GoogleMap(
                                        mapType: MapType.normal,
                                        initialCameraPosition: _kNakuru,
                                        myLocationEnabled: true,
                                        onMapCreated:
                                            (GoogleMapController controller) {
                                          controller
                                              .setMapStyle(this._mapStyle);
                                          _controller = controller;
                                          _location.onLocationChanged
                                              .listen((l) {
                                            _controller.animateCamera(
                                              CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                    target: LatLng(l.latitude,
                                                        l.longitude),
                                                    zoom: 15),
                                              ),
                                            );
                                          });
                                        },
                                      ),
                                    ),
                                    TextFormField(
                                      controller: _carPlates,
                                      keyboardType: TextInputType.name,
                                      textCapitalization: TextCapitalization.characters,
                                      decoration: InputDecoration(
                                        labelText: 'Car Number Plates',
                                        border: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: ColorConstants
                                                    .kgreenColor)),
                                      ),
                                      validator: (name) {
                                        if (name == null ||
                                            name.isEmpty ||
                                            !name.contains(" ")) {
                                          return 'Please enter a valid number plate';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    FormField<String>(
                                      builder: (FormFieldState<String> state) {
                                        return InputDecorator(
                                          decoration: InputDecoration(
                                            labelText: 'Parking Zone',
                                            errorStyle: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 16.0),
                                            hintText: 'Parking Zone',
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: ColorConstants
                                                        .kgreenColor)),
                                          ),
                                          isEmpty: _selectedArea == '',
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              value: _selectedArea,
                                              isDense: true,
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  _selectedArea = newValue;
                                                  state.didChange(newValue);
                                                });
                                              },
                                              items: _currencies
                                                  .map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (_formKey.currentState.validate()) {
                                          if (_selectedArea != "" ||
                                              _selectedArea != null) {
                                            setState(() {
                                              _busy = true;
                                            });
                                            _preparePayment();
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: ColorConstants.kgreenColor,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: _busy
                                            ? CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Colors.white),
                                              )
                                            : Text(
                                                "Proceed",
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
                                )))),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void _preparePayment() async {
    // fetch Price from API
    ParkingInfo parkInfo = ParkingInfo(_carPlates.text, '200', _selectedArea);
    Navigator.pushNamed(
      context,
      "/make-payment",
      arguments: parkInfo,
    );
  }
}
