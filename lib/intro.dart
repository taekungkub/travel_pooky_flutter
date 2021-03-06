import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_travel/widgets/swiper_pagination.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'home.dart';

class IntroTwoPage extends StatefulWidget {
  static final String path = "lib/src/pages/onboarding/intro2.dart";
  @override
  _IntroTwoPageState createState() => _IntroTwoPageState();
}

class _IntroTwoPageState extends State<IntroTwoPage> {
  final SwiperController _swiperController = SwiperController();
  final int _pageCount = 3;
  int _currentIndex = 0;
  final List<String> titles = ["วัด", "ท่องเที่ยว", "ที่พัก."];

  final List<String> images = [
    'https://www.toyotakan.com/wp-content/uploads/2018/02/27486661416_78d286c78e_o-1024x683.jpg',
    'http://www.acnews.net/admin/img_large/4396355.jpg',
    'http://travel.mthai.com/app/uploads/2015/01/Samui.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
              child: Swiper(
            index: _currentIndex,
            controller: _swiperController,
            itemCount: _pageCount,
            onIndexChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            loop: false,
            itemBuilder: (context, index) {
              return _buildPage(title: titles[index], icon: images[index]);
            },
            pagination: SwiperPagination(
                builder: CustomPaginationBuilder(
                    activeColor: Colors.black,
                    activeSize: Size(10.0, 20.0),
                    size: Size(10.0, 15.0),
                    color: Colors.grey.shade600)),
          )),
          SizedBox(height: 10.0),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      margin: const EdgeInsets.only(right: 16.0, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            textColor: Colors.black,
            child: Text("Skip"),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          IconButton(
            color: Colors.black,
            icon: Icon(
              _currentIndex < _pageCount - 1
                  ? FontAwesomeIcons.arrowCircleRight
                  : FontAwesomeIcons.checkCircle,
              size: 40,
            ),
            onPressed: () async {
              if (_currentIndex < _pageCount - 1)
                _swiperController.next();
              else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildPage({String title, String icon}) {
    final TextStyle titleStyle = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40.0,
        fontFamily: "Prompt_regular");
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 40.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          image: DecorationImage(
              image: CachedNetworkImageProvider(icon),
              fit: BoxFit.cover,
              colorFilter:
                  ColorFilter.mode(Colors.black38, BlendMode.multiply))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: titleStyle.copyWith(color: Colors.white),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
