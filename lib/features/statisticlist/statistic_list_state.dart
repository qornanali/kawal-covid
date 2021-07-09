import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kawal_covid/api/kawal_covid/kawal_corona_client.dart';
import 'package:kawal_covid/api/kawal_covid/kawal_corona_client_impl.dart';
import 'package:kawal_covid/api/kawal_covid/model/covid_province_summary.dart';
import 'package:kawal_covid/core/entity/api_response.dart';
import 'package:kawal_covid/features/statisticlist/statistic_list_page.dart';

class StatisticListState extends State<StatisticListPage> {
  KawalCovidClient kawalCovidClient = KawalCovidClientImpl(http.Client());
  Future<ApiResponse<List<CovidProvinceSummary>>> _covidProvinceSummaries;

  @override
  void initState() {
    super.initState();
    _covidProvinceSummaries = kawalCovidClient.getProvinceSummaries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistik Provinsi Indonesia'),
      ),
      body: _buildProviceSummariesPanel(),
    );
  }

  Widget _buildProviceSummariesPanel() {
    return FutureBuilder<ApiResponse<List<CovidProvinceSummary>>>(
        future: _covidProvinceSummaries,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data.data;
            return _buildListSummaries(data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        });
  }

  Widget _buildListSummaries(List<CovidProvinceSummary> summaries) {
    return ListView.builder(
        itemCount: summaries.length,
        itemBuilder: (context, index) {
          return Container(
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${summaries[index].provinceName}', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Jumlah positif: ${summaries[index].positiveCount}"),
                  Text("Jumlah sembuh: ${summaries[index].recoveredCount}"),
                  Text("Jumlah meninggal: ${summaries[index].deathCount}"),
                ],
              ),
            ),
          );
        });
  }
}
