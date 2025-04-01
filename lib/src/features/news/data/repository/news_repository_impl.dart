import 'package:dartz/dartz.dart';
import 'package:news_app/src/core/error/exceptions.dart';
import 'package:news_app/src/core/error/failures.dart';
import 'package:news_app/src/features/news/data/datasource/NewsDS.dart';
import 'package:news_app/src/features/news/domain/models/news_model.dart';
import 'package:news_app/src/features/news/domain/repository/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsDataSource remoteDS;

  NewsRepositoryImpl({required this.remoteDS});

  @override
  Future<Either<Failure, List<NewsModel>>> getNews(
      String country, String category) async {
    try {
      final news = await remoteDS.getNews(country, category);
      return Right(news);
    } on ServerExceptions {
      return Left(ServerFailure());
    }
  }
}
