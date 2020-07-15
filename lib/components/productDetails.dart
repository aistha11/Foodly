import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/components/shimmering/myshimmer.dart';
import 'package:foodapp/constants/colors.dart';
import 'package:foodapp/constants/icons.dart';
import 'package:foodapp/constants/strings.dart';
import 'package:foodapp/eCommerce/eCommerce.dart';
import 'package:foodapp/utilities/utils.dart';
import 'package:html/parser.dart';
import 'package:woocommerce/woocommerce.dart';

class ProductDetail extends StatefulWidget {
  final wooProduct;
  ProductDetail({@required this.wooProduct});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final Ecommerce _ecommerce = Ecommerce();

  Future<List<WooProductVariation>> varients;
  List<WooProductVariation> selectedVariations = [];
  WooProductVariation productVariation;
  int _counter = 1;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter > 1)
      setState(() {
        _counter--;
      });
  }

  getVariation()async{
    try{
      productVariation = await  _ecommerce.getWooProductVariation(widget.wooProduct.id, widget.wooProduct.variations[0]);
    }catch(e){
      print("Error got in getVariation function");
    }
  }

  @override
  void initState() {
    varients = _ecommerce.getWooProductVariations(widget.wooProduct.id);
    getVariation();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int productId = widget.wooProduct.id;

    final double radius = 30;
    final double contHeight = 250;
    final CachedNetworkImage _cachedImage = CachedNetworkImage(
      imageUrl: widget.wooProduct.images[0].src,
      placeholder: (_, url) {
        return MyShimmer.shimCont(72, width: 72);
      },
      alignment: Alignment.center,
      fit: BoxFit.cover,
      errorWidget: (_, url, error) {
        return MyShimmer.shimCont(72, width: 72);
      },
    );

    final String description =
        parse((widget.wooProduct.description).toString()).documentElement.text;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Image
          Container(
            width: Utils.getWidthByPercentage(context, 100),
            height: contHeight,
            decoration: BoxDecoration(
              color: mainCol,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
              ),
              child: _cachedImage,
            ),
          ),
          //Product name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
            child: Center(
              child: Text(
                "${widget.wooProduct.name}",
                style: TextStyle(fontSize: 28.0, color: mainCol),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Divider(
            color: thirdCol,
            thickness: 1,
            indent: 30,
            endIndent: 30,
          ),
          //Varients
          widget.wooProduct.attributes.isNotEmpty
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: Text(
                        "${widget.wooProduct.attributes[0].name}",
                        style: TextStyle(color: secondCol, fontSize: 19),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 36),
                      child: Wrap(
                        children: widget.wooProduct.attributes[0].options.map<Widget>((e) {
                                return Text("${e} ");
                              }).toList(),
                      ),
                    ),
                    Divider(
                      color: thirdCol,
                      thickness: 1,
                      indent: 30,
                      endIndent: 30,
                    ),
                  ],
                )
              : Container(),

          //Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Text(
              "Description:",
              style: TextStyle(color: secondCol, fontSize: 19),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36.0, right: 8.0),
            child: Text(
              "$description",
              style: TextStyle(fontSize: 11.0, color: thirdCol),
            ),
          ),
          Divider(
            color: thirdCol,
            thickness: 1,
            indent: 30,
            endIndent: 30,
          ),
          //Price
          Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 36),
                  child: Text(
                    "Price:",
                    style: TextStyle(color: secondCol, fontSize: 19),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        widget.wooProduct.regularPrice != ""
                            ? TextSpan(
                                text:
                                    "${currency}${widget.wooProduct.regularPrice} ",
                                style: TextStyle(
                                    color: thirdCol,
                                    fontSize: 16,
                                    decoration: TextDecoration.lineThrough),
                              )
                            : TextSpan(),
                        widget.wooProduct.salePrice != ""
                            ? TextSpan(
                                text:
                                    " ${currency}${widget.wooProduct.salePrice}",
                                style: TextStyle(color: mainCol, fontSize: 16),
                              )
                            : TextSpan(
                                text: " ${currency}${widget.wooProduct.price}",
                                style: TextStyle(color: mainCol, fontSize: 16),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: thirdCol,
            thickness: 1,
            indent: 30,
            endIndent: 30,
          ),
          //Back, counter and Add to cart
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      child: backIcon,
                      color: mainCol,
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: _decrementCounter,
                        child: Container(
                          width: 30,
                          height: 45,
                          decoration: BoxDecoration(
                            border: Border.all(color: thirdCol),
                          ),
                          child: Center(child: Icon(Icons.remove)),
                        ),
                      ),
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(color: thirdCol),
                        ),
                        child: Center(child: Text("$_counter")),
                      ),
                      GestureDetector(
                        onTap: _incrementCounter,
                        child: Container(
                          width: 30,
                          height: 45,
                          decoration: BoxDecoration(
                            border: Border.all(color: thirdCol),
                          ),
                          child: Center(child: Icon(Icons.add)),
                        ),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  color: mainCol,
                  textColor: secondCol,
                  child: Text("Add to Cart"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        bottomLeft: Radius.circular(40)),
                  ),
                  onPressed: () async {
                    if (await _ecommerce.addToCart(productId, _counter, variations: [productVariation])) {
                      Utils.showToast("Successfully added to cart");
                    } else {
                      Utils.showToast("Error while adding to cart");
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
