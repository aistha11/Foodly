import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/components/productDetails.dart';
import 'package:foodapp/components/shimmering/myshimmer.dart';
import 'package:foodapp/constants/colors.dart';
import 'package:foodapp/constants/icons.dart';
import 'package:foodapp/constants/strings.dart';
import 'package:foodapp/utilities/utils.dart';
import 'package:woocommerce/models/products.dart';

class ProductTile extends StatelessWidget {
  final WooProduct product;
  ProductTile({@required this.product});
  @override
  Widget build(BuildContext context) {
    final double wFC = Utils.getWidthByPercentage(context, 30);
    final double wSC = Utils.getWidthByPercentage(context, 52);
    final double wTC = Utils.getWidthByPercentage(context, 10);
    final double hPT = 110.0;
    // final String description =
    //     parse((product.shortDescription).toString()).documentElement.text;

    final CachedNetworkImage _cachedImage = CachedNetworkImage(
      imageUrl: product.images[0].src,
      placeholder: (_, url) {
        return MyShimmer.shimCont(72, width: 72);
      },
      alignment: Alignment.center,
      fit: BoxFit.cover,
      errorWidget: (_, url, error) {
        return MyShimmer.shimCont(72, width: 72);
      },
    );

    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_){
          return ProductDetail(wooProduct: product);
        }));
      },
      child: Container(
        color: bgCol,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Image
            Container(
              height: hPT,
              width: wFC,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: _cachedImage,
            ),
            //Name, Description and Price
            Container(
              width: wSC,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      "${product.name}",
                      style: TextStyle(fontSize: 19.0, color: secondCol),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  //   child: Text(
                  //     // "${Utils.getNInitials(description, 8)}...",
                  //     "$description",
                  //     style: TextStyle(fontSize: 11.0, color: thirdCol),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Text(
                      "${currency}${product.price}",
                      style: TextStyle(fontSize: 16.0, color: mainCol),
                    ),
                  ),
                ],
              ),
            ),
            //Add to cart button
            Container(
              width: wTC,
              height: hPT,
              color: secondCol,
              child: Center(
                child: IconButton(
                    icon: addIcon,
                    onPressed: () {
                      Utils.showToast("Add to cart");
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
