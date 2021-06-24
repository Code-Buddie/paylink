import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paylink_app/shared/color_constants.dart';
import 'package:paylink_app/widgets/card_widget.dart';

class TopUpWalletPage extends StatefulWidget {
  @override
  _TopUpWalletState createState() => _TopUpWalletState();
}

class _TopUpWalletState extends State<TopUpWalletPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amount = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    height: 35,
                  ),
                  Text(
                    'Wallet',
                    style: GoogleFonts.spartan(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.kgreenColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Mike Makali',
                    style: GoogleFonts.spartan(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.kgreyColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 2,
                right: 2,
                top: 30,
              ),
              child: Container(
                // height: 200,
                child: CardWidget(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Top up Wallet",
                    style: GoogleFonts.spartan(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.kblackColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextFormField(
                          controller: _amount,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Top Up amount',
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: ColorConstants.kgreenColor)),
                          ),
                          validator: (amount) {
                            if (amount == null || amount.isEmpty) {
                              return 'Please enter a valid amount';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
