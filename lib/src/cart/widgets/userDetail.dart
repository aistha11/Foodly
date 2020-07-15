import 'package:flutter/material.dart';
import 'package:foodapp/constants/colors.dart';
import 'package:foodapp/constants/styles.dart';
import 'package:foodapp/utilities/utils.dart';

class UserDetail extends StatelessWidget {
  final String name;
  final String address;
  final String contact;
  UserDetail({@required this.name,@required this.address, @required this.contact});
  @override
  Widget build(BuildContext context) {
    return Container(
                        height: Utils.getHeightByPercentage(context, 16),
                        color: mainCol,
                        child: Row(
                          children: [
                            Container(
                              width: Utils.getWidthByPercentage(context, 70),
                              padding: EdgeInsets.only(
                                left: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Name: $name",
                                    style: cartTextStyle,
                                  ),
                                  Text(
                                    "Address: $address",
                                    style: cartTextStyle,
                                  ),
                                  Text(
                                    "Contact: $contact",
                                    style: cartTextStyle,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              alignment: Alignment.topCenter,
                              child: FlatButton(
                                onPressed: () {
                                  Utils.showToast("Edit Profile");
                                },
                                child: Text(
                                  "Edit",
                                  style: TextStyle(color: secondCol),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
  }
}