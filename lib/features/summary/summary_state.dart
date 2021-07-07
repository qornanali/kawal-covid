import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kawal_covid/api/kawal_covid/kawal_corona_client.dart';
import 'package:kawal_covid/api/kawal_covid/kawal_corona_client_impl.dart';
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
        body: SingleChildScrollView(
          child: Column(
            children: [buildSummaryPanel(context)],
          ),
        ));
  }

  Widget buildSummaryPanel(BuildContext buildContext) {
    return Container(
        padding: const EdgeInsets.only(top: 20.0, bottom: 10.0, left: 10.0, right: 10.0),
        child: Column(
          children: [buildImageVirus(buildContext), buildIndonesiaStatisticPanel(buildContext)],
        ));
  }

  Widget buildIndonesiaStatisticPanel(BuildContext buildContext) {
    return Center(
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
    );
  }

  Widget buildImageVirus(BuildContext buildContext) {
    return Image(image: AssetImage('assets/images/virus.png'));
  }
}
