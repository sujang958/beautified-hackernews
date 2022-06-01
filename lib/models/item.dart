import 'dart:async';
import 'dart:convert';

import 'package:news/models/comment.dart';
import 'package:http/http.dart' as http;

const topStoriesUri = 'https://hacker-news.firebaseio.com/v0/topstories.json';
const storyUri = 'https://hacker-news.firebaseio.com/v0/item';

abstract class Item {
  final int id;
  final String by;
  final int time;
  final String type = '';

  const Item({
    required this.id,
    required this.by,
    required this.time,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}

class Story extends Item {
  @override
  final String type = "story";
  final List<Comment> comments;
  final int score;
  final String title;
  final String url;

  const Story({
    required id,
    required by,
    required time,
    required this.comments,
    required this.score,
    required this.title,
    required this.url,
  }) : super(id: id, by: by, time: time);

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'],
      by: json['by'],
      comments: List.from(json['kids']).map((kid) => Comment(id: kid)).toList(),
      score: json['score'],
      time: json['time'],
      title: json['title'],
      url: json['url'],
    );
  }
}

class Job extends Item {
  @override
  final String type = "job";
  final String html;
  final int score;
  final String title;
  final String url;

  const Job({
    required id,
    required by,
    required time,
    required this.html,
    required this.score,
    required this.title,
    required this.url,
  }) : super(id: id, by: by, time: time);

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      by: json['by'],
      html: json['text'],
      score: json['score'],
      time: json['time'],
      title: json['title'],
      url: json['url'],
    );
  }
}

Future<List<Story>> fetchTopStories() async {
  final topStoryResponse = await http.get(Uri.parse(topStoriesUri));

  if (topStoryResponse.statusCode >= 400) {
    throw Exception("Can't fetch stories!");
  }

  final List<dynamic> topStoryIds = jsonDecode(topStoryResponse.body);
  final storyResponses = await Future.wait(
      topStoryIds.map((id) => http.get(Uri.parse('$storyUri/$id.json'))));
  
  return storyResponses
      .map((response) => jsonDecode(response.body))
      .where((item) => item.type == "story")
      .map((json) => Story.fromJson(json))
      .toList();
}
