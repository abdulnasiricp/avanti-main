// ignore_for_file: avoid_print, unused_local_variable

import 'package:avanti/mpesa.dart';
import 'package:avanti/widgets/customappbar.dart';
import 'package:avanti/widgets/models/mpesaResponse.dart';
import 'package:avanti/widgets/stkpush.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final number;
  const BuyPage({super.key, this.number});

  @override
  State<BuyPage> createState() => _AmountPageState();
}

class _AmountPageState extends State<BuyPage> {

  
  @override
  void initState() {
    super.initState();
    // Load the stored phone number on page initialization
    loadPhoneNumber();
    amount.text = widget.number;
  }

late String phoneNumberKey;

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
  // FormKey key = GlobalKey();
  TextEditingController phNum = TextEditingController();

  TextEditingController amount = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomApp("Buy Cheap Airtime Today"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Note: Zero transaction fees and you can also use Fuliza to but the airtime",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.orange,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Your Safaricom Phone number',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                TextField(
                    controller: phNum,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 15),
                        isDense: true,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                                savePhoneNumberToFirebase(phNum.text);
                                savePhoneNumber(phNum.text);

                            },
                            // ignore: sort_child_properties_last
                            child: const Text('SAVE'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lime,
                                foregroundColor: Colors.white),
                          ),
                        ))),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Enter amount of Airtime you want to buy (Ksh 10  to KES/n2000)',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                TextField(
                  onChanged: (val) {
                    setState(() {
                      amount.text = val;
                    });
                  },
                  controller: amount,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: ()async {
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => BuyPage()));
                    // initiateSTKPush(phNum.text,amount.text);
                    final MpesaResponse mpesaResponse =
        await FlutterMpesaSTK("F6P9PiFMmByhDbBSN3vr1E6hmeUWOy6g", "XJQYRT1JtjP0xKKG", "", "6569467", "https://mydomain.com/pat", "").stkPush(Mpesa(amount.text,phNum.text, ));
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
                        // ignore: prefer_is_empty
                        "PAY KES: ${amount.text.length == 0 ? amount.text : int.parse(amount.text) * .85}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
