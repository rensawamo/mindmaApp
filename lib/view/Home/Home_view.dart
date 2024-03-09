import 'package:flutter/material.dart';
import 'package:mindmapapp/view/Home/phylogenetic/Phylogenetic_view.dart';

import '../../Navbar.dart';
import 'User/User.dart';


class Home extends StatefulWidget {
  @override
  State<Home> createState() => _MyAppState();
}

class _MyAppState extends State<Home> {
  int currentIndex = 0;
  final pages = [PhylogeneticTreeView(), UserView()];

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[200],
        primaryColor: Colors.greenAccent,
      ),
      home: Scaffold(
        drawer: Navbar(),
        appBar: AppBar(
          title: Text('Teste'),
          backgroundColor: Colors.greenAccent,
        ),
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            unselectedItemColor: Colors.greenAccent.shade700,
            selectedItemColor: Colors.white,
            backgroundColor: Colors.greenAccent,
            items: [

              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search', // Correct property is 'label', not 'itle'
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