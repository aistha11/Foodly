import 'package:flutter/material.dart';
import 'package:foodapp/eCommerce/eCommerce.dart';
import 'package:woocommerce/woocommerce.dart';

class Test extends StatelessWidget {
  final Ecommerce _ecommerce = Ecommerce();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: FutureBuilder(
            future: _ecommerce.getWooProductVariations(1602),
            builder: (_, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Container(
                    child: Center(
                      child: Text("None"),
                    ),
                  );
                  break;
                case ConnectionState.waiting:
                  return Container(
                    child: Center(
                      child: Text("Waiting"),
                    ),
                  );
                  break;
                case ConnectionState.active:
                  return Container(
                    child: Center(
                      child: Text("Active"),
                    ),
                  );
                  break;
                case ConnectionState.done:
                  // WooProductVariation doc = snapshot.data[0];
                  //   return Container(
                  //     child: Text("${doc.id}"),
                  //   );
                  List<dynamic> doclist = snapshot.data;
                  return ListView.builder(
                    itemCount: doclist.length,
                    itemBuilder: (_, i) {
                      WooProductVariation item = doclist[i];
                      print(item);
                      return Container(
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text("Id")),
                            DataColumn(label: Text("Price")),
                          ],
                          rows: [
                            DataRow(
                              cells: [
                                DataCell(Text("${item.id}")),
                                DataCell(Text("${item.price}")),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                  break;
                default:
                  return Container(
                    child: Center(
                      child: Text("Default"),
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
