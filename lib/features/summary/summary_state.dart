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
        title: Text('Kawal COVID19'),
      ),
      body: Center(
        child: FutureBuilder<ApiResponse<CovidSummary>>(
          future: _covidSummary,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data.data;
              return Align(
                  child: Column(
                    children: [
                      Text("Jumlah positif: ${data.positiveCount}", textAlign: TextAlign.left),
                      Text("Jumlah sembuh: ${data.recoveredCount}", textAlign: TextAlign.left),
                      Text("Jumlah meninggal: ${data.deathCount}", textAlign: TextAlign.left),
                      Text("Jumlah yang sudah dirawat: ${data.treatedCount}", textAlign: TextAlign.left),
                    ],
                  ));
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
