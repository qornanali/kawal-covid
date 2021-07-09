import 'package:flutter/cupertino.dart';
import 'package:kawal_covid/features/articleviewer/article_viewer_state.dart';

class ArticleViewerPage extends StatefulWidget {
  final String pageTitle, articleTitle, articleContentFile;

  ArticleViewerPage({this.pageTitle, this.articleTitle, this.articleContentFile});

  @override
  State<StatefulWidget> createState() =>
      ArticleViewerState(pageTitle: pageTitle, articleTitle: articleTitle, articleContentFile: articleContentFile);
}
