import 'dart:convert';

import 'package:news/models/abstract/item.dart';
import 'package:http/http.dart' as http;

const commentUri = 'https://hacker-news.firebaseio.com/v0/item';

class Comment extends Item {
  @override
  final String type = "comment";
  final List<int> commentIds;
  final int parentId; // this will be story or comment
  final String comment;

  const Comment({
    required id,
    required by,
    required time,
    required this.commentIds,
    required this.parentId,
    required this.comment,
  }) : super(id: id, by: by, time: time);

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: json['id'],
        by: json['by'],
        time: json['time'],
        commentIds: json['kids'] ?? [],
        parentId: json['parent'],
        comment: json['text']);
  }
}

Future<Comment> fetchComment(int id) async {
  final commentResponse = await http.get(Uri.parse('$commentUri/$id.json'));

  if (commentResponse.statusCode >= 400) {
    throw Exception("Can't fetch the comment!");
  }

  return Comment.fromJson(jsonDecode(commentResponse.body));
}
