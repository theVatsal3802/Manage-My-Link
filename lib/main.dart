import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:manage_my_link/firebase_options.dart';
import 'package:manage_my_link/screens/add_link_screen.dart';
import 'package:manage_my_link/screens/auth_screen.dart';
import 'package:manage_my_link/screens/home_screen.dart';
import 'package:manage_my_link/utils/theme.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My WorkSpace',
      theme: theme(),
      debugShowCheckedModeBanner: false,
      home: const AuthScreen(),
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        AddLinkScreen.routeName: (context) => const AddLinkScreen(),
        AuthScreen.routeName: (context) => const AuthScreen(),
      },
    );
  }
}
