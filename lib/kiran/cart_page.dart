import 'package:flutter/material.dart';
import 'package:foodapp/components/productDetails.dart';
import 'package:foodapp/kiran/models.dart';

class CartPage extends StatelessWidget {
  CartPage({@required this.cartList});
  final List<Foodly> cartList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CART'),
        backgroundColor: Colors.red,
      ),
      body: cartList == null
          ? SizedBox()
          : ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return ProductDetail(wooProduct: cartList[index]);
                    }));
                  },
                  leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(cartList[index].images[0].src)),
                  title: Text(cartList[index].name),
                  subtitle: Text('Tap to see detail'),
                );
              }),
    );
  }
}
