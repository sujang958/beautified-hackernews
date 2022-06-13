// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
  late Future<Story?> story;

  final replyListViewController = ScrollController();
  final commentPageViewController = PageController();
  final List<int> commentsHistory = <int>[];
  Future<Comment>? currentComment;

  @override
  void initState() {
    super.initState();
    story = fetchStory(id: widget.id);
    commentPageViewController.addListener(() {
      if (commentPageViewController.page == 0.0) {
        _backToCommentsList();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    commentPageViewController.dispose();
  }

  void _pushCommentHistory(int id) {
    setState(() {
      commentsHistory.add(id);
      if (commentsHistory.length > 1) {
        _animateToTop();
      }
      _setCurrentComment(id);
    });
  }

  void _popCommentHistory() {
    setState(() {
      commentsHistory.removeLast();
      if (commentsHistory.isEmpty) {
        _backToCommentsList();
        return;
      }
      _animateToTop();
      _setCurrentComment(commentsHistory.last);
    });
  }

  void _backToCommentsList() {
    _animateToPage(0);
    setState(() {
      currentComment = null;
      commentsHistory.clear();
    });
  }

  void _setCurrentComment(int id) {
    setState(() {
      currentComment = fetchComment(id: id);
    });
  }

  void _animateToPage(int page) {
    commentPageViewController.animateToPage(page,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void _animateToTop() {
    replyListViewController.animateTo(0,
        curve: Curves.easeIn, duration: Duration(milliseconds: 200));
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
            child: FutureBuilder<Story?>(
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  Story storyData = snapshot.data as Story;
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
                          physics: currentComment == null
                              ? NeverScrollableScrollPhysics()
                              : BouncingScrollPhysics(),
                          controller: commentPageViewController,
                          children: [
                            SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(children: [
                                storyData.content.isNotEmpty
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 24.0, top: 12.0),
                                        child: Column(
                                          children: [
                                            Html(
                                              data: storyData.content,
                                              onLinkTap:
                                                  (String? link, _, __, ___) {
                                                if (link != null) {
                                                  launchUrl(Uri.parse(link));
                                                }
                                              },
                                            ),
                                            Divider(color: Colors.grey[500]),
                                          ],
                                        ))
                                    : SizedBox.shrink(),
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
                                                child: Text(
                                                  "<  Reply",
                                                  style: TextStyle(
                                                      color: Colors.blue[600]),
                                                ),
                                                onPressed: () {
                                                  _popCommentHistory();
                                                }),
                                            Expanded(
                                                child: ListView(
                                              controller:
                                                  replyListViewController,
                                              children: [
                                                RawCommentWidget(
                                                  comment: comment,
                                                  onClickReply: () {},
                                                  replyButtonEnabled: false,
                                                ),
                                                Divider(
                                                  color: Colors.grey[100],
                                                  height: 12.0,
                                                ),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8.0)),
                                                for (final commentId
                                                    in comment.commentIds)
                                                  CommentWidget(
                                                      commentId: commentId,
                                                      onClickReply: () {
                                                        final copiedId =
                                                            commentId;
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
