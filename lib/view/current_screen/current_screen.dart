import 'package:flutter/material.dart';
import 'package:linger/controller/bottom_navigation_bar_controller.dart';
import 'package:linger/view/bottom_navigation_screens/explore_screen/explore_screen.dart';
import 'package:linger/view/bottom_navigation_screens/profile_screen/profile_screen.dart';
import 'package:provider/provider.dart';

import '../bottom_navigation_screens/home_screen/home_screen.dart';

class CurrentScreen extends StatelessWidget {
  const CurrentScreen({super.key, this.data});

  final data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomNavigationBarController>(builder: (context, controller, _) {
        return IndexedStack(
          index: controller.currentIndex,
          children: [HomeScreen(data: data),ExploreScreen(),ProfileScreen()],
        );
      }),
      bottomNavigationBar: Consumer<BottomNavigationBarController>(builder: (context, controller, _) {
        return BottomNavigationBar(
            currentIndex: controller.currentIndex,
            selectedItemColor: Colors.purple,
            unselectedItemColor: Colors.purple.shade200,
            onTap: (index) {
              Provider.of<BottomNavigationBarController>(context, listen: false).currentIndex = index;
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explore"),
            ]);
      }),
    );
  }
}
