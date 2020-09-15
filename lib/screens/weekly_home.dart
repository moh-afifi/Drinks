import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:dbdob/reusables/reusable_week_card.dart';
import 'package:dbdob/screens/today_report.dart';
import 'package:dbdob/reusables/reusable_daily_card.dart';
import 'package:dbdob/widgets/total_sum_card.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dbdob/screens/weekly_report.dart';

class Weekly extends StatefulWidget {
  @override
  _WeeklyState createState() => _WeeklyState();
}

class _WeeklyState extends State<Weekly> {
  final _fireStore = Firestore.instance;
  double totalSum = 0;
  double eachSum = 0;
  double hostTotalSum = 0;
  double hostEachSum = 0;
  String from;
  String to;
  bool showSpinner = false;

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
                  ReusableWeekCard(
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
                            print(to);

                            for (int i = int.parse(from);
                                i <= int.parse(to);
                                i++) {
                              DocumentSnapshot sum = await _fireStore
                                  .collection('sum')
                                  .document('$i-9-2020')
                                  .get();
                              if (sum.exists) {
                                eachSum = (sum.data['sum']).toDouble();
                                var myCard = ReusableDailyCard(
                                  date: '$i-9-2020',
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
                                        date: '$i-9-2020',
                                        price: eachSum,
                                        host: false,
                                      );
                                dailyCard.add(myCard);
                              }
                            }
                            //------------------------------------------------------
//                            for (int i = int.parse(from);
//                                i <= int.parse(to);
//                                i++) {
//                              DocumentSnapshot sum = await _fireStore
//                                  .collection('sum')
//                                  .document('$i-9-2020')
//                                  .get();
//                              if (sum.exists) {
//                                totalSum += (sum.data['sum']).toDouble();
//                              } else {
//                                totalSum = 0.0;
//                              }
//                            }
                            //---------------------------------------------------------
                            var totalSumCard = TotalSumCard(
                              totalSum: totalSum,
                            );
                            dailyCard.insert(0, totalSumCard);
                            totalSum = 0;
//                            print(totalSum);
                            //------------------------------------------------------
                            for (int i = int.parse(from);
                                i <= int.parse(to);
                                i++) {
                              DocumentSnapshot sum = await _fireStore
                                  .collection('host')
                                  .document('$i-9-2020')
                                  .get();
                              if (sum.exists) {
                                hostEachSum = (sum.data['sum']).toDouble();
                                var myCard = ReusableDailyCard(
                                  date: '$i-9-2020',
                                  price: hostEachSum,
                                  host: true,
                                );
                                hostList.add(myCard);
                                hostTotalSum += (sum.data['sum']).toDouble();
                              } else {
                                hostEachSum = 0.0;
                                var myCard = (hostEachSum == 0.0)
                                    ? SizedBox()
                                    : ReusableDailyCard(
                                        date: '$i-9-2020',
                                        price: hostEachSum,
                                        host: true,
                                      );
                                hostList.add(myCard);
                              }
                            }
//                            for (int i = int.parse(from);
//                                i <= int.parse(to);
//                                i++) {
//                              DocumentSnapshot sum = await _fireStore
//                                  .collection('host')
//                                  .document('$i-9-2020')
//                                  .get();
//                              if (sum.exists) {
//                                hostTotalSum += (sum.data['sum']).toDouble();
//                              } else {
//                                hostTotalSum = 0.0;
//                              }
//                            }
                            var hostSumCard = TotalSumCard(
                              totalSum: hostTotalSum,
                            );
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
                            duration: Duration(seconds: 3),
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
                          duration: Duration(seconds: 3),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
