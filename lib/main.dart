// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: "Beautified Hacker News",
      theme: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
              textStyle:
                  TextStyle(fontFamily: "Pretendard", color: Colors.white))),
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
          iconSize: 22.0,
          backgroundColor: Colors.grey[900]?.withAlpha(180),
          items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.news), label: "All"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.question_circle), label: "Ask"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.square_list), label: "Show")
          ]),
      tabBuilder: (BuildContext context, int index) => CupertinoTabView(
        builder: (context) => CupertinoPageScaffold(
          backgroundColor: Colors.black,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 72.0, bottom: 12.0),
                    child: Text(
                      "Hacker News $index",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 32.0),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
