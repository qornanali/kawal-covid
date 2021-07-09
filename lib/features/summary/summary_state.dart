import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kawal_covid/api/kawal_covid/kawal_corona_client.dart';
import 'package:kawal_covid/api/kawal_covid/kawal_corona_client_impl.dart';
import 'package:kawal_covid/api/kawal_covid/model/covid_summary.dart';
import 'package:kawal_covid/core/entity/api_response.dart';
import 'package:kawal_covid/features/articleviewer/article_viewer_page.dart';
import 'package:kawal_covid/features/statisticlist/statistic_list_page.dart';
import 'package:kawal_covid/features/summary/summary_page.dart';

class SummaryState extends State<SummaryPage> {
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
          title: Text('Kawal COVID-19'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [_buildSummaryPanel(context)],
          ),
        ));
  }

  Widget _buildSummaryPanel(BuildContext buildContext) {
    return Container(
        padding: const EdgeInsets.only(top: 20.0, bottom: 10.0, left: 10.0, right: 10.0),
        child: Column(
          children: [
            _buildImageVirus(buildContext),
            _buildIndonesiaSummaryPanel(buildContext),
            _buildButton('Statistik provinsi di Indonesia', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StatisticListPage()),
              );
            }),
            _buildButton("Gejala-gejala yang timbul", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArticleViewerPage(
                      pageTitle: "Gejala COVID-19",
                      articleTitle: "Kenali Gejala Orang Terinfeksi Virus Corona di Minggu Pertama",
                      articleContentFile: "assets/texts/articles-gejala-covid.txt",
                    )),
              );
            }),
            _buildButton("Protokol Pencegahan COVID-19", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArticleViewerPage(
                          pageTitle: "Protokol 5M",
                          articleTitle: "Mengenal Protokol Kesehatan 5M untuk Cegah COVID-19",
                          articleContentFile: "assets/texts/articles-5-m.txt",
                        )),
              );
            }),
            _buildButton("Panduan isolasi mandiri", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArticleViewerPage(
                      pageTitle: "Panduan isolasi mandiri",
                      articleTitle: "Cara Isolasi Mandiri yang Benar",
                      articleContentFile: "assets/texts/articles-isolasi-mandiri.txt",
                    )),
              );
            }),
            _buildButton("Daftar nomor hotline", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArticleViewerPage(
                      pageTitle: "Daftar nomor hotline",
                      articleTitle: "Daftar Nomor Hotline COVID-19 di Jakarta, Jogja,Jateng hingga Papua",
                      articleContentFile: "assets/texts/articles-hotline.txt",
                    )),
              );
            }),
            _buildButton("Proses vaksinisasi", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArticleViewerPage(
                      pageTitle: "Proses vaksinisasi",
                      articleTitle: "Vaksinisasi COVID-19",
                      articleContentFile: "assets/texts/articles-vaksin.txt",
                    )),
              );
            }),
            _buildButton("Sejarah pandemi COVID-19", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArticleViewerPage(
                      pageTitle: "Sejarah pandemi COVID-19",
                      articleTitle: "Pandemi COVID-19",
                      articleContentFile: "assets/texts/articles-sejarah-covid.txt",
                    )),
              );
            }),
            _buildButton("Tentang pembuat aplikasi", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArticleViewerPage(
                      pageTitle: "Tentang pembuat aplikasi",
                      articleTitle: "",
                      articleContentFile: "assets/texts/articles-about.txt",
                    )),
              );
            })
          ],
        ));
  }

  Widget _buildIndonesiaSummaryPanel(BuildContext buildContext) {
    return FutureBuilder<ApiResponse<CovidSummary>>(
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
    );
  }

  Widget _buildImageVirus(BuildContext buildContext) {
    return Image(image: AssetImage('assets/images/virus.png'));
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      child: Text(text),
      onPressed: onPressed,
    );
  }
}
