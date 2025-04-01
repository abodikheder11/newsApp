import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/features/news/presentation/bloc/news_bloc.dart';
import 'package:news_app/src/features/news/presentation/pages/newsDetailedScreen.dart';
import 'package:news_app/src/features/news/presentation/widgets/newsTile.dart';

class NewsWidget extends StatefulWidget {
  final String category;

  const NewsWidget({super.key, required this.category});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  List<String> imgList = [];

  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(GetNewsEvent("us", widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
              if (state is NewsLoading) {
                return const CircularProgressIndicator();
              } else if (state is NewsLoaded) {
                imgList = state.news
                    .where((article) => article.urlToImage != null)
                    .map((article) => article.urlToImage!)
                    .toList();
                return carousel.CarouselSlider(
                  items: imgList.map((item) {
                    return GestureDetector(
                      onTap: () {
                        int index = imgList.indexOf(item);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => NewsDetailedScreen(
                              news: state.news[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            item,
                            fit: BoxFit.cover,
                            width: 1000,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  options: carousel.CarouselOptions(
                    height: 400.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 10,
                    viewportFraction: 0.8,
                  ),
                );
              } else if (state is NewsError) {
                return Text(state.errorMessage);
              } else {
                return Container();
              }
            }),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Latest News",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 22),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "See More",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<NewsBloc, NewsState>(
                    builder: (context, state) {
                      if (state is NewsLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is NewsLoaded) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.news.length,
                          itemBuilder: (context, index) {
                            final article = state.news[index];
                            return NewsTile(news: article);
                          },
                        );
                      } else if (state is NewsError) {
                        return Text(
                          state.errorMessage,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 18),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
