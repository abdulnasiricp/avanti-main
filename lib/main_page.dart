import 'package:avanti/buyairtime_page.dart';
import 'package:avanti/conversion_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ConversionPage()));
            },
            child: Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 22),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8)),
              child: const Column(children: [
                Icon(
                  Icons.recycling,
                  color: Colors.lime,
                  size: 38,
                ),
                Text(
                  "Convert Airtime to Cash (70% Cashback)",
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF673AB7),
                      fontWeight: FontWeight.bold),
                )
              ]),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const BuyAirtime()));
            },
            child: Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 22),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8)),
              child: const Column(children: [
                Icon(
                  Icons.phone_android_outlined,
                  color: Colors.lime,
                  size: 38,
                ),
                Text(
                  "Buy Cheap Airtime (15% Discount)",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold),
                )
              ]),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const ImageSliderDemo()
        ],
      ),
    );
  }
}

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];
final List<Widget> imageSliders = imgList
    // ignore: avoid_unnecessary_containers
    .map((item) => Container(
          child: Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.network(item, fit: BoxFit.cover, width: 1000.0),
                ],
              ),
            ),
          ),
        ))
    .toList();

class ImageSliderDemo extends StatefulWidget {
  const ImageSliderDemo({super.key});

  @override
  State<ImageSliderDemo> createState() => _ImageSliderDemoState();
}

class _ImageSliderDemoState extends State<ImageSliderDemo> {
  int _currentImageIndex = 0;

  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
        child: Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            autoPlay: true,
          ),
          items: imageSliders,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () {
                // Navigate to the corresponding image
              },
              child: Container(
                width: 10.0,
                height: 10.0,
                margin:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: entry.key == _currentImageIndex
                      ? Colors.blue // Color of the selected dot
                      : Colors.grey, // Color of unselected dots
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ));
  }
}
