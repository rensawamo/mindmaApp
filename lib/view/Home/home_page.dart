import 'package:flutter/material.dart';
import 'package:mindmapapp/view/Home/titlelist/title_list_view.dart';
import 'package:mindmapapp/view/Home/user/user_page.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _MyAppState();
}

class _MyAppState extends State<HomeView> {
  int currentIndex = 0;
  final pages = [TitleListView(), UserPage()];

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[200],
        primaryColor: Colors.greenAccent,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(currentIndex == 0 ? "マインドマップ" : "ユーザーページ"),
        ),
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            unselectedItemColor: Colors.greenAccent.shade700,
            selectedItemColor: Colors.white,
            backgroundColor: Colors.greenAccent,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.account_tree),
                label: 'Mind Map', // Correct property is 'label', not 'itle'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded),
                label: 'User', // Use 'label' instead of 'title'
              ),
            ],
            onTap: (index) => {
              setState(() {
                currentIndex = index;
              })
            }),
      ),
    );
  }
}