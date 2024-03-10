import 'package:flutter/material.dart';
import 'package:linger/controller/bottom_navigation_bar_controller.dart';
import 'package:linger/controller/hotel_controller.dart';
import 'package:linger/view/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=> HotelController()),
    ChangeNotifierProvider(create: (context)=> BottomNavigationBarController())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
