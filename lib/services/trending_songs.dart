import 'package:music_player_app/services/json_object_model.dart';
//import 'package:youtube_data_api/youtube_data_api.dart';
//import 'package:youtube_data_api/models/video.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TrendingMusic {
  // ignore: prefer_typing_uninitialized_variables
  late var id;
  // ignore: prefer_typing_uninitialized_variables
  late var title;
  // ignore: prefer_typing_uninitialized_variables
  late var artist;
  // ignore: prefer_typing_uninitialized_variables
  late var duration;
}

List<TrendingMusic> trendingSongList = [];

class Trending {
  /*
  YoutubeDataApi youtubeDataApi = YoutubeDataApi();
  getTrendingMusic() async {
    List<Video> music = await youtubeDataApi.fetchTrendingMusic();
    trendingSongList = [];
    for (var i = 0; i < music.length; i++) {
      //print(music[i].title);
      TrendingMusic trendingMusic = TrendingMusic();
      trendingMusic.id = music[i].videoId;
      trendingMusic.title = music[i].title;
      trendingMusic.artist = music[i].channelName;
      trendingMusic.duration = music[i].duration;
      trendingSongList.add(trendingMusic);
    }
  }
  */
  getTrendingMusic() async {
    const Map<String, String> headers = {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36'
    };
    final queryParameters = {'type': 'Music', 'region': 'IN'};
    final uri =
        Uri.https('invidious.snopyta.org', '/api/v1/trending', queryParameters);
    final response = await http.get(uri, headers: headers);
    //print(response.body);

    var list = (json.decode(response.body) as List)
        .map((data) => TrendingSongs.fromJson(data))
        .toList();
    trendingSongList = [];
    for (int i = 0; i < list.length; i++) {
      TrendingMusic trendingMusic = TrendingMusic();
      trendingMusic.id = list[i].videoId;
      trendingMusic.artist = list[i].author;
      trendingMusic.title = list[i].title;
      trendingMusic.duration = list[i].lengthSeconds;
      trendingSongList.add(trendingMusic);
    }
  }
}
