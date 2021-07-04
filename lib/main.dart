import 'package:flutter/material.dart';
import 'package:kawal_covid/features/summary/summary_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kawal Covid',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SummaryPage(title: 'Kawal CVD'),
    );
  }
}
