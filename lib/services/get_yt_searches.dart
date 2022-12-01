import 'package:youtube_explode_dart/youtube_explode_dart.dart';

var yt = YoutubeExplode();
List<Video> ytSearchResults = [];
Future fetchSearchResults(String query) async {
  // ignore: deprecated_member_use
  ytSearchResults = await yt.search.getVideos(query);
}
