import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:news/models/comment.dart';
import 'package:url_launcher/url_launcher.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({Key? key, required this.commentId}) : super(key: key);

  final int commentId;

  @override
  State<StatefulWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  late Future<Comment> comment;

  @override
  void initState() {
    super.initState();
    comment = fetchComment(id: widget.commentId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: FutureBuilder<Comment>(
          future: comment,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Comment? commentData = snapshot.data;
              if (commentData != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${commentData.by} at ${DateTime.fromMillisecondsSinceEpoch(commentData.time * 1000).toString().replaceAll('.000', '')}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15.6),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Html(
                        data: commentData.comment,
                        style: {'*': Style(color: Colors.white)},
                        onLinkTap: (String? link, _, __, ___) {
                          if (link != null) {
                            launchUrl(Uri.parse(link));
                          }
                        },
                      ),
                    ),
                    CupertinoButton(
                        onPressed: () {},
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: const Text(
                          "View reply",
                          style: TextStyle(fontSize: 15.4),
                        )),
                  ],
                );
              }
            }

            if (snapshot.hasError) {
              return const SizedBox.shrink();
            }

            return const CupertinoActivityIndicator(
              radius: 15.0,
            );
          },
        ));
  }
}
