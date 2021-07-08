import 'package:flutter/material.dart';
import 'package:kawal_covid/features/statisticlist/statistic_list_page.dart';
import 'package:kawal_covid/features/summary/summary_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kawal Covid19',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SummaryPage(),
    );
  }
}
