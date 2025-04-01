import 'package:flutter/material.dart';
import 'package:news_app/src/features/news/domain/models/news_model.dart';

class NewsDetailedScreen extends StatefulWidget {
  final NewsModel news;

  const NewsDetailedScreen({super.key, required this.news});

  @override
  State<NewsDetailedScreen> createState() => _NewsDetailedScreenState();
}

class _NewsDetailedScreenState extends State<NewsDetailedScreen> {
  bool isSaved = false;

  void toggleSave() {
    setState(() {
      isSaved = !isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.news.source?.name ?? 'News Details'),
        backgroundColor: const Color(0xff001F3F),
        actions: [
          IconButton(
              onPressed: toggleSave,
              icon: isSaved
                  ? const Icon(Icons.bookmark)
                  : const Icon(Icons.bookmark_outline))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(20)),
                child: Image.network(
                  widget.news.urlToImage ?? "https://via.placeholder.com/400",
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.news.title ?? "No Title",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "By ${widget.news.author ?? 'Unknown Author'}",
                      style: const TextStyle(
                        color: Color(0xff001F3F),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _formatDate(widget.news.publishedAt),
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.news.description ?? "No Description Available",
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.news.content ?? "No Content Available",
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String? date) {
    if (date == null) return "No Date";
    try {
      final parsedDate = DateTime.parse(date);
      return "${parsedDate.year}/${parsedDate.month}/${parsedDate.day} ${parsedDate.hour}:${parsedDate.minute}";
    } catch (e) {
      return "Invalid Date";
    }
  }
}
