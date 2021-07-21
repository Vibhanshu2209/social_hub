import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:social_hub/AuthPages/FacebookAuth.dart';
import 'package:social_hub/AuthPages/GoogleAuth.dart';
import 'package:social_hub/AuthPages/Profile.dart';

import 'package:velocity_x/velocity_x.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _theme = ThemeData(
      appBarTheme: AppBarTheme(color: Vx.blue500),
      scaffoldBackgroundColor: Vx.blue500);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _theme,
      home: SafeArea(
        child: Scaffold(
            appBar: VxAppBar(
              elevation: 0,
              title: "SparCial - Sparks Social Hub"
                  .text
                  .fontFamily('Rubik')
                  .white
                  .make(),
              centerTitle: true,
            ),
            body: VxSwiper(
                    height: double.maxFinite,
                    onPageChanged: (index) {
                      setState(() {
                        _theme = ThemeData(
                            appBarTheme: AppBarTheme(
                                titleTextStyle: TextStyle(color: Vx.black),
                                color: LoginCard().palette[index]),
                            canvasColor: LoginCard().palette[index]);
                      });
                    },
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    autoPlayInterval: Duration(seconds: 6),
                    isFastScrollingEnabled: false,
                    items: ["Facebook", "Google", "Profile"].map((i) {
                      return LoginCard(child: i);
                    }).toList())
                .centered()),
      ),
    );
  }
}

class LoginCard extends StatefulWidget {
  final child;
  final Map<int, Color> palette = {
    0: Vx.blue500,
    1: Vx.red600,
    2: Vx.blueGray500,
  };

  LoginCard({this.child});

  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.child.toString() == "Google") {
      return GoogleAuth();
    } else if (widget.child.toString() == "Facebook") {
      return FacebookAuthent();
    }
    return Profile();
  }
}
