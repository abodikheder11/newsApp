import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/features/news/presentation/widgets/allSearchNewsTile.dart';
import '../bloc/news_bloc.dart';
import 'package:news_app/src/features/news/domain/models/news_model.dart';

class AllSearchNews extends StatefulWidget {
  final List<NewsModel> filteredNews;

  const AllSearchNews({super.key, required this.filteredNews});

  @override
  State<AllSearchNews> createState() => _AllSearchNewsState();
}

class _AllSearchNewsState extends State<AllSearchNews> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state is NewsLoading) {
                return CircularProgressIndicator();
              } else if (state is NewsLoaded) {
                final newsList = widget.filteredNews.isNotEmpty
                    ? widget.filteredNews
                    : state.news;
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    final article = newsList[index];
                    return AllSearchNewsTile(news: article);
                  },
                );
              } else if (state is NewsError) {
                return Text(state.errorMessage);
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }
}
