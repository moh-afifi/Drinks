import 'package:flutter/material.dart';
import 'package:dbdob/widgets/connec_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ConfirmCleanDialog extends StatefulWidget {
  ConfirmCleanDialog({this.date, this.price});
  final String date;
  final double price;
  @override
  _ConfirmCleanDialogState createState() => _ConfirmCleanDialogState();
}

class _ConfirmCleanDialogState extends State<ConfirmCleanDialog> {
  final _fireStore = Firestore.instance;
  String type;
  int quantity;
  double buySum = 0;
  double myTotalBuy = 0;
  bool showSpinner = false;
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
      child: Builder(
        builder: (context) => ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: AlertDialog(
            title: Image.asset('images/check.gif',height: 80,width: 100,),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //----------------------------------------
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
                      setState(() {
                        showSpinner=true;
                      });
                      DocumentSnapshot overallClean = await _fireStore
                          .collection('buy')
                          .document('${widget.date}')
                          .get();
                      double pastClean;
                      if(overallClean.exists){
                        pastClean= overallClean.data['sum'];
                      }else{
                        pastClean= 0.0;
                      }

                      double mySumClean = widget.price + pastClean;

                      String uniqueCode = widget.date;
                      DocumentReference reference =
                          _fireStore.document("buy/" + uniqueCode);
                      Map<String, double> myData = {'sum': mySumClean};
                      reference.setData(myData);
                      //----------------------------------------------------------------------------

                      myTotalBuy = widget.price;
                      DocumentSnapshot overallBuy = await _fireStore
                          .collection('overallBuy')
                          .document('totalBuy')
                          .get();
                      double pastSum = (overallBuy.data['totalBuy']).toDouble();

                      double mySum = myTotalBuy + pastSum;

                      String uniqueCode2 = 'totalBuy';
                      DocumentReference reference2 =
                          _fireStore.document("overallBuy/" + uniqueCode2);
                      Map<String, double> myData2 = {'totalBuy': mySum};
                      reference2.setData(myData2);

                      //----------------------------------------------------
                      setState(() {
                        showSpinner=false;
                      });
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
        ),
      ),
    );
  }
}
