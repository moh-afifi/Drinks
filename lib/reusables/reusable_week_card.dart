import 'package:flutter/material.dart';


class ReusableWeekCard extends StatelessWidget {
  ReusableWeekCard({this.label,this.onTap});
  final String label;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        height: 100.0,
        width: 300,
        //margin: const EdgeInsets.only(bottom: 6.0), //Same as `blurRadius` i guess
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.purple,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
      ),
    );
  }
}