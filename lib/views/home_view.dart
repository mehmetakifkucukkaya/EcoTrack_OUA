import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:eco_track/views/home_page.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 1;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  static const List<Widget> pages = <Widget>[
    Icon(Icons.insert_chart, size: 150),
    HomePage(),
    Icon(Icons.person, size: 150),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: pages.elementAt(selectedIndex)),
      bottomNavigationBar: ConvexAppBar(
        height: 60,
        backgroundColor: Colors.green,
        style: TabStyle.titled,
        items: const <TabItem>[
          TabItem(icon: Icons.insert_chart, title: 'İstatistiklerim'),
          TabItem(icon: Icons.home, title: 'Ana Sayfa'),
          TabItem(icon: Icons.person, title: 'Profil'),
        ],
        initialActiveIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
