import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dbdob/widgets/connec_dialog.dart';

class ConfirmOrderDialog extends StatefulWidget {
  ConfirmOrderDialog({this.date, this.check});
  final String date;
  final bool check;
  @override
  _ConfirmOrderDialogState createState() => _ConfirmOrderDialogState();
}

class _ConfirmOrderDialogState extends State<ConfirmOrderDialog> {
  final _fireStore = Firestore.instance;
  int quantity;
  double totalSum = 0;
  double hostSum = 0;
  String type;

  void connectDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => ConnecDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: AlertDialog(
        title: Image.asset('images/check.gif'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            (widget.check == false)
                ? StreamBuilder<QuerySnapshot>(
                    stream: _fireStore.collection('${widget.date}').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.blueAccent,
                          ),
                        );
                      }
//------------------------------------------------------------------------
                      final items = snapshot.data.documents;

                      int teaSum = 0,
                          nescafeSum = 0,
                          coffeeSum = 0,
                          blackSum = 0,
                          mixSum = 0,
                          bonjSum = 0,
                          waterSum = 0,
                          teaMilkSum = 0,
                          nescafeMilkSum = 0,
                          karkSum = 0,
                          yanSum = 0,
                          mintSum = 0,
                          talkemaSum = 0,
                          milkySum = 0,
                          juiceSum = 0;

                      List<int> teaList = [];
                      List<int> nescafeList = [];
                      List<int> coffeeList = [];
                      List<int> blackList = [];
                      List<int> mixList = [];
                      List<int> bonjList = [];
                      List<int> karkList = [];
                      List<int> yanList = [];
                      List<int> mintList = [];
                      List<int> waterList = [];
                      List<int> teaMilkList = [];
                      List<int> nescafeMilkList = [];
                      List<int> talkemaList = [];
                      List<int> milkyList = [];
                      List<int> juiceList = [];

                      for (var item in items) {
                        type = item.data['type'];
                        quantity = item.data['quantity'];

                        if (type == 'شاى') {
                          teaList.add(quantity);
                          teaSum = teaList.reduce((a, b) => a + b);
                        } else if (type == 'نسكافيه') {
                          nescafeList.add(quantity);
                          nescafeSum = nescafeList.reduce((a, b) => a + b);
                        } else if (type == 'نسكافيه بلاك') {
                          blackList.add(quantity);
                          blackSum = blackList.reduce((a, b) => a + b);
                        } else if (type == 'بونجورنو') {
                          bonjList.add(quantity);
                          bonjSum = bonjList.reduce((a, b) => a + b);
                        } else if (type == 'كوفي ميكس') {
                          mixList.add(quantity);
                          mixSum = mixList.reduce((a, b) => a + b);
                        } else if (type == 'ينسون') {
                          yanList.add(quantity);
                          yanSum = yanList.reduce((a, b) => a + b);
                        } else if (type == 'كركديه') {
                          karkList.add(quantity);
                          karkSum = karkList.reduce((a, b) => a + b);
                        } else if (type == 'نعناع') {
                          mintList.add(quantity);
                          mintSum = mintList.reduce((a, b) => a + b);
                        } else if (type == 'مياه') {
                          waterList.add(quantity);
                          waterSum = waterList.reduce((a, b) => a + b);
                        } else if (type == 'قهوة') {
                          coffeeList.add(quantity);
                          coffeeSum = coffeeList.reduce((a, b) => a + b);
                        } else if (type == 'شاى بلبن') {
                          teaMilkList.add(quantity);
                          teaMilkSum = teaMilkList.reduce((a, b) => a + b);
                        } else if (type == 'نسكافيه بلبن') {
                          nescafeMilkList.add(quantity);
                          nescafeMilkSum =
                              nescafeMilkList.reduce((a, b) => a + b);
                        } else if (type == 'تلقيمة') {
                          talkemaList.add(quantity);
                          talkemaSum = talkemaList.reduce((a, b) => a + b);
                        } else if (type == '3x1 لبن') {
                          milkyList.add(quantity);
                          milkySum = milkyList.reduce((a, b) => a + b);
                        } else if (type == 'عصير') {
                          juiceList.add(quantity);
                          juiceSum = juiceList.reduce((a, b) => a + b);
                        }
                      }
                      totalSum = teaSum * 3 +
                          nescafeSum * 4 +
                          coffeeSum * 5 +
                          blackSum * 3 +
                          mixSum * 4 +
                          bonjSum * 6 +
                          karkSum * 3.5 +
                          yanSum * 3.5 +
                          mintSum * 3.5 +
                          waterSum * 3 +
                          teaMilkSum * 5 +
                          nescafeMilkSum * 5 +
                          talkemaSum * 5 +
                          milkySum * 5 +
                          juiceSum * 5;
//-------------------------------------------------------------------------
                      return SizedBox();
                    },
                  )
                : StreamBuilder<QuerySnapshot>(
                    stream: _fireStore.collection('${widget.date} host').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.blueAccent,
                          ),
                        );
                      }
//------------------------------------------------------------------------
                      final items = snapshot.data.documents;

                      int teaSum = 0,
                          nescafeSum = 0,
                          coffeeSum = 0,
                          blackSum = 0,
                          mixSum = 0,
                          bonjSum = 0,
                          waterSum = 0,
                          teaMilkSum = 0,
                          nescafeMilkSum = 0,
                          karkSum = 0,
                          yanSum = 0,
                          mintSum = 0,
                          talkemaSum = 0,
                          milkySum = 0,
                          juiceSum = 0;

                      List<int> teaList = [];
                      List<int> nescafeList = [];
                      List<int> coffeeList = [];
                      List<int> blackList = [];
                      List<int> mixList = [];
                      List<int> bonjList = [];
                      List<int> karkList = [];
                      List<int> yanList = [];
                      List<int> mintList = [];
                      List<int> waterList = [];
                      List<int> teaMilkList = [];
                      List<int> nescafeMilkList = [];
                      List<int> talkemaList = [];
                      List<int> milkyList = [];
                      List<int> juiceList = [];

                      for (var item in items) {
                        type = item.data['type'];
                        quantity = item.data['quantity'];

                        if (type == 'شاى') {
                          teaList.add(quantity);
                          teaSum = teaList.reduce((a, b) => a + b);
                        } else if (type == 'نسكافيه') {
                          nescafeList.add(quantity);
                          nescafeSum = nescafeList.reduce((a, b) => a + b);
                        } else if (type == 'نسكافيه بلاك') {
                          blackList.add(quantity);
                          blackSum = blackList.reduce((a, b) => a + b);
                        } else if (type == 'بونجورنو') {
                          bonjList.add(quantity);
                          bonjSum = bonjList.reduce((a, b) => a + b);
                        } else if (type == 'كوفي ميكس') {
                          mixList.add(quantity);
                          mixSum = mixList.reduce((a, b) => a + b);
                        } else if (type == 'ينسون') {
                          yanList.add(quantity);
                          yanSum = yanList.reduce((a, b) => a + b);
                        } else if (type == 'كركديه') {
                          karkList.add(quantity);
                          karkSum = karkList.reduce((a, b) => a + b);
                        } else if (type == 'نعناع') {
                          mintList.add(quantity);
                          mintSum = mintList.reduce((a, b) => a + b);
                        } else if (type == 'مياه') {
                          waterList.add(quantity);
                          waterSum = waterList.reduce((a, b) => a + b);
                        } else if (type == 'قهوة') {
                          coffeeList.add(quantity);
                          coffeeSum = coffeeList.reduce((a, b) => a + b);
                        } else if (type == 'شاى بلبن') {
                          teaMilkList.add(quantity);
                          teaMilkSum = teaMilkList.reduce((a, b) => a + b);
                        } else if (type == 'نسكافيه بلبن') {
                          nescafeMilkList.add(quantity);
                          nescafeMilkSum =
                              nescafeMilkList.reduce((a, b) => a + b);
                        } else if (type == 'تلقيمة') {
                          talkemaList.add(quantity);
                          talkemaSum = talkemaList.reduce((a, b) => a + b);
                        } else if (type == '3x1 لبن') {
                          milkyList.add(quantity);
                          milkySum = milkyList.reduce((a, b) => a + b);
                        } else if (type == 'عصير') {
                          juiceList.add(quantity);
                          juiceSum = juiceList.reduce((a, b) => a + b);
                        }
                      }
                      hostSum = teaSum * 3 +
                          nescafeSum * 4 +
                          coffeeSum * 5 +
                          blackSum * 3 +
                          mixSum * 4 +
                          bonjSum * 6 +
                          karkSum * 3.5 +
                          yanSum * 3.5 +
                          mintSum * 3.5 +
                          waterSum * 3 +
                          teaMilkSum * 5 +
                          nescafeMilkSum * 5 +
                          talkemaSum * 5 +
                          milkySum * 5 +
                          juiceSum * 5;
//-------------------------------------------------------------------------
                      return SizedBox();
                    },
                  ),
            Text(
              'تمت إضافة هذا العنصر بنجاح',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            FlatButton(
              color: Colors.teal,
              child: Text(
                'موافق',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () async {
                var connectivityResult =
                    await (Connectivity().checkConnectivity());
                if ((connectivityResult == ConnectivityResult.mobile) ||
                    (connectivityResult == ConnectivityResult.wifi)) {
                  //----------------------------------------
                  if (widget.check == false) {
                    String uniqueCode = widget.date;
                    DocumentReference reference =
                        _fireStore.document("sum/" + uniqueCode);
                    Map<String, double> myData = {'sum': totalSum};
                    reference.setData(myData);
                  } else {
                    String uniqueCode = widget.date;
                    DocumentReference reference =
                        _fireStore.document("host/" + uniqueCode);
                    Map<String, double> myData = {'sum': hostSum};
                    reference.setData(myData);
                  }
                  //----------------------------------------------------
                  Navigator.pop(context);
                } else {
                  connectDialog();
                }
              },
            ),
          ],
        ),
        elevation: 8.0,
      ),
    );
  }
}
