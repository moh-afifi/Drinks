import 'package:flutter/material.dart';

class WeeklyHost extends StatelessWidget {
  WeeklyHost({this.sum,this.myList});
  final double sum;
  final List<Widget> myList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(
          'تقرير الضيافة',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: myList,
      ),
    );
  }
}
