import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'abstract/item.dart';

const topStoriesUri = 'https://hacker-news.firebaseio.com/v0/topstories.json';
const storyUri = 'https://hacker-news.firebaseio.com/v0/item';

class Story extends Item {
  @override
  final String type = "story";
  final List<int> commentIds;
  final int score;
  final String title;
  final String url;

  const Story({
    required id,
    required by,
    required time,
    required this.commentIds,
    required this.score,
    required this.title,
    required this.url,
  }) : super(id: id, by: by, time: time);

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
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

Stream<Story> fetchTopStories() async* {
  final topStoryResponse = await http.get(Uri.parse(topStoriesUri));

  if (topStoryResponse.statusCode >= 400) {
    throw Exception("Can't fetch stories!");
  }

  final List<dynamic> topStoryIds = jsonDecode(topStoryResponse.body);

  final storyResponses = await Future.wait(topStoryIds
      .take(200)
      .map((id) => http.get(Uri.parse('$storyUri/$id.json'))));

  for (final story in storyResponses
      .map((response) => jsonDecode(response.body))
      .where((item) => item['type'] == "story")
      .map((json) => Story.fromJson(json))) {
    yield story;
  }
}

Future<Story> fetchStory({required int id}) async {
  final storyResponse = await http.get(Uri.parse('$storyUri/$id.json'));

  if (storyResponse.statusCode >= 400) {
    throw Exception("Can't fetch stories!");
  }

  return Story.fromJson(jsonDecode(storyResponse.body));
}
