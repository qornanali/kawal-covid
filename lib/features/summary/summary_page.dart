import 'package:flutter/material.dart';
import 'package:kawal_covid/features/summary/summary_state.dart';

class SummaryPage extends StatefulWidget {
  SummaryPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => SummaryState();
}
