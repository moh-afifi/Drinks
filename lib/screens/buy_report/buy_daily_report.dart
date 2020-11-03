import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../reusables/reusable_report_card.dart';
import 'package:dbdob/reusables/total_sum_card.dart';
import 'package:dbdob/reusables/clean_report_card.dart';
import 'package:dbdob/widgets/clean_desc.dart';

class BuyDailyReport extends StatefulWidget {
  BuyDailyReport({this.date});
  final String date;
  @override
  _BuyDailyReportState createState() => _BuyDailyReportState();
}

class _BuyDailyReportState extends State<BuyDailyReport> {
  final _fireStore = Firestore.instance;
  String type;
  int quantity;
  double totalSum = 0;
  double cleanPrice = 0;
  double descPrice = 0;
  String desc;
  List<Widget> descList = [];
  //-------------------------------------------------------
  void cleanStream() async {
    await for (var snapshot
        in _fireStore.collection('${widget.date} clean').snapshots()) {
      for (var message in snapshot.documents) {
        cleanPrice += message.data['price'];
        desc = message.data['desc'];
        descPrice = message.data['price'];
        var descCard = (desc == null)
            ? SizedBox()
            : CleanDesc(
                desc: desc,
                descPrice: descPrice,
              );
        descList.add(descCard);
      }
    }
  }

  //-----------------------------------------------------
  @override
  void initState() {
    cleanStream();
    super.initState();
  }

  //-----------------------------------------------------
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
        stream: _fireStore.collection('${widget.date} buy').snapshots(),
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

          double teaPrice = 0,
              nescafePrice = 0,
              coffeePrice = 0,
              blackPrice = 0,
              mixPrice = 0,
              bonjPrice = 0,
              waterPrice = 0,
              karkPrice = 0,
              yanPrice = 0,
              mintPrice = 0,
              talkemaPrice = 0,
              milkyPrice = 0,
              juicePrice = 0,
              powderPrice = 0,
              goldPrice = 0,
              sugarPrice = 0,
              cupSmallPrice = 0,
              cupLargePrice = 0;
          //----------------------------------------------
          int teaSum = 0,
              nescafeSum = 0,
              coffeeSum = 0,
              blackSum = 0,
              mixSum = 0,
              bonjSum = 0,
              waterSum = 0,
              powderSum = 0,
              karkSum = 0,
              yanSum = 0,
              mintSum = 0,
              talkemaSum = 0,
              milkySum = 0,
              juiceSum = 0,
              goldSum = 0,
              sugarSum = 0,
              cupSmallSum = 0,
              cupLargeSum = 0;
          //----------------------------------------------
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
          List<int> talkemaList = [];
          List<int> milkyList = [];
          List<int> juiceList = [];
          List<int> powderList = [];
          List<int> goldList = [];
          List<int> sugarList = [];
          List<int> cupSmallList = [];
          List<int> cupLargeList = [];
          //------------------------------------------------
          for (var item in items) {
            type = item.data['type'];
            quantity = item.data['quantity'];

            if (type == 'شاى') {
              teaPrice += item.data['price'];
              teaList.add(quantity);
              teaSum = teaList.reduce((a, b) => a + b);
            } else if (type == 'نسكافيه') {
              nescafePrice += item.data['price'];
              nescafeList.add(quantity);
              nescafeSum = nescafeList.reduce((a, b) => a + b);
            } else if (type == 'نسكافيه بلاك') {
              blackPrice += item.data['price'];
              blackList.add(quantity);
              blackSum = blackList.reduce((a, b) => a + b);
            } else if (type == 'بونجورنو') {
              bonjPrice += item.data['price'];
              bonjList.add(quantity);
              bonjSum = bonjList.reduce((a, b) => a + b);
            } else if (type == 'كوفي ميكس') {
              mixPrice += item.data['price'];
              mixList.add(quantity);
              mixSum = mixList.reduce((a, b) => a + b);
            } else if (type == 'ينسون') {
              yanPrice += item.data['price'];
              yanList.add(quantity);
              yanSum = yanList.reduce((a, b) => a + b);
            } else if (type == 'كركديه') {
              karkPrice += item.data['price'];
              karkList.add(quantity);
              karkSum = karkList.reduce((a, b) => a + b);
            } else if (type == 'نعناع') {
              mintPrice += item.data['price'];
              mintList.add(quantity);
              mintSum = mintList.reduce((a, b) => a + b);
            } else if (type == 'مياه') {
              waterPrice += item.data['price'];
              waterList.add(quantity);
              waterSum = waterList.reduce((a, b) => a + b);
            } else if (type == 'قهوة') {
              coffeePrice += item.data['price'];
              coffeeList.add(quantity);
              coffeeSum = coffeeList.reduce((a, b) => a + b);
            } else if (type == 'تلقيمة') {
              talkemaPrice += item.data['price'];
              talkemaList.add(quantity);
              talkemaSum = talkemaList.reduce((a, b) => a + b);
            } else if (type == '3x1 لبن') {
              milkyPrice += item.data['price'];
              milkyList.add(quantity);
              milkySum = milkyList.reduce((a, b) => a + b);
            } else if (type == 'عصير') {
              juicePrice += item.data['price'];
              juiceList.add(quantity);
              juiceSum = juiceList.reduce((a, b) => a + b);
            } else if (type == 'لبن بودرة') {
              powderPrice += item.data['price'];
              powderList.add(quantity);
              powderSum = powderList.reduce((a, b) => a + b);
            } else if (type == 'نسكافيه جولد') {
              goldPrice += item.data['price'];
              goldList.add(quantity);
              goldSum = goldList.reduce((a, b) => a + b);
            } else if (type == 'سكر') {
              sugarPrice += item.data['price'];
              sugarList.add(quantity);
              sugarSum = sugarList.reduce((a, b) => a + b);
            } else if (type == 'كوب صغير') {
              cupSmallPrice += item.data['price'];
              cupSmallList.add(quantity);
              cupSmallSum = cupSmallList.reduce((a, b) => a + b);
            } else if (type == 'كوب كبير') {
              cupLargePrice += item.data['price'];
              cupLargeList.add(quantity);
              cupLargeSum = cupLargeList.reduce((a, b) => a + b);
            }
          }
          totalSum = teaPrice +
              nescafePrice +
              coffeePrice +
              blackPrice +
              mixPrice +
              bonjPrice +
              waterPrice +
              karkPrice +
              yanPrice +
              mintPrice +
              talkemaPrice +
              milkyPrice +
              goldPrice +
              sugarPrice +
              cupSmallPrice +
              cupLargePrice +
              juicePrice +
              powderPrice +
              cleanPrice;
//----------------------------------------------------------------------------
          final sumCard =
              TotalSumCard(totalSum: totalSum, label: " : الاجمالي");

          final teaCard = (teaPrice == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: false,
                  type: 'شاى',
                  quantity: teaSum,
                  doublePrice: teaPrice,
                );
          final nescafeCard = (nescafePrice == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: false,
                  type: ' 3x1 نسكافيه',
                  quantity: nescafeSum,
                  doublePrice: nescafePrice,
                );
          final coffeeCard = (coffeePrice == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: false,
                  type: 'قهوة',
                  quantity: coffeeSum,
                  doublePrice: coffeePrice,
                );
          final blackCard = (blackPrice == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: false,
                  type: 'نسكافيه بلاك',
                  quantity: blackSum,
                  doublePrice: blackPrice,
                );
          final mixCard = (mixPrice == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: false,
                  type: 'coffee mix',
                  quantity: mixSum,
                  doublePrice: mixPrice,
                );
          final bonjCard = (bonjPrice == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: false,
                  type: 'بونجورنو',
                  quantity: bonjSum,
                  doublePrice: bonjPrice,
                );
          final yansCard = (yanPrice == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: false,
                  type: 'ينسون',
                  quantity: yanSum,
                  doublePrice: yanPrice,
                );
          final karkCard = (karkPrice == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: false,
                  type: 'كركديه',
                  quantity: karkSum,
                  doublePrice: karkPrice,
                );
          final mintCard = (mintPrice == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: false,
                  type: 'نعناع',
                  quantity: mintSum,
                  doublePrice: mixPrice,
                );
          final waterCard = (waterPrice == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: false,
                  type: 'مياه',
                  quantity: waterSum,
                  doublePrice: waterPrice,
                );
          final talkemaCard = (talkemaPrice == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: false,
                  type: 'تلقيمة',
                  quantity: talkemaSum,
                  doublePrice: talkemaPrice,
                );
          final milkyCard = (milkyPrice == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: false,
                  type: '3x1 لبن',
                  quantity: milkySum,
                  doublePrice: milkyPrice,
                );
          final juiceCard = (juicePrice == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: false,
                  type: 'عصير',
                  quantity: juiceSum,
                  doublePrice: juicePrice,
                );
          final powderCard = (powderPrice == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: false,
                  type: 'لبن بودرة',
                  quantity: powderSum,
                  doublePrice: powderPrice,
                );
//---------------------------------------------------------------
          final goldCard = (goldPrice == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: false,
                  type: 'نسكافيه جولد',
                  quantity: goldSum,
                  doublePrice: goldPrice,
                );
          final sugarCard = (sugarPrice == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: false,
                  type: 'سكر',
                  quantity: sugarSum,
                  doublePrice: sugarPrice,
                );
          final cupSmallCard = (cupSmallPrice == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: false,
                  type: 'دستة كوب صغير',
                  quantity: cupSmallSum,
                  doublePrice: cupSmallPrice,
                );
          final cupLargeCard = (cupLargePrice == 0)
              ? SizedBox()
              : ReportCard(
                  isInt: false,
                  type: 'دستة كوب كبير',
                  quantity: cupLargeSum,
                  doublePrice: cupLargePrice,
                );

          final cleanCard = (cleanPrice == 0)
              ? SizedBox()
              : CleanReportCard(
                  type: 'مصاريف إدارية',
                  price: cleanPrice,
                  descList: descList,
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
                        'لا توجد مشتريات',
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
                    bonjCard,
                    karkCard,
                    yansCard,
                    mintCard,
                    waterCard,
                    talkemaCard,
                    milkyCard,
                    juiceCard,
                    powderCard,
                    goldCard,
                    sugarCard,
                    cupSmallCard,
                    cupLargeCard,
                    cleanCard
                  ],
                );
        },
      ),
    );
  }
}
