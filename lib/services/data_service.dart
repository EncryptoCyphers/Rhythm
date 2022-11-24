import 'package:http/http.dart' as http;
import 'package:music_player_app/services/json_object_model.dart';
import 'dart:convert';

class DataService {
  void getMusic(String song) async {
    //https://youtube.googleapis.com/youtube/v3/search?q=demons&key=[YOUR_API_KEY]
    final queryParameters = {
      'maxResults': '10',
      'q': song,
      'key': 'AIzaSyAbHt9yfNyLiY6ZgS_oVizXI6MzxajMC7s'
    };
    final uri = Uri.https(
        'youtube.googleapis.com', '/youtube/v3/search', queryParameters);

    final response = await http.get(uri);
    //print(response.body);

    SongList songList = SongList.fromJson(jsonDecode(response.body));
    /*
    for (var i = 0; i < songList.items.length; i++) {
      print(songList.items[i].id.videoId);
    }
    */
  }
}
