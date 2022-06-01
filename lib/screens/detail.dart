// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/models/story.dart';
import 'package:news/widgets/commentWidget.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<StatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<Story> story;
  // todo: implementing fetching comments

  @override
  void initState() {
    super.initState();
    story = fetchStory(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            backgroundColor: Colors.black, transitionBetweenRoutes: true),
        backgroundColor: Colors.black,
        child: SafeArea(
            child: DefaultTextStyle(
          style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
              fontFamily: "Pretendard"),
          softWrap: true,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 22.0),
            child: FutureBuilder<Story>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Story? storyData = snapshot.data;
                  if (storyData != null) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            storyData.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                            ),
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
                          Text(
                            "by ${storyData.by}  |  ${storyData.score} points  |  ${storyData.commentIds.length} comments",
                            style: TextStyle(
                                fontSize: 14.4, fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 22.0),
                            child: Visibility(
                              visible: storyData.url.isEmpty ? false : true,
                              child: CupertinoButton(
                                  onPressed: () {},
                                  color: Colors.grey[900],
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2.5, horizontal: 22.0),
                                  child: Text(
                                    "Visit the website",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400),
                                  )),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(children: [
                                for (final commentId in storyData.commentIds)
                                  CommentWidget(commentId: commentId)
                              ]),
                            ),
                          ),
                        ]);
                  }
                }

                return Center(
                  child: CupertinoActivityIndicator(radius: 16.0),
                );
              },
              future: story,
            ),
          ),
        )));
  }
}
