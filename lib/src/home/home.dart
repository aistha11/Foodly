import 'package:flutter/material.dart';
import 'package:foodapp/constants/colors.dart';
import 'package:foodapp/constants/icons.dart';
import 'package:foodapp/kiran/page.dart';
import 'package:foodapp/src/cart/cart.dart';
import 'package:foodapp/src/explore/explore.dart';
import 'package:foodapp/src/orders/orders.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          // remove this later. Made by Kiran for testing
          ProductPage(),
          Explore(),
          Orders(),
          Cart(),
        ],
        controller: _pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: mainCol,
        currentIndex: _page,
        onTap: navigationTapped,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: secondCol,
        unselectedItemColor: bgCol,
        items: [
          // remove this later. Made by Kiran for testing
          BottomNavigationBarItem(
            icon: Icon(exploreIcon),
            title: Text("Kiran"),
            backgroundColor: mainCol,
          ),
          BottomNavigationBarItem(
            icon: Icon(exploreIcon),
            title: Text("Explore"),
            backgroundColor: mainCol,
          ),
          BottomNavigationBarItem(
            icon: Icon(offerIcon),
            title: Text("Offer"),
            backgroundColor: mainCol,
          ),
          BottomNavigationBarItem(
            icon: Icon(cartIcon),
            title: Text("Cart"),
            backgroundColor: mainCol,
          ),
        ],
      ),
    );
  }
}
