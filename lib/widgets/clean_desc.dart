import 'package:flutter/material.dart';

class CleanDesc extends StatelessWidget {
  CleanDesc({this.desc,this.descPrice});
  final String desc;
  final double descPrice;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      child: Text(
        '$desc : $descPrice ',
        textAlign: TextAlign.end,
        style: TextStyle(
            fontSize: 18, color: Colors.teal, fontWeight: FontWeight.bold),
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent)
      ),
    );
  }
}
