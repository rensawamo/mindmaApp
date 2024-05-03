import 'package:flutter/material.dart';
import 'package:mindmapapp/view/Home/titlelist/title_list_view.dart';
import 'package:mindmapapp/view/Home/user/user_page.dart';
import 'package:mindmapapp/core/design/app_colors.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _MyAppState();
}

class _MyAppState extends State<HomeView> {
  int currentIndex = 0;
  // App Tracking Transparency

  Future<void> initPlugin() async {
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await Future.delayed(const Duration(milliseconds: 200));
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  final List<StatefulWidget> pages = <StatefulWidget>[
    const TitleListView(),
    const UserPage()
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initPlugin());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appbarColor,
          centerTitle: true,
          title: Text(currentIndex == 0 ? "マインドマップ" : "ユーザーページ"),
        ),
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            unselectedItemColor: Colors.white,
            selectedItemColor: AppColors.primaryColor,
            backgroundColor: AppColors.appbarColor,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.account_tree),
                label: 'Mind Map',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded),
                label: 'User',
              ),
            ],
            onTap: (int index) => <void>{
                  setState(() {
                    currentIndex = index;
                  })
                }),
      ),
    );
  }
}
