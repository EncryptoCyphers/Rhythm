import 'package:music_player_app/services/data_service_and_song_query.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../pages/search_page.dart';

var yt = YoutubeExplode();
List<Video> ytSearchResults = [];
List<CustomSongModel> ytSearchResultsCustom = [];
Future fetchSearchResults(String query) async {
  ytSearchResultsCustom.clear();
  ytSearchResults.clear();
  // ignore: deprecated_member_use
  ytSearchResults = await yt.search.getVideos(query);
  for (int i = 0; i < ytSearchResults.length; i++) {
    CustomSongModel searchedWebSong = CustomSongModel();
    searchedWebSong.id = ytSearchResults[i].id.toString();
    searchedWebSong.videoIdForFetchStream = ytSearchResults[i].id;
    searchedWebSong.title = ytSearchResults[i].title;
    searchedWebSong.artist = ytSearchResults[i].author;
    searchedWebSong.duration = ytSearchResults[i].duration;
    searchedWebSong.isPlaying = false;
    searchedWebSong.isWeb = true;
    // print(searchedWebSong.title);
    searchedWebSong.uri = '';
    ytSearchResultsCustom.add(searchedWebSong);
  }
  isSearchLoading.value = false;
  searchHappened.value = !searchHappened.value;
}

Future<String> getUri(VideoId videoId) async {
  // print("Title" + video.title);
  final StreamManifest manifest =
      await yt.videos.streamsClient.getManifest(videoId);
  final List<AudioOnlyStreamInfo> sortedStreamInfo =
      manifest.audioOnly.sortByBitrate();

  return sortedStreamInfo.first.url.toString();
}
