import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:news_app/src/features/authentication/presentation/pages/profile_screen.dart';
import 'package:news_app/src/features/authentication/presentation/pages/signup_screen.dart';
import 'package:news_app/src/features/news/presentation/pages/searchScreen.dart';

import '../../../authentication/presentation/bloc/auth_bloc.dart';
import 'grandNewsScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _pages = [
    const GrandNewsScreen(),
    const SearchScreen(),
    // NewsDetailedScreen(),
    const Center(
      child: Text("Search", style: TextStyle(fontSize: 24)),
    ),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF001F3F),
        selectedItemColor: const Color(0xff001F3F),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 26,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 28), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive, size: 28), label: "Saved"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 28), label: "Profile"),
        ],
      ),
    );
  }
}
