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
