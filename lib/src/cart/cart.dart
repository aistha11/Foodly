import 'package:flutter/material.dart';
import 'package:foodapp/components/shimmering/myshimmer.dart';
import 'package:foodapp/constants/colors.dart';
import 'package:foodapp/eCommerce/eCommerce.dart';
import 'package:foodapp/src/cart/widgets/cartItemTile.dart';
// import 'package:foodapp/src/cart/widgets/userDetail.dart';
import 'package:foodapp/utilities/utils.dart';
import 'package:woocommerce/woocommerce.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // String name = "Abhiyan Khanal";
    // String address = "NewRoad, Nepalgunj";
    // String contact = "9851010812";
    String price = "1000";
    Ecommerce _ecommerce = Ecommerce();

    return Scaffold(
      backgroundColor: bgCol,
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
                                text: "Cart",
                                style: TextStyle(color: mainCol, fontSize: 30)),
                          ],
                        ),
                      ),
                    ),
                    // //name address contact edit
                    // UserDetail(
                    //   name: name,
                    //   address: address,
                    //   contact: contact,
                    // ),
                    SizedBox(
                      height: 25,
                    ),
                    //list of cart items
                    Flexible(
                      child: Container(
                        height: Utils.getHeightByPercentage(context, 50),
                        child: FutureBuilder(
                          future: _ecommerce.getCartItems(),
                          builder:
                              (_, AsyncSnapshot<List<WooCartItem>> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return MyShimmer.shimCont(
                                    Utils.getHeightByPercentage(context, 36));
                                break;
                              case ConnectionState.waiting:
                                return MyShimmer.shimCont(
                                    Utils.getHeightByPercentage(context, 36));
                                break;
                              case ConnectionState.active:
                                return MyShimmer.shimCont(
                                    Utils.getHeightByPercentage(context, 36));
                                break;
                              case ConnectionState.done:
                                var doclist = snapshot.data;
                                if (doclist.isNotEmpty) {
                                  return ListView.builder(
                                    itemCount: doclist.length,
                                    itemBuilder: (_, i) {
                                      WooCartItem wooCartItem = doclist[i];
                                      return CartItemTile(item: wooCartItem);
                                    },
                                  );
                                } else {
                                  return ListView.builder(
                                    itemCount: 5,
                                    itemBuilder: (_, i) {
                                      return CartItemTile();
                                    },
                                  );
                                }
                                break;
                              default:
                                return Container(
                                  child: Center(
                                    child: Text(
                                        "Something went wrong! Check your network connection."),
                                  ),
                                );
                            }
                          },
                        ),
                      ),
                    ),
                    //delevery
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: Utils.getWidthByPercentage(context, 25),
                          ),
                          Container(
                            width: Utils.getWidthByPercentage(context, 40),
                            child: Text(
                              "Delivery",
                              style:
                                  TextStyle(fontSize: 16.0, color: secondCol),
                            ),
                          ),
                          Container(
                            width: Utils.getWidthByPercentage(context, 20),
                            child: Text(
                              "NRs. 0",
                              style:
                                  TextStyle(fontSize: 16.0, color: secondCol),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //total
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(fontSize: 21.0, color: secondCol),
                          ),
                          Text(
                            "NRs. $price",
                            style: TextStyle(fontSize: 21.0, color: secondCol),
                          ),
                        ],
                      ),
                    ),
                    //chekout
                    Container(
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                        color: mainCol,
                        textColor: secondCol,
                        child: Text("Checkout"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              bottomLeft: Radius.circular(40)),
                        ),
                        onPressed: () async {},
                      ),
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
