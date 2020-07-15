import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/components/productTile.dart';
import 'package:foodapp/constants/colors.dart';
import 'package:foodapp/constants/icons.dart';
import 'package:foodapp/eCommerce/eCommerce.dart';
import 'package:foodapp/utilities/utils.dart';
import 'package:woocommerce/models/products.dart';
import 'package:woocommerce/woocommerce.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<WooProduct> _products;
  String query = "";
  TextEditingController _searchController = TextEditingController();
  Ecommerce _ecommerce = Ecommerce();
  getProducts(int perPage) async {
    print("All Product Count is $perPage");
    _products = await _ecommerce.getWooProducts(1, perPage);
  }

  // getCount(List<WooProductCategory> wooProductCategory){
  //   int pCount = 0;
  //   wooProductCategory.map((productCat){
  //         for(int i=0;i<=wooProductCategory.length;i++){
  //           pCount+=productCat.count;
  //         }
  //       });
  //   return pCount;
  // }

  findTotalItems() async {
    try {
      await _ecommerce.getWooProductCategory().then((wooProductCategory) {
        // WooProductCategory allProduct = wooProductCategory[0];
        getProducts(wooProductCategory[0].count);
      });
    } catch (e) {
      print("Error while getting product counts");
    }
  }

  @override
  void initState() {
    _searchController = TextEditingController();
    findTotalItems();
    super.initState();
  }

  buildSuggestions(String query) {
    final List<WooProduct> suggestionList = query.isEmpty
        ? []
        : _products != null
            ? _products.where((WooProduct product) {
                String _productName = product.name.toLowerCase();
                String _query = query.toLowerCase();
                bool matchesName = _productName.contains(_query) ? true : false;
                // return (matchesUsername || matchesName);
                return (matchesName);
              }).toList()
            : [];
    if (suggestionList.isEmpty) {
      if (query.isNotEmpty) {
        return Container(
          child: Center(
            child: CupertinoActivityIndicator(),
          ),
        );
      } 
      // else {
      //   return Center(
      //     child: Text("Search for meals"),
      //   );
      // }
    }
    return Flexible(
      child: ListView.separated(
        separatorBuilder: (_, i) {
          return SizedBox(
            height: 5.0,
          );
        },
        itemCount: suggestionList.length,
        itemBuilder: (_, i) {
          WooProduct searchedProduct = suggestionList[i];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: ProductTile(product: searchedProduct),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              //back Button and text Field
              Container(
                height: 50.0,
                child: Row(
                  children: [
                    //Back Button
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        width: 45,
                        child: backIcon,
                        color: Colors.grey[350],
                        margin: EdgeInsets.only(left: 10, top: 10),
                      ),
                    ),
                    //Text Field
                    Container(
                      width: Utils.getWidthByPercentage(context, 80),
                      height: 50.0,
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          suffixIcon: searchIcon,
                          filled: true,
                          fillColor: Colors.grey[350],
                          // labelText: "Search for meals",
                          hintText: "Search for meals",
                          contentPadding: EdgeInsets.only(left: 30.0, top: 5),
                          enabled: true,
                          border: InputBorder.none,
                        ),
                        onChanged: (val) {
                          setState(() {
                            query = val;
                          });
                        },
                        cursorColor: mainCol,
                        autofocus: true,
                      ),
                    ),
                  ],
                ),
              ),
              //Suggestions
              buildSuggestions(query),
            ],
          ),
        ),
      ),
    );
  }
}
