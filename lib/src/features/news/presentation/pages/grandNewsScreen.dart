import 'package:flutter/material.dart';
import 'allGrandNewsWidget.dart';

class GrandNewsScreen extends StatelessWidget {
  const GrandNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          elevation: 0,
          title: const Center(
            child: Text(
              "Grand News",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.list,
              size: 28,
              color: Color(0xff001F3F),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                size: 28,
                color: Color(0xff001F3F),
              ),
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: "All"),
              Tab(text: "entertainment"),
              Tab(text: "Sport"),
              Tab(text: "Health"),
              Tab(text: "Tech"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
                child: NewsWidget(
              category: "general",
            )),
            Center(
              child: NewsWidget(
                category: "entertainment",
              ),
            ),
            Center(
              child: NewsWidget(
                category: "sports",
              ),
            ),
            Center(
              child: NewsWidget(
                category: "health",
              ),
            ),
            Center(
              child: NewsWidget(
                category: "technology",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
