import 'package:flutter/material.dart';
import 'package:dbdob/screens/buy_report/buy_daily_report.dart';
class BuyDailyCard extends StatelessWidget {
  BuyDailyCard({this.date,this.price});
  final String date;
  final double price;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BuyDailyReport(date: date,),
          ),
        );
      },
      child: Card(
        elevation: 10.0,
        margin: EdgeInsets.all(15),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                date,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              Divider(color: Colors.black,indent: 200.0,),
              Text(
                'الاجمالي : $price جنيه ',
                style: TextStyle(fontSize: 23, color: Colors.purple),
              )
            ],
          ),
        ),
      ),
    );
  }
}
