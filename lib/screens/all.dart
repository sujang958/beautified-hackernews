// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/models/story.dart';
import 'package:news/widgets/itemWidget.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  late Stream<Story> topStoryStream;
  bool isFetchingMore = false;

  final _itemListController = ScrollController();
  final Map<int, Story> stories = {};

  @override
  void initState() {
    super.initState();
    _addStoryFromStream(16);
    _itemListController.addListener(_itemListInfinityScrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _itemListController.removeListener(_itemListInfinityScrollListener);
  }

  void _itemListInfinityScrollListener() {
    if (_itemListController.position.pixels >=
            _itemListController.position.maxScrollExtent - 82.0 &&
        !isFetchingMore) {
      setState(() {
        isFetchingMore = true;
      });
      topStoryStream = fetchTopStories(count: stories.entries.length + 10);
      topStoryStream.listen(
          (story) => setState(() {
                stories[story.id] = story;
              }), onDone: () {
        setState(() {
          isFetchingMore = false;
        });
      });
    }
  }

  void _addStoryFromStream(int? count) {
    topStoryStream = fetchTopStories(count: count);
    topStoryStream.listen((story) => setState(() {
          stories[story.id] = story;
        }));
  }

  void _updateStories() {
    setState(() {
      stories.clear();
    });
    _addStoryFromStream(16);
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
                              child: RawScrollbar(
                                  thumbColor: Colors.white30,
                                  radius: Radius.circular(12.0),
                                  interactive: true,
                                  thumbVisibility: true,
                                  thickness: 4.0,
                                  controller: _itemListController,
                                  child: ListView.builder(
                                    controller: _itemListController,
                                    physics: BouncingScrollPhysics(),
                                    padding: EdgeInsets.only(top: 12.0),
                                    itemBuilder: ((context, index) {
                                      if (index >= stories.length) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4,
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  8),
                                          child: CupertinoActivityIndicator(
                                              radius: 15.0),
                                        );
                                      }

                                      Story story = stories.entries
                                          .elementAt(index)
                                          .value;
                                      return Material(
                                          color: Colors.transparent,
                                          child: ItemWidget(story: story));
                                    }),
                                    itemCount: isFetchingMore
                                        ? stories.length + 1
                                        : stories.length,
                                  )),
                              onRefresh: () async {
                                _updateStories();
                              })),
                ],
              )),
        ));
  }
}
