// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/models/story.dart';
import 'package:news/widgets/itemWidget.dart';

class AllPage extends StatefulWidget {
  const AllPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {
  late Stream<Story> topStoryStream;

  final List<Story> stories = [];

  @override
  void initState() {
    super.initState();
    _addStoryFromStream();
  }

  void _addStoryFromStream() {
    topStoryStream = fetchTopStories();
    topStoryStream.listen((story) => setState(() {
          stories.add(story);
        }));
  }

  void _updateStories() {
    setState(() {
      stories.removeRange(0, stories.length);
    });
    _addStoryFromStream();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Colors.black,
        child: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: 62.0, bottom: 12.0),
                    child: Text(
                      "Hacker News",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32.0,
                      ),
                    ),
                  ),
                  Expanded(
                      child: stories.isEmpty
                          ? CupertinoActivityIndicator(
                              radius: 17.0,
                            )
                          : RefreshIndicator(
                              color: Colors.white,
                              backgroundColor: Colors.grey[900],
                              child: ListView.builder(
                                padding: EdgeInsets.only(top: 12.0),
                                itemBuilder: ((context, index) {
                                  Story story = stories.elementAt(index);
                                  return ItemWidget(story: story);
                                }),
                                itemCount: stories.length,
                              ),
                              onRefresh: () async {
                                _updateStories();
                              })),
                ],
              )),
        ));
  }
}
