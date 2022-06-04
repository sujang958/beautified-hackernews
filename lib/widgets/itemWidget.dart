import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/models/story.dart';
import 'package:news/screens/detail.dart';

class ItemWidget extends StatefulWidget {
  const ItemWidget({Key? key, required this.story}) : super(key: key);

  final Story story;

  @override
  State<StatefulWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    Story story = widget.story;
    return ListTile(
        contentPadding: EdgeInsets.zero,
        enableFeedback: false,
        tileColor: Colors.transparent,
        onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => DetailScreen(id: story.id),
            )),
        title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  story.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontFamily: "Pretendard"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.5),
                  child: Text(
                    "by ${story.by}  |  ${story.score} points  |  ${story.commentIds.length} comments",
                    style: const TextStyle(
                        fontFamily: "Pretendard",
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontSize: 14.2,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            )));
  }
}
