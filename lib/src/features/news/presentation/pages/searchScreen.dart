import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/features/news/presentation/pages/allSearchNews.dart';
import 'package:news_app/src/features/news/domain/models/news_model.dart';
import '../bloc/news_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<NewsModel> filteredNews = [];
  TextEditingController searchController = TextEditingController();

  void searchNews(String query) {
    final bloc = BlocProvider.of<NewsBloc>(context);
    if (bloc.state is NewsLoaded) {
      final allNews = (bloc.state as NewsLoaded).news;
      setState(() {
        filteredNews = allNews.where((news) {
          final title = news.title?.toLowerCase() ?? "";
          final description = news.description?.toLowerCase() ?? "";
          final input = query.toLowerCase();
          return description.contains(input) || title.contains(input);
        }).toList();
      });
    }
  }

  // void searchNews(String query) {
  //   final bloc = BlocProvider.of<NewsBloc>(context);
  //   if (bloc.state is NewsLoaded) {
  //     final allNews = (bloc.state as NewsLoaded).news;
  //     setState(() {
  //       filteredNews = allNews.where((news) {
  //         final title = news.title?.toLowerCase() ?? "";
  //         final description = news.description?.toLowerCase() ?? "";
  //         final input = query.toLowerCase();
  //         return title.contains(input) || description.contains(input);
  //       }).toList();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: searchController,
                onChanged: searchNews,
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.search),
                  suffixIconColor: Colors.grey,
                  fillColor: Colors.grey[200],
                  filled: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  hintText: "Search news...",
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            TabBar(
              indicator: BoxDecoration(
                color: const Color(0xff001F3F),
                borderRadius: BorderRadius.circular(35),
              ),
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.white,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
              tabs: const [
                Tab(text: "All"),
                Tab(text: "News"),
                Tab(text: "Photos"),
                Tab(text: "Videos"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AllSearchNews(filteredNews: filteredNews),
                  Center(
                      child:
                          Text("News Content", style: TextStyle(fontSize: 20))),
                  Center(
                      child: Text("Photos Content",
                          style: TextStyle(fontSize: 20))),
                  Center(
                      child: Text("Videos Content",
                          style: TextStyle(fontSize: 20))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
