import 'package:flutter/material.dart';

class TotalSumCard extends StatelessWidget {
  TotalSumCard({this.totalSum});
  final double totalSum;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      color: Colors.yellow,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              'جنيه  ',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              totalSum.toString(),
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '  : الإجمالي',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
