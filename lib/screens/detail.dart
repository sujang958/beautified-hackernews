// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/models/comment.dart';
import 'package:news/models/story.dart';
import 'package:news/widgets/commentWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<StatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<Story> story;

  final commentPageViewController = PageController();
  final List<int> commentsHistory = <int>[];
  Future<Comment>? currentComment;

  @override
  void initState() {
    super.initState();
    story = fetchStory(id: widget.id);
  }

  void _pushCommentHistory(int id) {
    setState(() {
      commentsHistory.add(id);
      _setCurrentComment(id);
    });
  }

  void _popCommentHistory() {
    setState(() {
      commentsHistory.removeLast();
      if (commentsHistory.isEmpty) {
        currentComment = null;
        commentsHistory.clear();
        _animateToPage(0);
        return;
      }
      _setCurrentComment(commentsHistory.last);
    });
  }

  void _setCurrentComment(int id) {
    setState(() {
      currentComment = fetchComment(id: id);
    });
  }

  void _animateToPage(int page) {
    commentPageViewController.animateToPage(page,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
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
                            child: CupertinoButton(
                                onPressed: () {
                                  launchUrl(Uri.parse(storyData.url.isEmpty
                                      ? 'https://news.ycombinator.com/item?id=${storyData.id}'
                                      : storyData.url));
                                },
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
                          Expanded(
                              child: PageView(
                            controller: commentPageViewController,
                            children: [
                              SingleChildScrollView(
                                child: Column(children: [
                                  for (final commentId in storyData.commentIds)
                                    CommentWidget(
                                      commentId: commentId,
                                      onClickReply: () {
                                        final int copiedId = commentId;
                                        _pushCommentHistory(copiedId);
                                        _animateToPage(1);
                                      },
                                    )
                                ]),
                              ),
                              currentComment != null
                                  ? FutureBuilder<Comment>(
                                      future: currentComment,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          Comment comment =
                                              snapshot.data as Comment;

                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CupertinoButton(
                                                  child: Icon(
                                                    CupertinoIcons.back,
                                                    color: Colors.blue[600],
                                                  ),
                                                  onPressed: () {
                                                    _popCommentHistory();
                                                  }),
                                              Expanded(
                                                  child: ListView(
                                                children: [
                                                  RawCommentWidget(
                                                    comment: comment,
                                                    onClickReply: () {},
                                                    replyButtonEnabled: false,
                                                  ),
                                                  Divider(
                                                    color: Colors.grey[600],
                                                  ),
                                                  for (final commentId
                                                      in comment.commentIds)
                                                    CommentWidget(
                                                        commentId: commentId,
                                                        onClickReply: () {
                                                          final copiedId = int
                                                              .parse(commentId
                                                                  .toString());
                                                          _pushCommentHistory(
                                                              copiedId);
                                                        })
                                                ],
                                              )),
                                            ],
                                          );
                                        }

                                        return CupertinoActivityIndicator(
                                          radius: 13.0,
                                        );
                                      },
                                    )
                                  : Center(
                                      child: Text("Are you try to get this?"),
                                    ),
                            ],
                          ))
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
