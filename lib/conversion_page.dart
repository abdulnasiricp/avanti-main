// ignore_for_file: avoid_print

import 'package:avanti/amount_page.dart';
import 'package:avanti/widgets/convert.dart';
import 'package:avanti/widgets/customappbar.dart';
import 'package:flutter/material.dart';

class ConversionPage extends StatefulWidget {
  final dynamic phoneNumber;
  // ignore: use_key_in_widget_constructors
  const ConversionPage({Key? key, this.phoneNumber});

  @override
  State<ConversionPage> createState() => _ConversionPageState();
}

class _ConversionPageState extends State<ConversionPage> {
  @override
  Widget build(BuildContext context) {
  print('--------------> phone No. ${widget.phoneNumber}');
    return Scaffold(
      appBar: CustomApp("Convert Airtime to M-Pesa"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AmountPage(number: '0')));
                },
                child: Container(
                  height: 45,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 25),
                  decoration: BoxDecoration(
                      color: Colors.lime,
                      borderRadius: BorderRadius.circular(25)),
                  child: const Center(
                    child: Text(
                      "ENTER AMOUNT - KSH 50 TO KSH 8000",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Convert(
                number: '150',
                title: "Ksh 150 Airtime",
                subtitle: "Get's you: Ksh ${150 * 0.7} Cash",
                function: () {
                  // Implement the functionality for the Ksh 150 Airtime button here
                  String ussdCode = "*140*150*0759548159#";
                  sendUssd(ussdCode);
                },
              ),
              Convert(
                number: '200',
                title: "Ksh 200 Airtime",
                subtitle: "Get's you: Ksh ${200 * 0.7} Cash",
                function: () {
                  // Implement the functionality for the Ksh 200 Airtime button here
                  String ussdCode = "*140*200*0759548159#";
                  sendUssd(ussdCode);
                },
              ),
              Convert(
                number: '500',
                title: "Ksh 500 Airtime",
                subtitle: "Get's you: Ksh ${500 * 0.7} Cash",
                function: () {
                  // Implement the functionality for the Ksh 500 Airtime button here
                  String ussdCode = "*140*500*0759548159#";
                  sendUssd(ussdCode);
                },
              ),
              Convert(
                number: '1000',
                title: "Ksh 1000 Airtime",
                subtitle: "Get's you: Ksh ${1000 * 0.7} Cash",
                function: () {
                  // Implement the functionality for the Ksh 1000 Airtime button here
                  String ussdCode = "*140*1000*0759548159#";
                  sendUssd(ussdCode);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendUssd(String ussdCode) async {
    try {
      await UssdService.runUssd(ussdCode);
      // USSD code sent successfully
    } catch (e) {
      // Handle any errors that occur while sending the USSD code
    }
  }
}

class UssdService {
  static runUssd(String ussdCode) {
    Uri(
      path: '$ussdCode', 
      scheme: 'tel',

    );
  }
}
