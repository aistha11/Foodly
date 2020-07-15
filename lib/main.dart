import 'package:flutter/material.dart';
import 'package:foodapp/src/auth/auth.dart';
import 'package:foodapp/src/home/home.dart';
import 'package:foodapp/src/search/searchScreen.dart';
import 'package:foodapp/testPage/test.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "The Foodly",
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (_) => Home(),
        "/searchScreen": (_) => SearchScreen(),
        "/auth": (_) => Login(),
        "/test": (_) => Test(),
      },
    );
  }
}
