/*
 *  This file is part of Rhythm (https://github.com/EncryptoCyphers/Rhythm).
 * 
 * Rhythm is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Rhythm is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Rhythm.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Copyright (c) 2022-2023, EncryptoCyphers
 */
import 'package:music_player_app/services/json_object_model.dart';
//import 'package:youtube_data_api/youtube_data_api.dart';
//import 'package:youtube_data_api/models/video.dart';
import 'package:music_player_app/services/data_service_and_song_query.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/*
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
*/

List<CustomSongModel> trendingSongList = [];

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
      CustomSongModel trendingMusic = CustomSongModel();
      trendingMusic.id = list[i].videoId;
      trendingMusic.artist = list[i].author;
      trendingMusic.title = list[i].title;
      trendingMusic.duration = Duration(seconds: list[i].lengthSeconds);
      //trendingMusic.videoIdForFetchStream = list[i].videoId;
      trendingMusic.isPlaying = false;
      trendingMusic.isWeb = true;
      trendingSongList.add(trendingMusic);
    }
  }
}
