import 'package:flutter/material.dart';
import 'package:dbdob/screens/today_report/daily_report.dart';
import 'package:dbdob/screens/host_report/host_daily_report.dart';
class ReusableDailyCard extends StatelessWidget {
  ReusableDailyCard({this.date,this.price,this.host});
  final String date;
  final double price;
  final bool host;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        (host == false)?Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DailyReport(date: date,),
          ),
        ):Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HostDailyReport(date: date,),
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
