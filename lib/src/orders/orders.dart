import 'package:flutter/material.dart';
import 'package:foodapp/constants/colors.dart';
import 'package:foodapp/src/cart/widgets/userDetail.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name = "Abhiyan Khanal";
    String address = "NewRoad, Nepalgunj";
    String contact = "9851010812";
    
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //my cart
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: black, fontSize: 26.0),
                          children: <TextSpan>[
                            TextSpan(text: "My\n"),
                            TextSpan(
                                text: "Orders",
                                style: TextStyle(color: mainCol, fontSize: 30)),
                          ],
                        ),
                      ),
                    ),
                    //name address contact edit
                    UserDetail(
                      name: name,
                      address: address,
                      contact: contact,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
