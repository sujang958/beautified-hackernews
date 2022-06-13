import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'abstract/item.dart';

const topStoriesUri = 'https://hacker-news.firebaseio.com/v0/topstories.json';
const storyUri = 'https://hacker-news.firebaseio.com/v0/item';
const asksUri = 'https://hacker-news.firebaseio.com/v0/askstories.json';

class Story extends Item {
  @override
  final String type = "story";
  final List<int> commentIds;
  final int score;
  final String title;
  final String url;
  final String content;

  const Story({
    required id,
    required by,
    required time,
    required this.commentIds,
    required this.score,
    required this.title,
    required this.url,
    required this.content,
  }) : super(id: id, by: by, time: time);

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      content: json['text'] ?? '',
      id: json['id'],
      by: json['by'],
      commentIds: json['kids'] == null ? [] : List.from(json['kids']),
      score: json['score'],
      time: json['time'],
      title: json['title'],
      url: json['url'] ?? '',
    );
  }
}

Stream<Story> fetchTopStories({int? count}) async* {
  final topStoryResponse = await http.get(Uri.parse(topStoriesUri));

  if (topStoryResponse.statusCode >= 400) {
    throw Exception("Can't fetch stories!");
  }

  final List<dynamic> topStoryIds = jsonDecode(topStoryResponse.body);

  final storyResponses = await Future.wait(
      topStoryIds.take(count ?? 20).map((id) => fetchStory(id: id)));

  for (final story in storyResponses.where((item) => item != null)) {
    yield story as Story;
  }
}

Future<Story?> fetchStory({required int id}) async {
  final storyResponse = await http.get(Uri.parse('$storyUri/$id.json'));

  if (storyResponse.statusCode >= 400) {
    throw Exception("Can't fetch stories!");
  }

  final json = jsonDecode(storyResponse.body);
  if (json['deleted'] != null && json['deleted'] == true) {
    return null;
  }

  return Story.fromJson(json);
}

Stream<Story> fetchAsks({int? count}) async* {
  final listResponse = await http.get(Uri.parse('$asksUri'));

  if (listResponse.statusCode >= 400) {
    throw Exception("Can't fetch ask stories1");
  }

  final listJson = jsonDecode(listResponse.body) as List<dynamic>;

  final responses = await Future.wait(
      listJson.take(count ?? 18).map((id) => fetchStory(id: id)));

  for (final story in responses
      .where((story) => story != null)) {
    yield story as Story;
  }
}
