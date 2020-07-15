import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/components/shimmering/myshimmer.dart';
import 'package:foodapp/constants/colors.dart';
import 'package:foodapp/constants/icons.dart';
import 'package:foodapp/constants/strings.dart';
import 'package:foodapp/constants/styles.dart';
import 'package:foodapp/utilities/utils.dart';
import 'package:woocommerce/woocommerce.dart';

class CartItemTile extends StatelessWidget {
  final WooCartItem item;
  CartItemTile({this.item});
  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        "https://i0.wp.com/thefoodly.com/wp-content/uploads/2020/06/plain_pizza_f431dcc55520ce41f835a97a5383f171.fit-760w.jpg?fit=760%2C619&ssl=1";
    final String price = "100";

    final TapGestureRecognizer _updateRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Utils.showToast("Update Cart Item");
      };

    // final TapGestureRecognizer _deleteRecognizer = TapGestureRecognizer()
    //   ..onTap = () {
    //     Utils.showToast("Delete Cart Item");
    //   };

    final CachedNetworkImage _cachedImage = CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (_, url) {
        return MyShimmer.shimCont(72, width: 72);
      },
      alignment: Alignment.center,
      fit: BoxFit.cover,
      errorWidget: (_, url, error) {
        return MyShimmer.shimCont(72, width: 72);
      },
    );

    final double height = Utils.getHeightByPercentage(context, 12);

    return Container(
      height: height,
      child: Row(
        children: [
          //photo
          Container(
            height: height - 5,
            width: Utils.getWidthByPercentage(context, 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: _cachedImage,
          ),
          //name-quantity , variation
          Container(
            width: Utils.getWidthByPercentage(context, 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
                  child: Text(
                    "Burger - 1\n Chicken",
                    style: TextStyle(fontSize: 11.0, color: secondCol),
                  ),
                ),
              ],
            ),
          ),
          //price, edit , delete
          Container(
            width: Utils.getWidthByPercentage(context, 20),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: "$currency $price",
                      style: TextStyle(color: secondCol)),
                  TextSpan(
                    text: "\n\nUpdate",
                    style: tabRecognizerStyle,
                    recognizer: _updateRecognizer,
                  ),
                  // TextSpan(
                  //   text: "\nDelete",
                  //   style: tabRecognizerStyle,
                  //   recognizer: _deleteRecognizer,
                  // ),
                ],
              ),
            ),
          ),
          //delete cart item
          Container(
            child: IconButton(
              icon: Icon(clearIcon),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
