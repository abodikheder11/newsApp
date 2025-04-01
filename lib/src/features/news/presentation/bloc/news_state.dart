part of 'news_bloc.dart';

@immutable
abstract class NewsState extends Equatable {
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsModel> news;

  NewsLoaded(this.news);

  List<Object> get props => [news];
}

class NewsError extends NewsState {
  final String errorMessage;

  NewsError(this.errorMessage);

  List<Object> get props => [errorMessage];
}
