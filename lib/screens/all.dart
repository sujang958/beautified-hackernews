// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllPage extends StatefulWidget {
  const AllPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.black,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 72.0, bottom: 12.0),
                child: Text(
                  "Hacker News",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.grey[900],
                  onRefresh: () async {},
                  child: ListView.builder(
                      itemBuilder: ((context, index) => GestureDetector(
                          child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Varo, First Chartered Neobank, Could Run Out of Money by End of Year",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.0),
                                  ),
                                  Padding(padding: EdgeInsets.symmetric(vertical: 2.5), child: Text("by mooreds  |  +1 points  |  0 comments"),),
                                ],
                              )))),
                      itemCount: 80),
                ),
              ),
            ],
          )),
    );
  }
}