import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbdob/widgets/confirm_buy_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dbdob/widgets/connec_dialog.dart';
import 'package:intl/intl.dart' as ntl;
import 'package:intl/date_symbol_data_local.dart';

class MakeBuyDialog extends StatefulWidget {
  MakeBuyDialog({this.type});
  final String type;
  @override
  _MakeBuyDialogState createState() => _MakeBuyDialogState();
}

class _MakeBuyDialogState extends State<MakeBuyDialog> {
  final _fireStore = Firestore.instance;
  int quant = 1;
  String myDate;
  //--------------------------------------------------------------
  double total = 0.0;
  double price=0.0;
  //--------------------------------------------------------------
  void confirmOrder(String date ,String type,int q,double price) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => ConfirmBuyDialog(
        date: date,
        type: type,
        quantity: q,
        price: price,
      ),
    );
  }
  //--------------------------------------------------------------
  void connectDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => ConnecDialog(),
    );
  }
  //--------------------------------------------------------------
  getDate() {
    initializeDateFormatting("en", null).then((_) {
      var now = DateTime.now();
      var formatter = ntl.DateFormat('d-M-y');
      myDate = formatter.format(now);
    });
  }
  //--------------------------------------------------------------
  @override
  void initState() {
    getDate();
    super.initState();
  }
  //--------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'اختــار الكمية',
          style: TextStyle(
              fontSize: 25, color: Colors.purple, fontWeight: FontWeight.bold),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: 30,
                child: IconButton(
                    icon: Icon(
                      Icons.remove,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        quant--;
                        if (quant == 0) {
                          quant = 1;
                        }
                      });
                    }),
              ),
              Text(
                quant.toString(),
                style: TextStyle(fontSize: 50, color: Colors.blue),
              ),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.teal,
                child: IconButton(
                    icon: Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        quant++;
                      });
                    }),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          //----------------------------------
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              textAlign: TextAlign.start,
              onChanged: (value) {
                setState(() {
                  price = double.parse(value);
                });
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "قم بادخال المبلغ",
                labelText: "المبلغ",
              ),
            ),
          ),
          //-----------------------------------------
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
            var connectivityResult = await (Connectivity().checkConnectivity());

            if ((connectivityResult == ConnectivityResult.mobile) ||
                (connectivityResult == ConnectivityResult.wifi)) {

                _fireStore.collection('$myDate buy').add(
                  {'type': widget.type, 'quantity': quant,'price':price},
                );
              //-------------------------------------------
              Navigator.pop(context);
              confirmOrder(myDate,widget.type,quant,price);
            } else {
              Navigator.pop(context);
              connectDialog();
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
