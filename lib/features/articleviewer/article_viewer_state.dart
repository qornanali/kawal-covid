import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kawal_covid/features/articleviewer/article_viewer_page.dart';

class ArticleViewerState extends State<ArticleViewerPage> {
  final String pageTitle, articleTitle, articleContentFile;
  var _articleContent;

  ArticleViewerState({this.pageTitle, this.articleTitle, this.articleContentFile});

  @override
  void initState() {
    super.initState();
    _articleContent = _loadArticleContentFromFile();
  }

  Future<String> _loadArticleContentFromFile() async {
    if (articleContentFile.isEmpty) {
      return "";
    }

    return await rootBundle.loadString(articleContentFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: _buildArticlePanel(context),
    );
  }

  Widget _buildArticlePanel(BuildContext buildContext) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildArticleTitle(buildContext), _buildArticleContent(buildContext)],
      ),
    );
  }

  Widget _buildArticleTitle(BuildContext buildContext) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
      alignment: Alignment.center,
      child: Text(articleTitle, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildArticleContent(BuildContext buildContext) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 30.0),
      alignment: Alignment.topLeft,
      child: FutureBuilder<String>(
        future: _articleContent,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Text("Memuat artikel..");
        },
      ),
    );
  }
}
