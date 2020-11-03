import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dbdob/widgets/connec_dialog.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class ConfirmBuyDialog extends StatefulWidget {
  ConfirmBuyDialog({this.date, this.type, this.quantity,this.price});
  final String date;
  final String type;
  final int quantity;
  final double price;
  @override
  _ConfirmBuyDialogState createState() => _ConfirmBuyDialogState();
}

class _ConfirmBuyDialogState extends State<ConfirmBuyDialog> {
  final _fireStore = Firestore.instance;
  double buySum = 0;
  String type;
  double myTotalBuy = 0;
  double typePrice = 0;
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
//                      if (widget.type == 'شاى') {
//                        typePrice = 20.0 * (widget.quantity);
//                      } else if (widget.type == 'نسكافيه') {
//                        typePrice = 40.0 * (widget.quantity);
//                      } else if (widget.type == 'نسكافيه بلاك') {
//                        typePrice = 21.0 * (widget.quantity);
//                      } else if (widget.type == 'بونجورنو') {
//                        typePrice = 40.0 * (widget.quantity);
//                      } else if (widget.type == 'كوفي ميكس') {
//                        typePrice = 20.0 * (widget.quantity);
//                      } else if (widget.type == 'ينسون') {
//                        typePrice = 28.0 * (widget.quantity);
//                      } else if (widget.type == 'كركديه') {
//                        typePrice = 28.0 * (widget.quantity);
//                      } else if (widget.type == 'نعناع') {
//                        typePrice = 28.0 * (widget.quantity);
//                      } else if (widget.type == 'مياه') {
//                        typePrice = 30.0 * (widget.quantity);
//                      } else if (widget.type == 'قهوة') {
//                        typePrice = 90.0 * (widget.quantity);
//                      } else if (widget.type == 'تلقيمة') {
//                        typePrice = 22.0 * (widget.quantity);
//                      } else if (widget.type == '3x1 لبن') {
//                        typePrice = 30.0 * (widget.quantity);
//                      } else if (widget.type == 'عصير') {
//                        typePrice = 3.75 * (widget.quantity);
//                      } else if (widget.type == 'لبن بودرة') {
//                        typePrice = 45.0 * (widget.quantity);
//                      } else if (widget.type == 'نسكافيه جولد') {
//                        typePrice = 38.0 * (widget.quantity);
//                      } else if (widget.type == 'سكر') {
//                        typePrice = 10.0 * (widget.quantity);
//                      } else if (widget.type == 'كوب صغير') {
//                        typePrice = 17.0 * (widget.quantity);
//                      } else if (widget.type == 'كوب كبير') {
//                        typePrice = 20.0 * (widget.quantity);
//                      }
                      //-------------------------------------------------

                      DocumentSnapshot sumBuy = await _fireStore
                          .collection('buy')
                          .document('${widget.date}')
                          .get();

                      double pastSumBuy;
                      if (sumBuy.exists) {
                        pastSumBuy = sumBuy.data['sum'];
                      } else {
                        pastSumBuy = 0.0;
                      }

                      double mySumBuy = widget.price + pastSumBuy;
                      //-------------------------------------------------
                      String uniqueCode = widget.date;
                      DocumentReference reference =
                          _fireStore.document("buy/" + uniqueCode);
                      Map<String, double> myData = {'sum': mySumBuy};
                      reference.setData(myData);
                      //-----------------------------------------------------
//                      if (widget.type == 'شاى') {
//                        myTotalBuy = 20.0 * (widget.quantity);
//                      } else if (widget.type == 'نسكافيه') {
//                        myTotalBuy = 40.0 * (widget.quantity);
//                      } else if (widget.type == 'نسكافيه بلاك') {
//                        myTotalBuy = 21.0 * (widget.quantity);
//                      } else if (widget.type == 'بونجورنو') {
//                        myTotalBuy = 40.0* (widget.quantity);
//                      } else if (widget.type == 'كوفي ميكس') {
//                        myTotalBuy = 20.0* (widget.quantity);
//                      } else if (widget.type == 'ينسون') {
//                        myTotalBuy = 28.0* (widget.quantity);
//                      } else if (widget.type == 'كركديه') {
//                        myTotalBuy = 28.0* (widget.quantity);
//                      } else if (widget.type == 'نعناع') {
//                        myTotalBuy = 28.0* (widget.quantity);
//                      } else if (widget.type == 'مياه') {
//                        myTotalBuy = 30.0* (widget.quantity);
//                      } else if (widget.type == 'قهوة') {
//                        myTotalBuy = 90.0* (widget.quantity);
//                      } else if (widget.type == 'تلقيمة') {
//                        myTotalBuy = 22.0* (widget.quantity);
//                      } else if (widget.type == '3x1 لبن') {
//                        myTotalBuy = 30.0* (widget.quantity);
//                      } else if (widget.type == 'عصير') {
//                        myTotalBuy = 3.75* (widget.quantity);
//                      } else if (widget.type == 'لبن بودرة') {
//                        myTotalBuy = 45.0* (widget.quantity);
//                      } else if (widget.type == 'نسكافيه جولد') {
//                        myTotalBuy = 38.0* (widget.quantity);
//                      } else if (widget.type == 'سكر') {
//                        myTotalBuy = 10.0* (widget.quantity);
//                      } else if (widget.type == 'كوب صغير') {
//                        myTotalBuy = 17.0* (widget.quantity);
//                      } else if (widget.type == 'كوب كبير') {
//                        myTotalBuy = 20.0* (widget.quantity);
//                      }

                      //--------------------------------------------------
                      DocumentSnapshot overallBuy = await _fireStore
                          .collection('overallBuy')
                          .document('totalBuy')
                          .get();
                      double pastSum = (overallBuy.data['totalBuy']).toDouble();

                      double mySum = widget.price + pastSum;

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
