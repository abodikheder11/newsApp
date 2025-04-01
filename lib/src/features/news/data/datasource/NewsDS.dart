import 'dart:convert';

import 'package:news_app/src/features/news/domain/models/news_model.dart';
import 'package:http/http.dart' as http;

abstract class NewsDataSource {
  Future<List<NewsModel>> getNews(String country, String category);
}

class NewsDataSourceImpl implements NewsDataSource {
  final String apiKey = "8a54b80e1161437ab3b74e9753162de2";

  @override
  Future<List<NewsModel>> getNews(String country, String category) async {
    try {
      final url = Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=$country&category=$category&apiKey=$apiKey");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['articles'] != null && jsonData['articles'] is List) {
          List<dynamic> articlesJson = jsonData['articles'];
          List<NewsModel> articles = articlesJson
              .map((articleJson) => NewsModel.fromJson(articleJson))
              .toList();
          return articles;
        } else {
          throw Exception("No Articles Found");
        }
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception("An Error Occurred : ${e.toString()}");
    }
  }
}
