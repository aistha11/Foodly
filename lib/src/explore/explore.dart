import 'package:flutter/material.dart';
import 'package:foodapp/constants/colors.dart';
import 'package:foodapp/src/explore/widgets/categories.dart';
import 'package:foodapp/src/explore/widgets/mybanner.dart';
import 'package:foodapp/src/explore/widgets/searchBar.dart';
import 'package:foodapp/src/explore/widgets/wooProducts.dart';
import 'package:foodapp/utilities/utils.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.customAppBar(context),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 95,
            backgroundColor: bgCol,
            flexibleSpace: FlexibleSpaceBar(
              background: MyBanner(),
            ),
          ),
          SliverFillRemaining(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //search
                  SearchBar(),
                  //categories
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, top: 5.0, bottom: 5),
                    child: Text(
                      "Categories",
                      style: TextStyle(fontSize: 20.0, color: secondCol),
                    ),
                  ),
                  Categories(),
                  //products
                  Flexible(
                    child: WooProducts(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
