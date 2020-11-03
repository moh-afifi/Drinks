import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dbdob/screens/week_report/weekly_emp.dart';
import 'package:dbdob/screens/host_report/weekly_host.dart';
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/back1.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.9), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ReusableWeekCard(
                icon: Icons.person_pin,
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
                icon: Icons.room_service,
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
      ),
    );
  }
}
