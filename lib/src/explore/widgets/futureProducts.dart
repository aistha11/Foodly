import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/components/productTile.dart';
import 'package:foodapp/components/shimmering/myshimmer.dart';
import 'package:foodapp/components/splash.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:foodapp/eCommerce/eCommerce.dart';

class FutureProducts extends StatelessWidget {
  final int page;
  final int perPage;
  FutureProducts({
    @required this.page,
    @required this.perPage,
  });
  final Ecommerce _ecommerce = Ecommerce();
  final ScrollController _scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: FutureBuilder(
        future: _ecommerce.getWooProducts(page, perPage),
        builder:
            (BuildContext context, AsyncSnapshot<List<WooProduct>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return MyShimmer.shimCont(double.maxFinite);
              break;
            case ConnectionState.waiting:
              return MyShimmer.shimCont(double.maxFinite);
              break;
            case ConnectionState.active:
              return MyShimmer.shimCont(double.maxFinite);
              break;
            case ConnectionState.done:
              return ListView.separated(
                controller: _scrollController,
                separatorBuilder: (_, index) {
                  return SizedBox(
                    height: 5.0,
                  );
                },
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  WooProduct product = snapshot.data[index];
                  return ProductTile(
                    product: product,
                  );
                },
              );
              break;
            default:
              return Splash();
          }
        },
      ),
    );
  }
}
