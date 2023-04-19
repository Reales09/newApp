import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

import '../models/category_model.dart';

final _URL_NEWS = 'newsapi.org';
final _APIKEY = '26b9b3fc052446be8858113b55be5251';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadlines();
    categories.forEach((item) {
      this.categoryArticles[item.name] = new List.empty(growable: true);
    });
  }

  String get selectedCategory => this._selectedCategory;
  set selectedCategory(String valor) {
    this._selectedCategory = valor;
    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> get getArticulosCategoriaSeleccionada =>
      this.categoryArticles[this.selectedCategory]!;

  getTopHeadlines() async {
    var uri = Uri.https(
        _URL_NEWS, '/v2/top-headlines', {'country': 'us', 'apiKey': _APIKEY});
    final resp = await http.get(uri);

    final NewsResponse newsResponse = NewsResponse.fromRawJson(resp.body);

    this.headlines.addAll(newsResponse.articles);

    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (this.categoryArticles[category]!.length > 0) {
      return this.categoryArticles[category];
    }
    var uri = Uri.https(_URL_NEWS, '/v2/top-headlines',
        {'country': 'us', 'apiKey': _APIKEY, 'category': category});
    final resp = await http.get(uri);

    final NewsResponse newsResponse = NewsResponse.fromRawJson(resp.body);

    this.categoryArticles[category]?.addAll(newsResponse.articles);
    notifyListeners();
  }
}
