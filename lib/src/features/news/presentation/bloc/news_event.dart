part of 'news_bloc.dart';

@immutable
abstract class NewsEvent extends Equatable {
  List<Object> get props => [];
}

class GetNewsEvent extends NewsEvent {
  final String country;
  final String category;

  GetNewsEvent(this.country, this.category);

  @override
  List<Object> get props => [country, category];
}
