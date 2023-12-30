import 'package:flutter/material.dart';

class RateUsPage extends StatelessWidget {
  const RateUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.all(20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Rate Us",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.lime,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  "Avanti makes it possible for you to convert your\nairtime to MPesa instantly (in less than 1 minute). We\nalso sell the cheapest airtime in Kenya at 10-15%\ndiscount."),
              SizedBox(
                height: 10,
              ),
              Text(
                  "Avanti is Kenya's No.1 airtime to MPesa\nconversion service. We are the cheapest, fastest & most\nreliable airtime to cash conversion service in Kenya."),
              SizedBox(
                height: 15,
              ),
            ])),
        Container(
          height: 30,
          width: double.infinity,
          color: Colors.lime,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "RATE US",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.star,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.star,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.star,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.star,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.star,
                size: 30,
                color: Colors.white,
              ),
            ],
          ),
        )
      ],
    );
  }
}
