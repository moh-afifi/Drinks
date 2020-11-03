import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:dbdob/reusables/reusable_week_card.dart';
import 'package:dbdob/screens/today_report/today_report.dart';
import 'package:dbdob/reusables/reusable_daily_card.dart';
import 'package:dbdob/reusables/total_sum_card.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dbdob/screens/week_report/weekly_report.dart';
import 'package:dbdob/screens/buy_report/buy.dart';
import 'package:dbdob/screens/buy_report/weekly_buy.dart';
import 'package:dbdob/reusables/buy_daily_card.dart';
import 'safe.dart';

class Weekly extends StatefulWidget {
  @override
  _WeeklyState createState() => _WeeklyState();
}

class _WeeklyState extends State<Weekly> {
  final _fireStore = Firestore.instance;
  double totalSum = 0;
  double eachSum = 0;
  double overallSum = 0;
  double hostTotalSum = 0;
  double hostEachSum = 0;
  double totalBuySum = 0.0;
  double eachBuySum = 0.0;
  String from, to, monthFrom, monthTo, year;
  bool showSpinner = false;
  //------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(
          'التقرير',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Builder(
        builder: (context) => ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/back1.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.9), BlendMode.dstATop),
              ),
            ),
            constraints: BoxConstraints.expand(),
            child: Center(
              child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ReusableWeekCard(
                    icon: Icons.filter_none,
                    label: 'تقرير اليوم',
                    onTap: () async {
                      var connectivityResult =
                      await (Connectivity().checkConnectivity());
                      if ((connectivityResult == ConnectivityResult.mobile) ||
                          (connectivityResult == ConnectivityResult.wifi)) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TodayReport(),
                          ),
                        );
                      } else {
                        Scaffold.of(context).showSnackBar(new SnackBar(
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                          content: Text(
                            "! لا يوجد اتصال بالانترنت",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.end,
                          ),
                        ));
                      }
                    },
                  ),
                  //------------------------------------------------------
                  ReusableWeekCard(
                    icon: Icons.view_week,
                    label: 'تقرير الأسبوع',
                    onTap: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        var connectivityResult =
                        await (Connectivity().checkConnectivity());
                        if ((connectivityResult == ConnectivityResult.mobile) ||
                            (connectivityResult == ConnectivityResult.wifi)) {
                          final List<DateTime> picked =
                          await DateRagePicker.showDatePicker(
                              context: context,
                              initialFirstDate: (new DateTime.now())
                                  .subtract(new Duration(days: 5)),
                              initialLastDate: new DateTime.now(),
                              firstDate: new DateTime(2020),
                              lastDate: new DateTime(2021));
                          //------------------------------------------------------
                          List<Widget> dailyCard = [];
                          List<Widget> hostList = [];
                          //------------------------------------------------------
                          if (picked != null && picked.length == 2) {
                            String text = picked.toString();
                            //------------------------------------
                            if (text.substring(6, 7) == '0') {
                              monthFrom = text.substring(7, 8);
                            } else {
                              monthFrom = text.substring(6, 8);
                            }
                            //--------------------------------
                            if (text.substring(31, 32) == '0') {
                              monthTo = text.substring(32, 33);
                            } else {
                              monthTo = text.substring(31, 33);
                            }
                            //------------------------------------
                            year = text.substring(1, 5);
                            //------------------------------------
                            if (text.substring(9, 10) == '0') {
                              from = text.substring(10, 11);
                            } else {
                              from = text.substring(9, 11);
                            }
                            //------------------------------------------------------
                            String start = ',';
                            String end = ']';
                            final startIndex = text.indexOf(start);
                            final endIndex =
                            text.indexOf(end, startIndex + start.length);
                            if (text
                                .substring(
                                startIndex + start.length, endIndex)
                                .substring(9, 10) ==
                                '0') {
                              to = text
                                  .substring(
                                  startIndex + start.length, endIndex)
                                  .substring(10, 11);
                            } else {
                              to = text
                                  .substring(
                                  startIndex + start.length, endIndex)
                                  .substring(9, 11);
                            }
                            //--------------------------------------------------
                            if (monthFrom == monthTo) {
                              for (int i = int.parse(from);
                              i <= int.parse(to);
                              i++) {
                                DocumentSnapshot sum = await _fireStore
                                    .collection('sum')
                                    .document('$i-$monthFrom-$year')
                                    .get();
                                DocumentSnapshot sumHost = await _fireStore
                                    .collection('host')
                                    .document('$i-$monthFrom-$year')
                                    .get();
                                if (sum.exists) {
                                  eachSum = (sum.data['sum']).toDouble();
                                  var myCard = ReusableDailyCard(
                                    date: '$i-$monthFrom-$year',
                                    price: eachSum,
                                    host: false,
                                  );
                                  dailyCard.add(myCard);
                                  totalSum += (sum.data['sum']).toDouble();
                                } else {
                                  eachSum = 0.0;
                                  var myCard = (eachSum == 0.0)
                                      ? SizedBox()
                                      : ReusableDailyCard(
                                    date: '$i-$monthFrom-$year',
                                    price: eachSum,
                                    host: false,
                                  );
                                  dailyCard.add(myCard);
                                }
                                //-----------------------------------------------
                                if (sumHost.exists) {
                                  hostEachSum =
                                      (sumHost.data['sum']).toDouble();
                                  var myCard = ReusableDailyCard(
                                    date: '$i-$monthFrom-$year',
                                    price: hostEachSum,
                                    host: true,
                                  );
                                  hostList.add(myCard);
                                  hostTotalSum +=
                                      (sumHost.data['sum']).toDouble();
                                } else {
                                  hostEachSum = 0.0;
                                  var myCard = (hostEachSum == 0.0)
                                      ? SizedBox()
                                      : ReusableDailyCard(
                                    date: '$i-$monthFrom-$year',
                                    price: hostEachSum,
                                    host: true,
                                  );
                                  hostList.add(myCard);
                                }
                              }
                            } else {
                              for (int i = int.parse(from); i <= 31; i++) {
                                DocumentSnapshot sum = await _fireStore
                                    .collection('sum')
                                    .document('$i-$monthFrom-$year')
                                    .get();
                                DocumentSnapshot sumHost = await _fireStore
                                    .collection('host')
                                    .document('$i-$monthFrom-$year')
                                    .get();
                                if (sum.exists) {
                                  eachSum = (sum.data['sum']).toDouble();
                                  var myCard = ReusableDailyCard(
                                    date: '$i-$monthFrom-$year',
                                    price: eachSum,
                                    host: false,
                                  );
                                  dailyCard.add(myCard);
                                  totalSum += (sum.data['sum']).toDouble();
                                } else {
                                  eachSum = 0.0;
                                  var myCard = (eachSum == 0.0)
                                      ? SizedBox()
                                      : ReusableDailyCard(
                                    date: '$i-$monthFrom-$year',
                                    price: eachSum,
                                    host: false,
                                  );
                                  dailyCard.add(myCard);
                                }
                                //-----------------------------------------------
                                if (sumHost.exists) {
                                  hostEachSum =
                                      (sumHost.data['sum']).toDouble();
                                  var myCard = ReusableDailyCard(
                                    date: '$i-$monthFrom-$year',
                                    price: hostEachSum,
                                    host: true,
                                  );
                                  hostList.add(myCard);
                                  hostTotalSum +=
                                      (sumHost.data['sum']).toDouble();
                                } else {
                                  hostEachSum = 0.0;
                                  var myCard = (hostEachSum == 0.0)
                                      ? SizedBox()
                                      : ReusableDailyCard(
                                    date: '$i-$monthFrom-$year',
                                    price: hostEachSum,
                                    host: true,
                                  );
                                  hostList.add(myCard);
                                }
                              }
                              //----------------------------------
                              for (int j = 1; j <= int.parse(to); j++) {
                                DocumentSnapshot sum = await _fireStore
                                    .collection('sum')
                                    .document('$j-$monthTo-$year')
                                    .get();
                                DocumentSnapshot sumHost = await _fireStore
                                    .collection('host')
                                    .document('$j-$monthTo-$year')
                                    .get();
                                if (sum.exists) {
                                  eachSum = (sum.data['sum']).toDouble();
                                  var myCard = ReusableDailyCard(
                                    date: '$j-$monthTo-$year',
                                    price: eachSum,
                                    host: false,
                                  );
                                  dailyCard.add(myCard);
                                  totalSum += (sum.data['sum']).toDouble();
                                } else {
                                  eachSum = 0.0;
                                  var myCard = (eachSum == 0.0)
                                      ? SizedBox()
                                      : ReusableDailyCard(
                                    date: '$j-$monthTo-$year',
                                    price: eachSum,
                                    host: false,
                                  );
                                  dailyCard.add(myCard);
                                }
                                //-----------------------------------------------
                                if (sumHost.exists) {
                                  hostEachSum =
                                      (sumHost.data['sum']).toDouble();
                                  var myCard = ReusableDailyCard(
                                    date: '$j-$monthTo-$year',
                                    price: hostEachSum,
                                    host: true,
                                  );
                                  hostList.add(myCard);
                                  hostTotalSum +=
                                      (sumHost.data['sum']).toDouble();
                                } else {
                                  hostEachSum = 0.0;
                                  var myCard = (hostEachSum == 0.0)
                                      ? SizedBox()
                                      : ReusableDailyCard(
                                    date: '$j-$monthTo-$year',
                                    price: hostEachSum,
                                    host: true,
                                  );
                                  hostList.add(myCard);
                                }
                              }
                            }
                            //---------------------------------------------------------
                            var totalSumCard = TotalSumCard(
                                totalSum: totalSum, label: " : الاجمالي");
                            dailyCard.insert(0, totalSumCard);
                            totalSum = 0;
                            //----------------------------------------------------
                            var hostSumCard = TotalSumCard(
                                totalSum: hostTotalSum, label: " : الاجمالي");
                            hostList.insert(0, hostSumCard);
                            hostTotalSum = 0;
                            //------------------------------------------------------
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WeeklyReport(
                                  hostSum: hostTotalSum,
                                  hostList: hostList,
                                  sum: totalSum,
                                  myList: dailyCard,
                                ),
                              ),
                            );
                            setState(() {
                              showSpinner = false;
                            });
                          }
                          //------------------------------------------------------
                        } else {
                          setState(() {
                            showSpinner = false;
                          });
                          Scaffold.of(context).showSnackBar(new SnackBar(
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                            content: Text(
                              "! لا يوجد اتصال بالانترنت",
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.end,
                            ),
                          ));
                        }
                      } catch (e) {
                        setState(() {
                          showSpinner = false;
                        });
                        Scaffold.of(context).showSnackBar(new SnackBar(
                          backgroundColor: Colors.black,
                          duration: Duration(seconds: 2),
                          content: Text(
                            "! من فضلك ، اختر تاريخ صحيح",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.end,
                          ),
                        ));
                      }
                      setState(() {
                        showSpinner = false;
                      });
                      //-------------------------------------------------------
                    },
                  ),
                  //------------------------------------------------------
                  ReusableWeekCard(
                    icon: Icons.monetization_on,
                    label: 'تقرير المشتريات',
                    onTap: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        var connectivityResult =
                        await (Connectivity().checkConnectivity());

                        if ((connectivityResult == ConnectivityResult.mobile) ||
                            (connectivityResult == ConnectivityResult.wifi)) {
                          final List<DateTime> picked =
                          await DateRagePicker.showDatePicker(
                              context: context,
                              initialFirstDate: (new DateTime.now())
                                  .subtract(new Duration(days: 5)),
                              initialLastDate: new DateTime.now(),
                              firstDate: new DateTime(2020),
                              lastDate: new DateTime(2021));
                          //------------------------------------------------------
                          List<Widget> dailyBuyCard = [];
                          //------------------------------------------------------
                          if (picked != null && picked.length == 2) {
                            String text = picked.toString();
                            print(text);
                            if (text.substring(6, 7) == '0') {
                              monthFrom = text.substring(7, 8);
                            } else {
                              monthFrom = text.substring(6, 8);
                            }
                            //------------------------------------
                            if (text.substring(31, 32) == '0') {
                              monthTo = text.substring(32, 33);
                              print(monthTo);
                            } else {
                              monthTo = text.substring(31, 33);
                              print(monthTo);
                            }
                            //------------------------------------
                            year = text.substring(1, 5);
                            //------------------------------------
                            if (text.substring(9, 10) == '0') {
                              from = text.substring(10, 11);
                            } else {
                              from = text.substring(9, 11);
                            }
                            //------------------------------------------------------
                            String start = ',';
                            String end = ']';
                            final startIndex = text.indexOf(start);
                            final endIndex =
                            text.indexOf(end, startIndex + start.length);
                            if (text
                                .substring(
                                startIndex + start.length, endIndex)
                                .substring(9, 10) ==
                                '0') {
                              to = text
                                  .substring(
                                  startIndex + start.length, endIndex)
                                  .substring(10, 11);
                            } else {
                              to = text
                                  .substring(
                                  startIndex + start.length, endIndex)
                                  .substring(9, 11);
                            }

                            if (monthFrom == monthTo) {
                              for (int i = int.parse(from);
                              i <= int.parse(to);
                              i++) {
                                DocumentSnapshot sumBuy = await _fireStore
                                    .collection('buy')
                                    .document('$i-$monthFrom-$year')
                                    .get();

                                if (sumBuy.exists) {
                                  eachBuySum = (sumBuy.data['sum']).toDouble();

                                  var myCard = BuyDailyCard(
                                    date: '$i-$monthFrom-$year',
                                    price: eachBuySum,
                                  );

                                  dailyBuyCard.add(myCard);

                                  totalBuySum +=
                                      (sumBuy.data['sum']).toDouble();
                                } else {
                                  eachBuySum = 0.0;
                                  var myCard = (eachBuySum == 0.0)
                                      ? SizedBox()
                                      : BuyDailyCard(
                                    date: '$i-$monthFrom-$year',
                                    price: eachBuySum,
                                  );
                                  dailyBuyCard.add(myCard);
                                }
                              }
                            } else {
                              for (int i = int.parse(from); i <= 31; i++) {
                                DocumentSnapshot sumBuy = await _fireStore
                                    .collection('buy')
                                    .document('$i-$monthFrom-$year')
                                    .get();
                                if (sumBuy.exists) {
                                  eachBuySum = (sumBuy.data['sum']).toDouble();
                                  var myCard = BuyDailyCard(
                                    date: '$i-$monthFrom-$year',
                                    price: eachBuySum,
                                  );
                                  dailyBuyCard.add(myCard);
                                  totalBuySum +=
                                      (sumBuy.data['sum']).toDouble();
                                } else {
                                  eachBuySum = 0.0;
                                  var myCard = (eachBuySum == 0.0)
                                      ? SizedBox()
                                      : BuyDailyCard(
                                    date: '$i-$monthFrom-$year',
                                    price: eachBuySum,
                                  );
                                  dailyBuyCard.add(myCard);
                                }
                              }
                              //-------------------------------------------
                              for (int j = 1; j <= int.parse(to); j++) {
                                DocumentSnapshot sumBuy = await _fireStore
                                    .collection('buy')
                                    .document('$j-$monthTo-$year')
                                    .get();

                                if (sumBuy.exists) {
                                  eachBuySum = (sumBuy.data['sum']).toDouble();
                                  var myCard = BuyDailyCard(
                                    date: '$j-$monthTo-$year',
                                    price: eachBuySum,
                                  );
                                  dailyBuyCard.add(myCard);
                                  totalBuySum +=
                                      (sumBuy.data['sum']).toDouble();
                                } else {
                                  eachBuySum = 0.0;
                                  var myCard = (eachBuySum == 0.0)
                                      ? SizedBox()
                                      : BuyDailyCard(
                                    date: '$j-$monthTo-$year',
                                    price: eachBuySum,
                                  );
                                  dailyBuyCard.add(myCard);
                                }
                              }
                            }
                            //------------------------------------------------------
                            var totalSumCard = TotalSumCard(
                              totalSum: totalBuySum,
                              label: ' : المشتريات',
                            );
                            dailyBuyCard.insert(0, totalSumCard);
                            totalBuySum = 0;
                            //--------------------------------------------------
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WeeklyBuy(
                                  myList: dailyBuyCard,
                                ),
                              ),
                            );
                            setState(() {
                              showSpinner = false;
                            });
                          }
                          //------------------------------------------------------
                        } else {
                          setState(() {
                            showSpinner = false;
                          });
                          Scaffold.of(context).showSnackBar(new SnackBar(
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                            content: Text(
                              "! لا يوجد اتصال بالانترنت",
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.end,
                            ),
                          ));
                        }
                      } catch (e) {
                        setState(() {
                          showSpinner = false;
                        });
                        Scaffold.of(context).showSnackBar(new SnackBar(
                          backgroundColor: Colors.black,
                          duration: Duration(seconds: 2),
                          content: Text(
                            "! من فضلك ، اختر تاريخ صحيح",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.end,
                          ),
                        ));
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    },
                  ),
                  //------------------------------------------------------
                  ReusableWeekCard(
                    icon: Icons.add_box,
                    label: '  اضافة مشتريات',
                    onTap: () async {
                      var connectivityResult =
                      await (Connectivity().checkConnectivity());
                      if ((connectivityResult == ConnectivityResult.mobile) ||
                          (connectivityResult == ConnectivityResult.wifi)) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Buy(),
                          ),
                        );
                      } else {
                        Scaffold.of(context).showSnackBar(new SnackBar(
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                          content: Text(
                            "! لا يوجد اتصال بالانترنت",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.end,
                          ),
                        ));
                      }
                    },
                  ),
                  //-------------------------------------------------------
                  ReusableWeekCard(
                    icon: Icons.security,
                    label: 'الخزنة',
                    onTap: () async {
                      var connectivityResult =
                      await (Connectivity().checkConnectivity());
                      if ((connectivityResult == ConnectivityResult.mobile) ||
                          (connectivityResult == ConnectivityResult.wifi)) {
                        setState(() {
                          showSpinner = true;
                        });
                        DocumentSnapshot overallSum = await _fireStore
                            .collection('overallSum')
                            .document('totalSum')
                            .get();
                        double sell = (overallSum.data['totalSum']).toDouble();

                        DocumentSnapshot overallBuy = await _fireStore
                            .collection('overallBuy')
                            .document('totalBuy')
                            .get();
                        double buy = (overallBuy.data['totalBuy']).toDouble();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Safe(
                              sell: sell,
                              buy: buy,
                              rest: sell - buy,
                            ),
                          ),
                        );
                        setState(() {
                          showSpinner = false;
                        });
                      } else {
                        Scaffold.of(context).showSnackBar(new SnackBar(
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                          content: Text(
                            "! لا يوجد اتصال بالانترنت",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.end,
                          ),
                        ));
                      }
                    },
                  ),
                  //------------------------------------------------------
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
