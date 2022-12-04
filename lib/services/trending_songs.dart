import 'package:youtube_data_api/youtube_data_api.dart';
import 'package:youtube_data_api/models/video.dart';

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
}
