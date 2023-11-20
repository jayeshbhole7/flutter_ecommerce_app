import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/size_config.dart';
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
      "text": "Welcome to DoorStep, Let’s shop!",
      "image": "assets/images/splash_1.png",
    },
    {
      "text": "We help people connect with stores \naround the world!",
      "image": "assets/images/splash_2.png",
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/images/splash_3.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    _preloadImages();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.round();
      });
    });
    
    Timer.periodic(const Duration(seconds: 2),(timer){
      if(currentPage < splashData.length - 1){
        _pageController.nextPage(
        duration: kAnimationDuration,
        curve: Curves.easeInOut,
        );
      }else{
        timer.cancel();
      }
    });
  }
  Future<void> _preloadImages() async{
    for(var splashItem in splashData){
      await precacheImage(AssetImage(splashItem["image"]!), context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: PageView.builder(
              // physics: currentPage==0
              // ? NeverScrollableScrollPhysics()
              // : AlwaysScrollableScrollPhysics(),
              controller: _pageController,
              itemCount: splashData.length,
              itemBuilder: (context, index) => SplashContent(
                image: splashData[index]["image"],
                text: splashData[index]['text'],
              ),
            ),
          ),
          Expanded(
            flex: 2,
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
                  Spacer(flex: 3),
                  DefaultButton(
                    text: "Continue",
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
    );
  }

  Widget buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

