import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dbdob/screens/weekly_emp.dart';
import 'package:dbdob/screens/weekly_host.dart';
import 'package:dbdob/reusables/reusable_week_card.dart';

class WeeklyReport extends StatefulWidget {
  WeeklyReport({this.sum, this.myList, this.hostSum, this.hostList});
  final double sum;
  final double hostSum;
  final List<Widget> hostList;
  final List<Widget> myList;
  @override
  _WeeklyReportState createState() => _WeeklyReportState();
}

class _WeeklyReportState extends State<WeeklyReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(
          'التقرير الاسبوعي',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ReusableWeekCard(
              label: 'الموظفين',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeeklyEmp(
                      sum: widget.sum,
                      myList: widget.myList,
                    ),
                  ),
                );
              },
            ),
            ReusableWeekCard(
              label: "الضيافة",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeeklyHost(
                      sum: widget.hostSum,
                      myList: widget.hostList,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
