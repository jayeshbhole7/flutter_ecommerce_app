import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  final PageController _pageController = PageController();
  List<Map<String, String>> splashData = [
    {
      "text": "Discover Exciting Products",
      "image": "assets/images/splash_4.png",
    },
    {
      "text": "Get Exclusive Deals",
      "image": "assets/images/splash_5.png",
    },
    {
      "text": "Shop with Confidence",
      "image": "assets/images/splash_6.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    _preloadImages();
    Timer.periodic(const Duration(seconds: 4), (timer) {
      if (currentPage < splashData.length - 1) {
        currentPage++;
      } else {
        timer.cancel();
      }
      _pageController.animateToPage(
        currentPage,
        duration: kAnimationDuration,
        curve: Curves.easeInOut,
      );
    });
  }

  Future<void> _preloadImages() async {
    for (var splashItem in splashData) {
      await precacheImage(AssetImage(splashItem["image"]!), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: PageView.builder(
                controller: _pageController,
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 2),
                    DefaultButton(
                      text: "Get Started",
                      press: () {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 10,
      width: currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.white : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
