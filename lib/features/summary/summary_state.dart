import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kawal_covid/api/kawal_covid/kawal_covid_client.dart';
import 'package:kawal_covid/api/kawal_covid/kawal_covid_client_impl.dart';
import 'package:kawal_covid/api/kawal_covid/model/covid_summary.dart';
import 'package:kawal_covid/core/entity/api_response.dart';
import 'package:kawal_covid/features/summary/summary_page.dart';

class SummaryState extends State<SummaryPage> {
  int _counter = 0;
  KawalCovidClient kawalCovidClient = KawalCovidClientImpl(http.Client());
  Future<ApiResponse<CovidSummary>> _covidSummary;

  @override
  void initState() {
    super.initState();
    _covidSummary = kawalCovidClient.getIndonesiaSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Data Example'),
      ),
      body: Center(
        child: FutureBuilder<ApiResponse<CovidSummary>>(
          future: _covidSummary,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.data.positiveCount.toString());
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
