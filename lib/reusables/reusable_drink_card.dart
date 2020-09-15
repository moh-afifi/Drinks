import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({this.imagePath, this.label, this.onTap});
  final String imagePath;
  final String label;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Image.asset(
                imagePath,
                height: 100,
                width: 120,
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        elevation: 5.0,
        margin: EdgeInsets.all(10.0),
      ),
      onTap: onTap,
    );
  }
}
