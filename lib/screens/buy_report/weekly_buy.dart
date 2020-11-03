import 'package:flutter/material.dart';

class WeeklyBuy extends StatelessWidget {
  WeeklyBuy({this.myList});
  final List<Widget> myList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(
          'تقرير المشتريات',
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
