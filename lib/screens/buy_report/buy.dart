import 'package:flutter/material.dart';
import 'package:dbdob/reusables/reusable_drink_card.dart';
import 'package:dbdob/widgets/make_buy_dialog.dart';
import 'package:dbdob/widgets/make_clean_dialog.dart';

class Buy extends StatefulWidget {
  @override
  _BuyState createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  //--------------------------------------------------------------
  void makeOrder(String type) {
    showDialog(
        context: context,
        builder: (BuildContext context) => MakeBuyDialog(
              type: type,
            ));
  }

  void makeCleanOrder(String type) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CleanMakeDialog(
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
            'المشتريات',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
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
                    imagePath: 'images/tea-box.jpg',
                    label: 'شـاى 1/4',
                    onTap: () {
                      makeOrder('شاى');
                    },
                  ),
                  ReusableCard(
                    imagePath: 'images/coffee-box.jpg',
                    label: 'كيلو قهوة',
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
                    imagePath: 'images/black2.jpg',
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
                    imagePath: 'images/water-box.jpg',
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
                  ReusableCard(
                    imagePath: 'images/milk.jpg',
                    label: '1/2 لبن بودرة',
                    onTap: () {
                      makeOrder("لبن بودرة");
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ReusableCard(
                    imagePath: 'images/sugar.jpeg',
                    label: 'سكر',
                    onTap: () {
                      makeOrder("سكر");
                    },
                  ),
                  ReusableCard(
                    imagePath: 'images/gold2.jpg',
                    label: 'نسكافيه جولد',
                    onTap: () {
                      makeOrder("نسكافيه جولد");
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ReusableCard(
                    imagePath: 'images/cup-tea.jpg',
                    label: 'دستة كبير',
                    onTap: () {
                      makeOrder("كوب كبير");
                    },
                  ),
                  ReusableCard(
                    imagePath: 'images/cup-coffee.jpg',
                    label: 'دستة صغير',
                    onTap: () {
                      makeOrder("كوب صغير");
                    },
                  ),
                ],
              ),
              //----------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ReusableCard(
                    imagePath: 'images/clean.jpg',
                    label: 'مصروفات إدارية',
                    onTap: () {
                      makeCleanOrder("ادوات نظافة");
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
