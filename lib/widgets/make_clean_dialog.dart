import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbdob/widgets/confirm_clean_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dbdob/widgets/connec_dialog.dart';
import 'package:intl/intl.dart' as ntl;
import 'package:intl/date_symbol_data_local.dart';

class CleanMakeDialog extends StatefulWidget {
  CleanMakeDialog({this.type});
  final String type;

  @override
  _CleanMakeDialogState createState() => _CleanMakeDialogState();
}

class _CleanMakeDialogState extends State<CleanMakeDialog> {
  final _fireStore = Firestore.instance;
  String myDate;
  String price,desc;

  void confirmOrder(String date ,double price) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => ConfirmCleanDialog(date: date,price: price,),
    );
  }
  //--------------------------------------------------
  void connectDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => ConnecDialog(),
    );
  }
  //--------------------------------------------------
  getDate() {
    initializeDateFormatting("en", null).then((_) {
      var now = DateTime.now();
      var formatter = ntl.DateFormat('d-M-y');
      myDate = formatter.format(now);
    });
  }
  //--------------------------------------------------
  @override
  void initState() {
    getDate();
    super.initState();
  }
  //--------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'مصروفات إدارية',
          style: TextStyle(
              fontSize: 25, color: Colors.purple, fontWeight: FontWeight.bold),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            ':المبلغ',
            style: TextStyle(
                fontSize: 20, color: Colors.purple, fontWeight: FontWeight.bold),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                  price = value;
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "قم بادخال المبلغ",
               // labelText: "المبلغ",
              ),
            ),
          ),
          SizedBox(height: 10,),
          //----------------------------------
          Text(
            ':الوصف',
            style: TextStyle(
                fontSize: 20, color: Colors.purple, fontWeight: FontWeight.bold),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                  desc = value;
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "قم بادخال الوصف",
               // labelText: "الوصف",
              ),
            ),
          ),
        ],
      ),
      elevation: 8.0,
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.red,
          child: Text(
            'إلغاء',
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(
          width: 100,
        ),
        FlatButton(
          color: Colors.teal,
          child: Text(
            'موافق',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () async {
            if(price==null || desc ==null){

            }else{
              var connectivityResult = await (Connectivity().checkConnectivity());

              if ((connectivityResult == ConnectivityResult.mobile) ||
                  (connectivityResult == ConnectivityResult.wifi)) {
                _fireStore.collection('$myDate clean').add(
                  {'type': widget.type, 'price': double.parse(price),'desc':desc},
                );
                //-------------------------------------------
                Navigator.pop(context);
                confirmOrder(myDate,double.parse(price));
              } else {
                Navigator.pop(context);
                connectDialog();
              }
            }

            //-------------------------------------------
          },
        ),
        SizedBox(
          width: 2,
        ),
      ],
    );
  }
}
