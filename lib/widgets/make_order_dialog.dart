import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbdob/widgets/confirm_order_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dbdob/widgets/connec_dialog.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class MakeOrderDialog extends StatefulWidget {
  MakeOrderDialog({this.type});
  final String type;
  @override
  _MakeOrderDialogState createState() => _MakeOrderDialogState();
}

class _MakeOrderDialogState extends State<MakeOrderDialog> {
  final _fireStore = Firestore.instance;
  int quant = 1;
  String myDate;
  //--------------------------------------------------------------
  String type;
  int quantity;
  double total = 0.0;
  bool checked = false;
  //--------------------------------------------------------------
  void confirmOrder(String date,bool check) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => ConfirmOrderDialog(
        date: date,check: check,
      ),
    );
  }

  void connectDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => ConnecDialog(),
    );
  }

  getDate() {
    initializeDateFormatting("en", null).then((_) {
      var now = DateTime.now();
      var formatter = DateFormat('d-M-y');
      myDate = formatter.format(now);
    });
  }

  @override
  void initState() {
    getDate();
    super.initState();
  }

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
          //----------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              (checked)
                  ? IconButton(
                      icon: Icon(
                        Icons.check_box,
                        color: Colors.purple,
                        size: 40,
                      ),
                      onPressed: () {
                        setState(() {
                          checked = !checked;
                        });
                      },
                    )
                  : IconButton(
                      icon: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.purple,
                        size: 40,
                      ),
                      onPressed: () {
                        setState(() {
                          checked = !checked;
                        });
                      },
                    ),
              SizedBox(
                width: 20,
              ),
              Text(
                'ضيافة',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.purple,
                ),
              ),
            ],
          )
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
//add host when checked == true
              if (checked == true) {
                _fireStore.collection('$myDate host').add(
                  {'type': widget.type, 'quantity': quant},
                );
//                _fireStore.collection('host').document('$myDate').setData(
//                  {'type': widget.type, 'quantity': quant, 'date': myDate},
//                );
              } else {
                _fireStore.collection('$myDate').add(
                  {
                    'type': widget.type,
                    'quantity': quant,
                  },
                );
              }
              //-------------------------------------------
              Navigator.pop(context);
              confirmOrder(myDate,checked);
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
