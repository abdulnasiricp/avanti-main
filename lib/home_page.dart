import 'package:avanti/contactus_page.dart';
import 'package:avanti/main_page.dart';
import 'package:avanti/chat.dart';
import 'package:avanti/rateus_page.dart';
import 'package:avanti/widgets/customappbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: const Color(0xFFCDDC39),
              onPressed: () {
                // Add your share button functionality here
              },
              shape: const CircleBorder(eccentricity: 1),
              child: const Icon(Icons.share),
            ),
            const SizedBox(width: 16), // Adjust the spacing between icons
            FloatingActionButton(
              backgroundColor: const Color(0xFFCDDC39),
              onPressed: () {
                // Navigate to Chart.dart when the chat icon is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ChatbotPage()), // Replace with the actual name of your Chart.dart page class
                );
              },
              shape: const CircleBorder(eccentricity: 1),
              child: const Icon(Icons.chat),
            ),
          ],
        ),
        appBar: CustomApp("Avanti"),
        bottomNavigationBar: BottomNavigationBar(
          selectedIconTheme: const IconThemeData(color: Color(0xFFCDDC39)),
          selectedItemColor: Colors.lime,
          currentIndex: _index,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: 30,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.star_outline,
                  size: 30,
                ),
                label: 'Rate Us'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.phone_outlined,
                  size: 30,
                ),
                label: 'Contact Us')
          ],
          onTap: (ind) {
            setState(() {
              _index = ind;
            });
          },
        ),
        body: _index == 0
            ? const MainPage()
            : _index == 1
                ? const RateUsPage()
                : const ContactUsPage());
  }
}
