import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../reusables/reusable_report_card.dart';
import 'package:dbdob/widgets/total_sum_card.dart';

class DailyReport extends StatefulWidget {
  DailyReport({this.date});
  final String date;
  @override
  _DailyReportState createState() => _DailyReportState();
}

class _DailyReportState extends State<DailyReport> {
  final _fireStore = Firestore.instance;
  String type;
  int quantity, price;
  double totalSum = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(
          widget.date,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
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
              nescafeMilkSum = nescafeMilkList.reduce((a, b) => a + b);
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
//----------------------------------------------------------------------------
          final sumCard = TotalSumCard(
            totalSum: totalSum,
              label:"الاجمالي"
          );

          final teaCard = (teaSum == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: true,
                  type: 'شاى',
                  quantity: teaSum,
                  intPrice: (teaSum * 3),
                );
          final nescafeCard = (nescafeSum == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: true,
                  type: ' 3x1 نسكافيه',
                  quantity: nescafeSum,
                  intPrice: (nescafeSum * 4),
                );
          final coffeeCard = (coffeeSum == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: true,
                  type: 'قهوة',
                  quantity: coffeeSum,
                  intPrice: (coffeeSum * 5),
                );
          final blackCard = (blackSum == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: true,
                  type: 'نسكافيه بلاك',
                  quantity: blackSum,
                  intPrice: (blackSum * 3),
                );
          final mixCard = (mixSum == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: true,
                  type: 'coffee mix',
                  quantity: mixSum,
                  intPrice: (mixSum * 4),
                );
          final bonjCard = (bonjSum == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: true,
                  type: 'بونجورنو',
                  quantity: bonjSum,
                  intPrice: (bonjSum * 6),
                );
          final yansCard = (yanSum == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: false,
                  type: 'ينسون',
                  quantity: yanSum,
                  doublePrice: yanSum * 3.5,
                );
          final karkCard = (karkSum == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: false,
                  type: 'كركديه',
                  quantity: karkSum,
                  doublePrice: karkSum * 3.5,
                );
          final mintCard = (mintSum == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: false,
                  type: 'نعناع',
                  quantity: mintSum,
                  doublePrice: mintSum * 3.5,
                );
          final waterCard = (waterSum == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: true,
                  type: 'مياه',
                  quantity: waterSum,
                  intPrice: (waterSum * 3),
                );
          final teaMilkCard = (teaMilkSum == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: true,
                  type: 'شاى بلبن',
                  quantity: teaMilkSum,
                  intPrice: (teaMilkSum * 5),
                );
          final nescafeMilkCard = (nescafeMilkSum == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: true,
                  type: 'نسكافيه بلبن',
                  quantity: nescafeMilkSum,
                  intPrice: (nescafeMilkSum * 5),
                );
          final talkemaCard = (talkemaSum == 0)
              ? SizedBox()
              : ReportCard(
            isInt: true,
            type: 'تلقيمة',
            quantity: talkemaSum,
            intPrice: (talkemaSum * 5),
          );
          final milkyCard = (milkySum == 0)
              ? SizedBox()
              : ReportCard(
            isInt: true,
            type: '3x1 لبن',
            quantity: milkySum,
            intPrice: (milkySum * 5),
          );
          final juiceCard = (juiceSum == 0)
              ? SizedBox()
              : ReportCard(
            isInt: true,
            type: 'عصير',
            quantity: juiceSum,
            intPrice: (juiceSum * 5),
          );
//-------------------------------------------------------------------------
          return (totalSum == 0)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.yellow,
                        child: Icon(
                          Icons.warning,
                          color: Colors.white,
                          size: 100,
                        ),
                      ),
                      Text(
                        'لا توجد مبيعات لهذا اليوم',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              : ListView(
                  padding: EdgeInsets.all(15),
                  children: <Widget>[
                    sumCard,
                    teaCard,
                    nescafeCard,
                    coffeeCard,
                    blackCard,
                    mixCard,
                    teaMilkCard,
                    nescafeMilkCard,
                    bonjCard,
                    karkCard,
                    yansCard,
                    mintCard,
                    waterCard,
                    talkemaCard,
                    milkyCard,
                    juiceCard
                  ],
                );
        },
      ),
    );
  }
}
