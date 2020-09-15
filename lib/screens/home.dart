import 'package:flutter/material.dart';
import 'package:dbdob/reusables/reusable_drink_card.dart';
import 'package:dbdob/widgets/make_order_dialog.dart';
import 'today_report.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //--------------------------------------------------------------
  void makeOrder(String type) {
    showDialog(
        context: context,
        builder: (BuildContext context) => MakeOrderDialog(
              type: type,
            ));
  }
//----------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: Text(
            'المـشـروبـات',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.receipt,
              size: 50,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodayReport(),
                ),
              );
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ReusableCard(
                    imagePath: 'images/tea2.jpg',
                    label: 'شــــــاى',
                    onTap: () {
                      makeOrder('شاى');
                    },
                  ),
                  ReusableCard(
                    imagePath: 'images/coffee4.jpg',
                    label: 'قهوة',
                    onTap: () {
                      makeOrder("قهوة");
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ReusableCard(
                    imagePath: 'images/nescafee.webp',
                    label: '3x1 نسكافيه',
                    onTap: () {
                      makeOrder("نسكافيه");
                    },
                  ),
                  ReusableCard(
                    imagePath: 'images/black.jpg',
                    label: 'نسكافيه بلاك',
                    onTap: () {
                      makeOrder("نسكافيه بلاك");
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ReusableCard(
                    imagePath: 'images/bonjo.jpg',
                    label: 'بونجورنو',
                    onTap: () {
                      makeOrder("بونجورنو");
                    },
                  ),
                  ReusableCard(
                    imagePath: 'images/mix.jpg',
                    label: 'كوفي ميكس',
                    onTap: () {
                      makeOrder("كوفي ميكس");
                    },
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ReusableCard(
                    imagePath: 'images/talkema.jpg',
                    label: 'تلقيمة',
                    onTap: () {
                      makeOrder("تلقيمة");
                    },
                  ),
                  ReusableCard(
                    imagePath: 'images/nesMilk.jpg',
                    label: '3x1 لبن',
                    onTap: () {
                      makeOrder("3x1 لبن");
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ReusableCard(
                    imagePath: 'images/tea-milk.jpg',
                    label: 'شاى بلبن',
                    onTap: () {
                      makeOrder("شاى بلبن");
                    },
                  ),
                  ReusableCard(
                    imagePath: 'images/nescafe-milk.jpg',
                    label: 'نسكافيه بلبن',
                    onTap: () {
                      makeOrder("نسكافيه بلبن");
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ReusableCard(
                    imagePath: 'images/yans.jpg',
                    label: 'ينسون',
                    onTap: () {
                      makeOrder("ينسون");
                    },
                  ),
                  ReusableCard(
                    imagePath: 'images/kark.jpg',
                    label: 'كركديه',
                    onTap: () {
                      makeOrder("كركديه");
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ReusableCard(
                    imagePath: 'images/mint.jpg',
                    label: 'نعناع',
                    onTap: () {
                      makeOrder("نعناع");
                    },
                  ),
                  ReusableCard(
                    imagePath: 'images/water2.jpg',
                    label: 'مياه',
                    onTap: () {
                      makeOrder("مياه");
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ReusableCard(
                    imagePath: 'images/juice.jpg',
                    label: 'عصير',
                    onTap: () {
                      makeOrder("عصير");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
