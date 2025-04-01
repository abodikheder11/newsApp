import 'package:dartz/dartz.dart';
import 'package:news_app/src/core/error/failures.dart';
import 'package:news_app/src/features/news/domain/models/news_model.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<NewsModel>>> getNews(
      String country, String category);
}
