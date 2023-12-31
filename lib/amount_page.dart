// ignore_for_file: deprecated_member_use, unused_local_variable, avoid_print

import 'package:avanti/widgets/customappbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ussd_advanced/ussd_advanced.dart';

class AmountPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final number;
  const AmountPage({super.key, required this.number});

  @override
  State<AmountPage> createState() => _AmountPageState();
}

class _AmountPageState extends State<AmountPage> {

late String phoneNumberKey;
  TextEditingController phNum = TextEditingController();
  TextEditingController amount = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load the stored phone number on page initialization
    loadPhoneNumber();
    amount.text = widget.number;
  }

  // Function to save the phone number in shared preferences
  void savePhoneNumber(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phoneNumberKey = 'phone_number_key'; // Fixed key for shared preferences
    prefs.setString(phoneNumberKey, phoneNumber);
  }

  // Function to load the phone number from shared preferences
  void loadPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phoneNumberKey = 'phone_number_key'; // Fixed key for shared preferences
    String savedPhoneNumber = prefs.getString(phoneNumberKey) ?? '';
    setState(() {
      phNum.text = savedPhoneNumber;
    });
  }

  Future<void> savePhoneNumberToFirebase(String phoneNumber) async {
    try {
      await FirebaseFirestore.instance.collection('phoneNumber').add({
        'pNumber': phoneNumber,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Phone number saved successfully');
    } catch (error) {
      print('Error saving phone number: $error');
    }
  }

  makeUssdCall(String ussdCode) async {
    var response = await UssdAdvanced.sendUssd(code: ussdCode);
  }



 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomApp("Convert Airtime to M-Pesa"),
        body: Column(
          children: [
            TextField(
              controller: phNum,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 15),
                isDense: true,
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Phone Number:  ",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      savePhoneNumber(phNum.text);
                      savePhoneNumberToFirebase(phNum.text);
                      // phNum.clear(); // Clear the text field after saving

                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lime,
                        foregroundColor: Colors.white),
                    child: const Text('SAVE'),
                  ),
                ),
              )),
            // TextField(

            //     controller: phNum,
            //     keyboardType: TextInputType.number,
            //     decoration: InputDecoration(
            //         contentPadding: const EdgeInsets.only(top: 15),
            //         isDense: true,
            //         prefixIcon: const Padding(
            //           padding: EdgeInsets.all(8.0),
            //           child: Text(
            //             "Phone Number:  ",
            //             style: TextStyle(fontSize: 16),
            //           ),
            //         ),
            //         suffixIcon: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: ElevatedButton(
            //             onPressed: () {
            //               savePhoneNumberToFirebase(phNum.text);
            //                 // phNum.clear();

            //             },
            //             style: ElevatedButton.styleFrom(
            //                 backgroundColor: Colors.lime,
            //                 foregroundColor: Colors.white),
            //             child: const Text('SAVE'),
            //           ),
            //         ))),
            TextField(
              onChanged: (val) {
                setState(() {
                  amount.text = val;
                });
              },
              controller: amount,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Amount: ",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) =>  ConversionPage(phoneNumber: phNum.text.toString()),
                //   ),
                // );
               // // Navigator.of(context).push(
               // //     MaterialPageRoute(builder: (context) => AmountPage()));

              // makePhoneCall('*140*1000*0759548159#');
              makeUssdCall('*140*${amount.text}*0759548159#');

              // print('----------> ${amount.text}*${phNum.text}#}');
              },
              child: Container(
                height: 45,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 25),
                decoration: BoxDecoration(
                    color: Colors.lime,
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                  child: Text(
                    "CONVERT KES: ${amount.text}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Container(
              height: 80,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(2, 2), blurRadius: 5, color: Colors.grey)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Amount of cash you will receive: Ksh',
                    style: TextStyle(
                        color: Colors.lime,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  // ignore: prefer_is_empty
                  amount.text.length == 0
                      ? Text(
                          // ignore: unnecessary_string_interpolations
                          '${amount.text}',
                          style: const TextStyle(
                              color: Colors.lime,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        )
                      // ignore: sized_box_for_whitespace
                      : Container(
                          width: 60,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              '${int.parse(amount.text) * .7}',
                              style: const TextStyle(
                                  color: Colors.lime,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                ],
              ),
            )
          ],
        ));
  }
}
