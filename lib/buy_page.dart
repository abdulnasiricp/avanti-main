import 'package:avanti/widgets/customappbar.dart';
import 'package:flutter/material.dart';

class BuyPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final number;
  const BuyPage({super.key, this.number});

  @override
  State<BuyPage> createState() => _AmountPageState();
}

class _AmountPageState extends State<BuyPage> {
  // FormKey key = GlobalKey();
  TextEditingController phNum = TextEditingController();

  TextEditingController amount = TextEditingController();

  @override
  void initState() {
    amount.text = widget.number;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomApp("Buy Cheap Airtime Today"),
        body: Padding(
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
                          onPressed: () {},
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
                onTap: () {
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => BuyPage()));
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
        ));
  }
}
