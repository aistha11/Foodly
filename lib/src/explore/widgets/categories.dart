import 'package:flutter/material.dart';
import 'package:foodapp/components/productCategoryTile.dart';
import 'package:foodapp/components/shimmering/myshimmer.dart';
import 'package:foodapp/eCommerce/eCommerce.dart';
import 'package:woocommerce/models/product_category.dart';

class Categories extends StatelessWidget {
  final Ecommerce _ecommerce = Ecommerce();
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: Utils.getWidthByPercentage(context, 100),
      height: 100,
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: FutureBuilder(
        future: _ecommerce.getWooProductCategory(),
        builder: (BuildContext context, AsyncSnapshot<List<WooProductCategory>> snapshot) {
          switch(snapshot.connectionState){

            case ConnectionState.none:
              return MyShimmer.shimCont(100);
              break;
            case ConnectionState.waiting:
              return MyShimmer.shimCont(100);
              break;
            case ConnectionState.active:
              return MyShimmer.shimCont(100);
              break;
            case ConnectionState.done:
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, index) {
                  return SizedBox(
                    width: 1.0,
                  );
                },
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  WooProductCategory productCategory = snapshot.data[index];
                  print("PID : ${productCategory.id.toString()}");
                  return ProductCategoryTile(
                    productCategory: productCategory,
                  );
                },
              );
              break;
            default:
              return MyShimmer.shimCont(100); 

          }
        },
      ),
    );
  }
}
