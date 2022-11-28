import 'package:http/http.dart' as http;
import 'package:music_player_app/pages/web.dart';
import 'package:music_player_app/services/json_object_model.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'dart:convert';

//----------------------------------------Searched Song Class Model--------------------------------------//
class SearchedWebSong {
  // ignore: prefer_typing_uninitialized_variables
  late var id;
  // ignore: prefer_typing_uninitialized_variables
  late var title;
  // ignore: prefer_typing_uninitialized_variables
  late var artist;
  // ignore: prefer_typing_uninitialized_variables
  late var duration;
  late bool isPlaying;
}

//----------------------------------------List of Searched Song Objects--------------------------------------//
List<SearchedWebSong> webSongList = [];

class DataService {
  void getMusic(String song) async {
    //------------------------------------------API Query and API Call--------------------------------------//
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

      var yt = YoutubeExplode();
      var streamInfo = await yt.videos.get(songId);

      SearchedWebSong searchedWebSong = SearchedWebSong();

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
    isSearchLoading.value = false;
    searchHappened.value = !searchHappened.value;
  }
}
