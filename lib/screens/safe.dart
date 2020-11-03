import 'package:flutter/material.dart';

class Safe extends StatelessWidget {
  Safe({this.buy, this.rest, this.sell});
  final double sell, buy, rest;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(
          'الخزنة',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 350,
              height: 100,
              child: Card(
                color: Colors.teal,
                elevation: 10.0,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'اجمالي المبيعات : $sell',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
            Container(
              width: 350,
              height: 100,
              child: Card(
                color: Colors.red,
                elevation: 10.0,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'اجمالي المشتريات : $buy',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
            Container(
              width: 350,
              height: 100,
              child: Card(
                color: Colors.yellow[800],
                elevation: 10.0,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'المتبقي : $rest',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
