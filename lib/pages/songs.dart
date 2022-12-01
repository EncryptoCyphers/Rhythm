import 'package:flutter/material.dart';
import 'package:music_player_app/services/colours.dart';
import 'package:music_player_app/services/screen_sizes.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

//.............................Created Imports....................................................................//
import '../services/data_service_and_song_query.dart';
import 'full_player.dart';
import 'mini_player.dart';
import '../services/player_logic.dart';

late List<SongModel> allSongs;
List<CustomSongModel> allSongsDevice = [];
var dummy = bool;

bool? prevPermissionPreference;
Future<bool>? storagePermissionFuture;
ValueNotifier<bool> storagePermissionListener = ValueNotifier<bool>(false);
ValueNotifier<bool> circularIndicatorWidgetListener = ValueNotifier<bool>(true);

class Tracks extends StatefulWidget {
  const Tracks({super.key});
  @override
  State<Tracks> createState() => _TracksState();
}

class _TracksState extends State<Tracks> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState

    super.initState();
    setPrevPermissionPreference();
  }

  setPrevPermissionPreference() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    (prefs.getBool('prevPermissionPreferenceHasValue') != null)
        ? prevPermissionPreference = true
        : prevPermissionPreference = false;
    if (prevPermissionPreference! == false) {
      getStoragePermission();
    }
    if (await Permission.storage.isGranted) {
      storagePermissionListener.value = await Permission.storage.isGranted;
      await getAllSongList();
      await getCustomSongModel();
    }
    prefs.setBool('prevPermissionPreferenceHasValue', true);
  }

  //
  //
  //
  //
  //.........Get Songs Function.......................................................
  //
  final _audioQuery = OnAudioQuery();
  Future getAllSongList() async {
    allSongs = await _audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    await Future.delayed(
      const Duration(milliseconds: 500),
      () {
        circularIndicatorWidgetListener.value = false;
      },
    );
  }

  // //
  // //
  // //
  // //
  // //.........SongModel to CustomSongModel
  Future getCustomSongModel() async {
    allSongsDevice.clear();
    for (int i = 0; i < allSongs.length; i++) {
      CustomSongModel localSong = CustomSongModel();
      localSong.id = allSongs[i].id;
      localSong.title = allSongs[i].displayNameWOExt.toString();
      localSong.artist = allSongs[i].artist.toString();
      localSong.duration = allSongs[i].duration;
      localSong.uri = allSongs[i].uri;
      localSong.isPlaying = false;
      localSong.isWeb = false;
      allSongsDevice.add(localSong);
    }
  }

  // //
  // //
  // //
  // //
  // //...............Async to run Future Builder................................................................................//
  // //
  Future<bool> runShimmerEffect() async {
    return Permission.storage.isGranted;
  }

  // //
  // //
  // //
  // //
  // //...............Permission Functions ................................................................................//
  // //
  Future<bool> getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      storagePermissionListener.value = await Permission.storage.isGranted;
      await runShimmerEffect();
      await getAllSongList();
      await getCustomSongModel();
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
      if (await Permission.storage.request().isGranted) {
        storagePermissionListener.value = await Permission.storage.isGranted;
        await runShimmerEffect();
        await getAllSongList();
        await getCustomSongModel();
      }
    }
    return Permission.storage.isGranted;
  }

  //
  //
  //
  //
  @override
  Widget build(BuildContext context) {
    //
    //
    //......Storage Permission Listenable Builder......................................//
    //
    return FutureBuilder<bool>(
      future:
          runShimmerEffect(), // a previously-obtained Future<String> or null
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ValueListenableBuilder<bool>(
            valueListenable: storagePermissionListener,
            builder: (BuildContext context, bool permission, Widget? child) {
              //
              //
              //
              //......No Permission Widget......................................//
              //
              if (storagePermissionListener.value == false) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Storage Permission is Denied'),
                    SizedBox(
                      height: logicalHeight * 0.03,
                    ),
                    const Text('Provide Storage Permission'),
                    const Text(
                      '↓',
                      textScaleFactor: 1.5,
                    ),
                    SizedBox(
                      height: logicalHeight * 0.02,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.all(12),
                        animationDuration: const Duration(seconds: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        shadowColor: Colors.redAccent,
                      ),
                      onPressed: getStoragePermission,
                      child: const Text('Grant Permission'),
                    )
                  ],
                );
              }
              //
              //
              //
              //
              //......Yes Permission Widget......................................//
              //
              else {
                //
                //
                //
                //
                //......Circular Indicator Listenable Builder......................................//
                //
                return ValueListenableBuilder<bool>(
                  valueListenable: circularIndicatorWidgetListener,
                  builder:
                      (BuildContext context, bool permission, Widget? child) {
                    //
                    //
                    //
                    //
                    //......Yes Song Loading  Widget......................................//
                    //
                    if (circularIndicatorWidgetListener.value == true) {
                      return const ShimmerEffect();
                    }
                    //
                    //
                    //
                    //
                    //......Song Loaded  Widget......................................//
                    //
                    else {
                      //
                      //
                      //
                      //
                      //......Empty List  Widget......................................//
                      //
                      if (allSongsDevice.isEmpty) {
                        return const Center(
                          child: Text(
                            'No Songs Found',
                          ),
                        );
                      }
                      //
                      //
                      //
                      //
                      //...... List builder  Widget......................................//
                      //
                      return ListView.builder(
                        itemCount: allSongsDevice.length,
                        itemBuilder: ((context, index) {
                          //
                          //
                          //
                          //
                          //...... Song Card  Widget......................................//
                          //
                          return Container(
                            padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              // tileColor: Colors.black26,
                              //
                              //
                              //
                              //
                              //...... Artwork ......................................//
                              //
                              leading: QueryArtworkWidget(
                                id: allSongsDevice[index].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: const Icon(Icons.music_note),
                                artworkBorder:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              //
                              //
                              //
                              //
                              //...... Song Name  ......................................//
                              //
                              title: Text(
                                allSongsDevice[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              //
                              //
                              //
                              //
                              //...... Artist Name  ......................................//
                              //
                              subtitle:
                                  Text(allSongsDevice[index].artist.toString()),
                              //
                              //
                              //
                              //
                              //...... left Button  ......................................//
                              //
                              trailing: const Icon(Icons.more_horiz),
                              //
                              //
                              //
                              //
                              //...... Song OnTap ......................................//
                              //
                              onTap: () {
                                isPlayingListenable.value = true;
                                miniPlayerVisibilityListenable.value = true;
                                currSongIdListenable.value =
                                    allSongsDevice[index].id.toString();
                                getCurrSongInfo(
                                  id: allSongsDevice[index].id.toString(),
                                  duration: Duration(
                                      milliseconds:
                                          allSongsDevice[index].duration),
                                  isWeb: false,
                                  uri: allSongsDevice[index].uri,
                                  name: allSongsDevice[index].title,
                                  artist:
                                      allSongsDevice[index].artist.toString(),
                                  songIndex: index,
                                );
                                // print(allSongsDevice[index].title);
                                playSong(audioPlayer: audioPlayer);
                                getLocalMiniPlayerSongList(allSongsDevice);
                              },
                            ),
                          );
                        }),
                      );
                    }
                  },
                );
              }
            },
          );
        }
        // return Container();
        return const ShimmerEffect();
      },
    );
    // ValueListenableBuilder<bool>(
    //   valueListenable: storagePermissionListener,
    //   builder: (BuildContext context, bool permission, Widget? child) {
    //     //
    //     //
    //     //
    //     //......No Permission Widget......................................//
    //     //
    //     if (storagePermissionListener.value == false) {
    //       return Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           const Text('Storage Permission is Denied'),
    //           SizedBox(
    //             height: logicalHeight * 0.03,
    //           ),
    //           const Text('Provide Storage Permission'),
    //           const Text(
    //             '↓',
    //             textScaleFactor: 1.5,
    //           ),
    //           SizedBox(
    //             height: logicalHeight * 0.02,
    //           ),
    //           ElevatedButton(
    //             style: ElevatedButton.styleFrom(
    //               elevation: 10,
    //               backgroundColor: Colors.deepPurple,
    //               padding: const EdgeInsets.all(12),
    //               animationDuration: const Duration(seconds: 2),
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(30),
    //               ),
    //               shadowColor: Colors.redAccent,
    //             ),
    //             onPressed: getStoragePermission,
    //             child: const Text('Grant Permission'),
    //           )
    //         ],
    //       );
    //     }
    //     //
    //     //
    //     //
    //     //
    //     //......Yes Permission Widget......................................//
    //     //
    //     else {
    //       //
    //       //
    //       //
    //       //
    //       //......Circular Indicator Listenable Builder......................................//
    //       //
    //       return ValueListenableBuilder<bool>(
    //         valueListenable: circularIndicatorWidgetListener,
    //         builder: (BuildContext context, bool permission, Widget? child) {
    //           //
    //           //
    //           //
    //           //
    //           //......Yes Song Loading  Widget......................................//
    //           //
    //           if (circularIndicatorWidgetListener.value == true) {
    //             return const Center(
    //               child: CircularProgressIndicator(),
    //             );
    //           }
    //           //
    //           //
    //           //
    //           //
    //           //......Song Loaded  Widget......................................//
    //           //
    //           else {
    //             //
    //             //
    //             //
    //             //
    //             //......Empty List  Widget......................................//
    //             //
    //             if (allSongsDevice.isEmpty) {
    //               return const Center(
    //                 child: Text(
    //                   'No Songs Found',
    //                 ),
    //               );
    //             }
    //             //
    //             //
    //             //
    //             //
    //             //...... List builder  Widget......................................//
    //             //
    //             return ListView.builder(
    //               itemCount: allSongsDevice.length,
    //               itemBuilder: ((context, index) {
    //                 //
    //                 //
    //                 //
    //                 //
    //                 //...... Song Card  Widget......................................//
    //                 //
    //                 return Container(
    //                   padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
    //                   child: ListTile(
    //                     shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(20)),
    //                     // tileColor: Colors.black26,
    //                     //
    //                     //
    //                     //
    //                     //
    //                     //...... Artwork ......................................//
    //                     //
    //                     leading: QueryArtworkWidget(
    //                       id: allSongsDevice[index].id,
    //                       type: ArtworkType.AUDIO,
    //                       nullArtworkWidget: const Icon(Icons.music_note),
    //                       artworkBorder:
    //                           const BorderRadius.all(Radius.circular(10)),
    //                     ),
    //                     //
    //                     //
    //                     //
    //                     //
    //                     //...... Song Name  ......................................//
    //                     //
    //                     title: Text(
    //                       allSongsDevice[index].displayNameWOExt,
    //                       maxLines: 1,
    //                       overflow: TextOverflow.ellipsis,
    //                     ),
    //                     //
    //                     //
    //                     //
    //                     //
    //                     //...... Artist Name  ......................................//
    //                     //
    //                     subtitle: Text(allSongsDevice[index].artist.toString()),
    //                     //
    //                     //
    //                     //
    //                     //
    //                     //...... left Button  ......................................//
    //                     //
    //                     trailing: const Icon(Icons.more_horiz),
    //                     //
    //                     //
    //                     //
    //                     //
    //                     //...... Song OnTap ......................................//
    //                     //
    //                     onTap: () {
    //                       isPlayingListenable.value = true;
    //                       miniPlayerVisibilityListenable.value = true;
    //                       currSongIdListenable.value = allSongsDevice[index].id;
    //                       getCurrSongInfo(
    //                         id: allSongsDevice[index].id,
    //                         uri: allSongsDevice[index].uri,
    //                         name: allSongsDevice[index].displayNameWOExt,
    //                         artist: allSongsDevice[index].artist.toString(),
    //                         songIndex: index,
    //                       );
    //                       playSong(audioPlayer: audioPlayer);
    //                       getLocalMiniPlayerSongList(allSongsDevice);
    //                     },
    //                   ),
    //                 );
    //               }),
    //             );
    //           }
    //         },
    //       );
    //     }
    //   },
    // );
  }
}

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: shimmerBackGround,
      highlightColor: shimmerHighLight,
      child: ListView.builder(
          itemCount: ((logicalHeight - 60 - 60) / 60).floor(),
          itemBuilder: (_, __) => Container(
                padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  // tileColor: Colors.black26,
                  //
                  //
                  //
                  //
                  //...... Artwork ......................................//
                  //
                  leading: Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    color: Colors.white,
                    width: 55,
                    height: 55,
                  ),
                  //
                  //
                  //
                  //
                  //...... Song Name  ......................................//
                  //
                  title: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        // width: double.infinity,
                        height: 10,
                      ),
                      Container(
                        // width: double.infinity,
                        height: 6,
                      ),
                      Row(
                        children: [
                          Container(
                            color: Colors.white,
                            width: logicalWidth / 4,
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                  //
                  //
                  //
                  //
                  //...... Artist Name  ......................................//
                  //
                  // subtitle: Container(
                  //   width: 30.0,
                  //   height: 10.0,
                  //   color: Colors.white,
                  // ),
                  //
                  //
                  //
                  //
                  //...... left Button  ......................................//
                  //
                  trailing: const Icon(Icons.more_horiz),
                ),
              )),
    );
  }
}
