// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/screens/all.dart';
import 'package:news/screens/setting.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Beautified Hacker News",
      theme: ThemeData(fontFamily: "Pretendard"),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CupertinoTabController tabController = CupertinoTabController();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: tabController,
      backgroundColor: Colors.black,
      tabBar: CupertinoTabBar(
          iconSize: 21.0,
          backgroundColor: Colors.grey[900]?.withAlpha(180),
          items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.news), label: "All"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.question_circle), label: "Ask"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.square_list), label: "Show"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings), label: "Setting")
          ]),
      tabBuilder: (BuildContext context, int index) => CupertinoTabView(
          builder: (context) => DefaultTextStyle(
              style: TextStyle(color: Colors.white, fontFamily: "Pretendard"),
              child: index == 3 ? SettingScreen() : AllScreen())),
    );
  }
}
