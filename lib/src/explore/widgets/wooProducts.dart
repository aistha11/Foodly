import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/components/productTile.dart';
import 'package:foodapp/components/shimmering/myshimmer.dart';
import 'package:foodapp/components/splash.dart';
import 'package:foodapp/constants/colors.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:foodapp/eCommerce/eCommerce.dart';

class WooProducts extends StatefulWidget {
  @override
  _WooProductsState createState() => _WooProductsState();
}

class _WooProductsState extends State<WooProducts> {
  final Ecommerce _ecommerce = Ecommerce();

  final ScrollController _scrollController = ScrollController();

  int perPage;

  findTotalItems()async{
   try{
      await _ecommerce.getWooProductCategory().then((wooProductCategory){
      WooProductCategory allProduct = wooProductCategory[0];
      perPage = allProduct.count;
    });
   }catch(e){
     print("Error while getting product counts");
   }
  }

  @override
  void initState() {
    findTotalItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: FutureBuilder(
        future: _ecommerce.getWooProducts(1, 10),
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
              if (snapshot.data.isNotEmpty) {
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
              }else{
                return Container(
                  child: Center(child: Text("Nothing Found", style: TextStyle(color: black),),),
                );
              }
              break;
            default:
              return MyShimmer.shimCont(double.maxFinite);
          }
        },
      ),
    );
  }
}
