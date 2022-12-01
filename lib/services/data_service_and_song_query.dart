//import 'package:http/http.dart' as http;
//import 'package:music_player_app/services/json_object_model.dart';
//import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_data_api/youtube_data_api.dart';
import 'package:youtube_data_api/models/video.dart';

import '../pages/search_page.dart';
//import 'dart:convert';

//----------------------------------------Searched Song Class Model--------------------------------------//
class CustomSongModel {
  // ignore: prefer_typing_uninitialized_variables
  late var id;
  // ignore: prefer_typing_uninitialized_variables
  late var title;
  // ignore: prefer_typing_uninitialized_variables
  late var artist;
  // ignore: prefer_typing_uninitialized_variables
  late var uri;
  // ignore: prefer_typing_uninitialized_variables
  late var duration;
  late bool isPlaying;
  late bool isWeb;
}

//----------------------------------------List of Searched Song Objects--------------------------------------//
List<CustomSongModel> webSongList = [];

// class DataService {
//   void getMusic(String songQuery) async {
    //------------------------------------------API Query and API Call--------------------------------------//
    /*
    final queryParameters = {
      'maxResults': '10',
      'q': song,
      'key': 'AIzaSyAbHt9yfNyLiY6ZgS_oVizXI6MzxajMC7s'
    };

    //https://youtube.googleapis.com/youtube/v3/search?q=demons&key=[YOUR_API_KEY]
    final uri = Uri.https(
        'youtube.googleapis.com', '/youtube/v3/search', queryParameters);
    final response = await http.get(uri);

    SongList songList = SongList.fromJson(jsonDecode(response.body));

    //-------------------------------------Adding song objects to webSongList---------------------------------//
    webSongList = [];
    for (var i = 0; i < songList.items.length; i++) {
      var songId = songList.items[i].id.videoId;

      //var yt = YoutubeExplode();
      var streamInfo = await yt.videos.get(songId);

      CustomSongModel searchedWebSong = CustomSongModel();

      searchedWebSong.id = streamInfo.id;
      searchedWebSong.title = streamInfo.title;
      searchedWebSong.artist = streamInfo.author;
      searchedWebSong.duration = streamInfo.duration;
      searchedWebSong.isPlaying = false;
      // print('Fetching Songs');
      webSongList.add(searchedWebSong);
      yt.close();
      // print(isSearchLoading.value);
    }
    */
//     YoutubeDataApi youtubeDataApi = YoutubeDataApi();
//     List searchResult = await youtubeDataApi.fetchSearchVideo(
//         songQuery, 'AIzaSyAbHt9yfNyLiY6ZgS_oVizXI6MzxajMC7s');
//     webSongList = [];
//     for (var element in searchResult) {
//       if (element is Video) {
//         CustomSongModel searchedWebSong = CustomSongModel();
//         searchedWebSong.id = element.videoId;
//         searchedWebSong.title = element.title;
//         searchedWebSong.artist = element.channelName;
//         searchedWebSong.duration = element.duration;

//         searchedWebSong.isPlaying = false;
//         searchedWebSong.isWeb = true;
//         webSongList.add(searchedWebSong);
//       }
//     }

//     isSearchLoading.value = false;
//     searchHappened.value = !searchHappened.value;
//   }
// }
