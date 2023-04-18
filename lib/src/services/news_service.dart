import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = 'newsapi.org';
final _APIKEY = '26b9b3fc052446be8858113b55be5251';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  NewsService() {
    this.getTopHeadlines();
  }

  getTopHeadlines() async {
    var uri = Uri.https(
        _URL_NEWS, '/v2/top-headlines', {'country': 'co', 'apiKey': _APIKEY});
    final resp = await http.get(uri);

    final NewsResponse newsResponse = NewsResponse.fromRawJson(resp.body);

    this.headlines.addAll(newsResponse.articles);

    notifyListeners();
  }
}
