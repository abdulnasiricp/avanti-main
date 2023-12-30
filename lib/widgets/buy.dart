import 'package:avanti/buy_page.dart';
import 'package:flutter/material.dart';

class Buy extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final title;
  // ignore: prefer_typing_uninitialized_variables
  final subtitle;
  // ignore: prefer_typing_uninitialized_variables
  final number;
  final VoidCallback function;

  const Buy({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: 160,
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: const Offset(2, 2),
            blurRadius: 15,
            color: Colors.grey.shade400)
      ]),
      child: Column(
        children: [
          const Icon(
            Icons.phone_android,
            size: 45,
            color: Colors.lime,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  // ignore: unnecessary_this
                  builder: (context) => BuyPage(number: this.number)));
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Colors.black,
                  border: Border.all(width: 2, color: Colors.lime)),
              child: const Center(
                child: Text(
                  'BUY',
                  style: TextStyle(
                      color: Colors.lime,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
