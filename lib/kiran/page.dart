import 'package:flutter/material.dart';
import 'package:foodapp/components/productDetails.dart';
import 'package:foodapp/kiran/cart_page.dart';
import 'package:foodapp/kiran/models.dart';
import 'package:foodapp/kiran/repo.dart';
import 'package:foodapp/kiran/stream.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Foodly> _foodly;
  void call() async {
    ProductPageRepo productPageRepo = ProductPageRepo();
    List<Foodly> foodly = await productPageRepo.call('products');
    setState(() {
      _foodly = foodly;
    });
  }

  @override
  void initState() {
    call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Foodly> cart = [];
    CartStream cartStream = CartStream();
    // add item to cart
    void addToCart(Foodly product) {
      Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(product.name + ' added to cart')));
      cart.add(product);
      cartStream.sink.add(cart);
    }

    return Scaffold(
      appBar: AppBar(
          title: Text('Products'),
          backgroundColor: Colors.red,
          actions: [
            Stack(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => CartPage(cartList: cart)))),
                StreamBuilder<List<Foodly>>(
                    stream: cartStream.stream,
                    builder: (context, snapshot) {
                      return Container(
                          width: 20,
                          height: 20,
                          child: Center(
                              child: Text(
                                  snapshot.hasData
                                      ? snapshot.data.length.toString()
                                      : '0',
                                  style: TextStyle(color: Colors.black))),
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(100)));
                    })
              ],
            )
          ]),
      body: _foodly == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _foodly.length,
              itemBuilder: (context, index) {
                return ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return ProductDetail(wooProduct: _foodly[index]);
                      }));
                    },
                    leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(_foodly[index].images[0].src)),
                    title: Text(_foodly[index].name),
                    subtitle: Text('Tap to see detail'),
                    trailing: IconButton(
                      icon: Icon(Icons.add_circle, color: Colors.orange),
                      onPressed: () => addToCart(_foodly[index]),
                    ));
              }),
    );
  }
}
