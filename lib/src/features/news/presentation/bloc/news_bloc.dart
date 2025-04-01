import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:news_app/src/features/news/domain/models/news_model.dart';
import 'package:news_app/src/features/news/domain/repository/news_repository.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository;

  NewsBloc(this.repository) : super(NewsInitial()) {
    on<GetNewsEvent>(getNews);
  }

  Future<void> getNews(GetNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    final result = await repository.getNews(event.country, event.category);
    result.fold(
      (failure) => emit(
        NewsError("Failed to fetch Data"),
      ),
      (news) => emit(
        NewsLoaded(news),
      ),
    );
  }
}
