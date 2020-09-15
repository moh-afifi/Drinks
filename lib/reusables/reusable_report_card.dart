import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  ReportCard(
      {this.type, this.quantity, this.intPrice, this.isInt, this.doublePrice});
  final String type;
  final int quantity;
  final int intPrice;
  final double doublePrice;
  final bool isInt;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.all(7.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              type,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
            Divider(color: Colors.black),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  (isInt)
                      ? Text(
                          'المبلغ : $intPrice جنيه ',
                          style: TextStyle(fontSize: 20, color: Colors.purple),
                        )
                      : Text(
                          'المبلغ : $doublePrice جنيه ',
                          style: TextStyle(fontSize: 20, color: Colors.purple),
                        ),
                  Container(
                    width: 1,
                    height: 50,
                    color: Colors.grey,
                  ),
                  Text(
                    'الكمية : $quantity',
                    style: TextStyle(fontSize: 20, color: Colors.purple),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
