// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/components/cachedImage/cachedImage.dart';
import 'package:foodapp/components/productCategoryDetail.dart';
// import 'package:foodapp/components/shimmering/myshimmer.dart';
import 'package:foodapp/constants/colors.dart';
import 'package:foodapp/utilities/utils.dart';
import 'package:woocommerce/woocommerce.dart';

class ProductCategoryTile extends StatelessWidget {
  final WooProductCategory productCategory;
  ProductCategoryTile({this.productCategory});
  @override
  Widget build(BuildContext context) {
    // final CachedNetworkImage _cachedImage = CachedNetworkImage(
    //   imageUrl: productCategory.image.src,
    //   placeholder: (_, url) {
    //     return MyShimmer.shimCont(72, width: 72);
    //   },
    //   alignment: Alignment.center,
    //   fit: BoxFit.cover,
    //   errorWidget: (_, url, error) {
    //     return MyShimmer.shimCont(72, width: 72);
    //   },
    // );
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return ProductCategoryDetail(category: productCategory);
        }));
      },
      child: Container(
        width: Utils.getWidthByPercentage(context, 23),
        height: 100,
        color: Colors.grey[200],
        child: Column(
          children: [
            //Image
            SizedBox(
              width: 72,
              height: 72,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedImage(
                  productCategory.image.src,
                  fit: BoxFit.cover,
                  isRound: false,
                  width: 72,
                  height: 72,
                ),
              ),
            ),
            //name with count
            Text(
              "${Utils.getFirstInitials(productCategory.name)}(${productCategory.count})",
              style: TextStyle(
                color: secondCol,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
