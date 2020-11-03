import 'package:flutter/material.dart';

class CleanReportCard extends StatelessWidget {
  CleanReportCard(
      {this.type, this.price,this.descList});
  final String type;
  final double price;
final List descList;

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                type,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(color: Colors.black),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                ' المبلغ : $price جنيه ',
                style: TextStyle(fontSize: 20, color: Colors.purple),
              ),
            ),
            Column(
              children: descList,
            )
          ],
        ),
      ),
    );
  }
}
