import 'package:avanti/buy_page.dart';
import 'package:avanti/widgets/buy.dart';
import 'package:avanti/widgets/customappbar.dart';
import 'package:flutter/material.dart';

class BuyAirtime extends StatelessWidget {
  const BuyAirtime({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomApp("Buy Airtime - 15% Discount!!"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
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
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const BuyPage(
                          number: '0',
                        )));
              },
              child: Container(
                height: 45,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    color: Colors.lime,
                    borderRadius: BorderRadius.circular(25)),
                child: const Center(
                  child: Text(
                    "ENTER AMOUNT - KSH 10 TO KSH 2000",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Buy(
                    number: "10",
                    title: "Ksh 10\nAirtime",
                    subtitle: 'Pay: Ksh ${10 * .85}',
                    function: () {}),
                const SizedBox(
                  width: 20,
                ),
                Buy(
                    number: "20",
                    title: "Ksh 20\nAirtime",
                    subtitle: 'Pay: Ksh ${20 * .85}',
                    function: () {}),
              ],
            ),
            Row(
              children: [
                Buy(
                    number: "50",
                    title: "Ksh 50\nAirtime",
                    subtitle: 'Pay: Ksh ${50 * .85}',
                    function: () {}),
                const SizedBox(
                 width: 20,
                ),
                Buy(
                    number: "100",
                    title: "Ksh 100\nAirtime",
                    subtitle: 'Pay: Ksh ${100 * .85}',
                    function: () {}),
              ],
            ),
            Row(
              children: [
                Buy(
                    number: "200",
                    title: "Ksh 200\nAirtime",
                    subtitle: 'Pay: Ksh ${200 * .85}',
                    function: () {}),
                const SizedBox(
                   width: 20,
                ),
                Buy(
                    number: "500",
                    title: "Ksh 500\nAirtime",
                    subtitle: 'Pay: Ksh ${500 * .85}',
                    function: () {}),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
