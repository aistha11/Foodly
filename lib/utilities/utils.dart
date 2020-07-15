import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/components/appbar.dart';
import 'package:foodapp/constants/colors.dart';
import 'package:foodapp/constants/icons.dart';
import 'package:share/share.dart';

class Utils {
  //to derive username from email address
  static String getUsername(String email) {
    return "${email.split('@')[0]}";
  }
  //
  static share(BuildContext context, String text, String subject) {
    final RenderBox box = context.findRenderObject();
    Share.share(text,
        subject: subject,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  static showKeyboard(textFieldFocus) => textFieldFocus.requestFocus();

  static hideKeyboard(textFieldFocus) => textFieldFocus.unfocus();

  static showToast(String msg) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.greenAccent,
    );
  }

 static Future<bool> confirmBox(BuildContext context, String title, String content) async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: <Widget>[
                FlatButton(
                  child: Text("No"),
                  onPressed: () => Navigator.pop(context, false),
                ),
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () => Navigator.pop(context, true),
                ),
              ],
            ));
  }

  static double getWidthByPercentage(BuildContext context,double percent){
    Size size = MediaQuery.of(context).size;
    return (percent/100)*size.width;
  }

  static double getHeightByPercentage(BuildContext context,double percent){
    Size size = MediaQuery.of(context).size;
    return (percent/100)*size.height;
  }

  static String getInitials(String name) {
    if(name!=null){
      List<String> nameSplit = name.split(" ");
    String firstNameInitial = nameSplit[0][0];
    String lastNameInitial = nameSplit[1][0];
    return firstNameInitial + lastNameInitial;
    }else{
      return "NS";
    }
    
  }

  static String getFirstInitials(String string){
    List<String> stringSplit = string.split(" ");
    String firstInitials = stringSplit[0];
    return firstInitials;
  }
  static String getNInitials(String string, int n){
    List<String> stringSplit = string.split(" ");
    // String fiveInitials = "${stringSplit[0]} ${stringSplit[1]} ${stringSplit[2]} ${stringSplit[3]} ${stringSplit[4]} ${stringSplit[5]}";
    String result = "";
    for(int i=0;i<=n;i++){
      result+=" ${stringSplit[i]}";
    }
    return result;
  }

  static CustomAppBar customAppBar(context) => CustomAppBar(
            leading: Container(
              decoration: BoxDecoration(
                color: mainCol,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: leadAppIcon,
                onPressed: () {
                  Navigator.of(context).pushNamed("/test");
                },
              ),
            ),
            title: Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: thirdCol,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: locationIcon,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Ramechhap",
                          style: TextStyle(color: mainCol, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 8.0),
                    child: downArrowIcon,
                  ),
                ],
              ),
            ),
            centerTitle: true,
            actions: [
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pushNamed("/auth");
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: mainCol,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          );
}