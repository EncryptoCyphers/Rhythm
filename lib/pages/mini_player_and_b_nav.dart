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
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player_app/pages/search_page.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:music_player_app/services/screen_sizes.dart';

import '../services/colours.dart';
import '../widgets/b_nav.dart';
import '../widgets/circular_mini_player.dart';

ValueNotifier<EdgeInsets> bNavPaddingListenable =
    ValueNotifier(const EdgeInsets.fromLTRB(0, 0, 45, 0));

class MiniPlayerAndBNav extends StatefulWidget {
  const MiniPlayerAndBNav({super.key, required this.pageController});
  final PageController pageController;
  @override
  State<MiniPlayerAndBNav> createState() => _MiniPlayerAndBNavState();
}

class _MiniPlayerAndBNavState extends State<MiniPlayerAndBNav> {
  // void updatePadding() {
  //   // setState(() {
  //   bNavPadding = const EdgeInsets.fromLTRB(0, 0, 0, 0);
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
          child: ValueListenableBuilder<EdgeInsets>(
              valueListenable: bNavPaddingListenable,
              builder: (BuildContext context, EdgeInsets value, Widget? child) {
                if (value != bNavPadding) {
                  bNavPadding = bNavPaddingListenable.value;
                  return AnimatedPadding(
                    duration: const Duration(milliseconds: 500),
                    padding: bNavPaddingListenable.value,
                    child: BNav(pageController: widget.pageController),
                  );
                } else {
                  return AnimatedPadding(
                    duration: const Duration(milliseconds: 500),
                    padding: bNavPaddingListenable.value,
                    child: BNav(pageController: widget.pageController),
                  );
                }
              }),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, logicalWidth - 90, 15),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              const CircularMiniPlayer(),
              ValueListenableBuilder<bool>(
                  valueListenable: isFetchingUri,
                  builder:
                      (BuildContext context, bool isFetching, Widget? child) {
                    if (isFetching) {
                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(35)),
                            child: Container(
                              color: Colors.white,
                              height: 70,
                              width: 70,
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                color: fgPurple,
                                size: 50,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 70,
                            width: 70,
                            child: CircularProgressIndicator(
                              value: 0,
                              strokeWidth: 6,
                              // backgroundColor: Colors.transparent,
                              backgroundColor: Color.fromARGB(25, 0, 0, 0),
                            ),
                          )
                        ],
                      );
                    } else {
                      return Container();
                    }
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
