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
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:getwidget/components/search_bar/gf_search_bar.dart';
// import 'package:music_player_app/pages/full_player.dart';
// import 'package:music_player_app/pages/mini_player.dart';
// import 'package:music_player_app/pages/songs.dart';
// import 'package:music_player_app/services/colours.dart';

// import '../services/player_logic.dart';

// class LocalSearch extends StatefulWidget {
//   const LocalSearch({super.key});

//   @override
//   State<LocalSearch> createState() => _LocalSearchState();
// }

// List songsList = [];

// int indexFinder(String songName) {
//   for (int i = 0; i < allSongsDevice.length; i++) {
//     if (songName == allSongsDevice[i].title) {
//       return i;
//     }
//   }
//   return -1;
// }

// class _LocalSearchState extends State<LocalSearch> {
//   @override
//   void initState() {
//     for (var i = 0; i < allSongsDevice.length; i++) {
//       songsList.add(allSongsDevice[i].title);
//     }
//     // print(songsList);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search Music'),
//         backgroundColor: fgPurple,
//       ),
//       body: GFSearchBar(
//         searchList: songsList,
//         searchQueryBuilder: (query, list) {
//           return list
//               .where((item) =>
//                   item.toString().toLowerCase().contains(query.toLowerCase()))
//               .toList();
//         },
//         overlaySearchListItemBuilder: (item) {
//           return Container(
//             padding: const EdgeInsets.all(8),
//             child: Text(
//               item.toString(),
//               style: const TextStyle(fontSize: 18),
//             ),
//           );
//         },
//         onItemSelected: (item) {
//           if (item == null) {
//             debugPrint('Error!!!');
//           }
//           Navigator.pop(context);
//           int index = indexFinder(item.toString());
//           isPlayingListenable.value = true;
//           miniPlayerVisibilityListenable.value = true;
//           currSongIdListenable.value = allSongsDevice[index].id.toString();
//           getCurrSongInfo(
//             id: allSongsDevice[index].id.toString(),
//             duration: Duration(milliseconds: allSongsDevice[index].duration),
//             isWeb: false,
//             uri: allSongsDevice[index].uri,
//             name: allSongsDevice[index].title,
//             artist: allSongsDevice[index].artist.toString(),
//             songIndex: index,
//           );
//           // print(allSongsDevice[index].title);
//           playSong(audioPlayer: audioPlayer);
//           getLocalMiniPlayerSongList(allSongsDevice);
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:music_player_app/pages/mini_player_and_b_nav.dart';
import 'package:music_player_app/widgets/full_player.dart';
import 'package:music_player_app/pages/mini_player.dart';
import 'package:music_player_app/pages/songs.dart';

import '../services/player_logic.dart';

class CustomSearchDelegate extends SearchDelegate {
  int indexFinder(String songName) {
    for (int i = 0; i < allSongsDevice.length; i++) {
      if (songName == allSongsDevice[i].title) {
        return i;
      }
    }
    return -1;
  }

// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        // print(songsList);
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var songs in songsList) {
      if (songs.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(songs);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var songs in songsList) {
      if (songs.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(songs);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
            onTap: () {
              // print(query);
              Navigator.pop(context);
              bNavPaddingListenable.value =
                  const EdgeInsets.fromLTRB(0, 0, 0, 0);
              Future.delayed(const Duration(milliseconds: 330), () {
                miniPlayerVisibilityListenable.value = true;
              });
              int index = indexFinder(result.toString());
              isPlayingListenable.value = true;
              miniPlayerVisibilityListenable.value = true;
              currSongIdListenable.value = allSongsDevice[index].id.toString();
              getCurrSongInfo(
                id: allSongsDevice[index].id.toString(),
                duration:
                    Duration(milliseconds: allSongsDevice[index].duration),
                isWeb: false,
                uri: allSongsDevice[index].uri,
                name: allSongsDevice[index].title,
                artist: allSongsDevice[index].artist.toString(),
                songIndex: index,
              );
              // print(allSongsDevice[index].title);
              playSong(
                  // audioPlayer: audioPlayer,
                  );
              getLocalMiniPlayerSongList(allSongsDevice);
            },
          );
        });
  }
}

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: const Text('Search Music'),
//         backgroundColor: fgPurple,
//       ),
//       body: GFSearchBar(
//         searchList: list,
//         searchQueryBuilder: (query, list) {
//           return list
//               .where((item) =>
//                   item.toString().toLowerCase().contains(query.toLowerCase()))
//               .toList();
//         },
//         overlaySearchListItemBuilder: (item) {
//           return Container(
//             padding: const EdgeInsets.all(8),
//             child: Text(
//               item.toString(),
//               style: const TextStyle(fontSize: 18),
//             ),
//           );
//         },
//         onItemSelected: (item) {
//           setState(() {
//             print('$item');
//           });
//         },
//       ),
//     );
//   }
// }

// class LocalSearch extends StatefulWidget {
//   const LocalSearch({super.key});

//   @override
//   State<LocalSearch> createState() => _LocalSearchState();
// }

// class _LocalSearchState extends State<LocalSearch> {
//   @override
//   void initState() {
//     for (var i = 0; i < allSongsDevice.length; i++) {
//       songsList.add(allSongsDevice[i].title);
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }