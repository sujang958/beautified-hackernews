import 'dart:convert';

import 'package:news/models/comment.dart';
import 'package:http/http.dart' as http;

final TopStoriesUri = 'https://hacker-news.firebaseio.com/v0/topstories.json';

class Story {
  final String by;
  final List<Comment> comments;
  final int score;
  final String title;
  final int time;
  final String url;

  const Story({
    required this.by,
    required this.comments,
    required this.score,
    required this.time,
    required this.title,
    required this.url,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    // ignore: prefer_const_constructors
    return Story(
        by: json['by'],
        comments: json['kids'].map((id) => Comment(id: id)),
        score: json['score'],
        time: json['time'],
        title: json['title'],
        url: json['url']);
  }
}

Future<Story> fetchAlbum() async {
  final response = await http.get(Uri.parse(TopStoriesUri));
  final json = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return Story.fromJson(json);
  } else {
    throw Exception('Failed to load stories');
  }
}
