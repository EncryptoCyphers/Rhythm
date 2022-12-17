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
import 'package:page_animation_transition/animations/left_to_right_faded_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:music_player_app/pages/local_search_page.dart';

import '../widgets/b_nav.dart';
import '../pages/mini_player.dart';
import '../pages/search_page.dart';
import '../services/colours.dart';
import '../services/screen_sizes.dart';

class SearchButtonWithLogic extends StatelessWidget {
  const SearchButtonWithLogic({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
        valueListenable: playerExpandProgress,
        builder: (BuildContext context, double minPlayerHeight, Widget? child) {
          if (minPlayerHeight <= 100) {
            return ValueListenableBuilder<int>(
                valueListenable: navIndexListener,
                builder: (BuildContext context, int value, Widget? child) {
                  if (value != 2) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: miniPlayerVisibilityListenable,
                      builder:
                          (BuildContext context, bool playing, Widget? child) {
                        if (playing) {
                          return Container(
                            padding: const EdgeInsets.fromLTRB(
                                0,
                                0,
                                15,
                                // 80 +
                                60 + 23),
                            child: const SearchButton(),
                          );
                        } else {
                          return Container(
                            padding:
                                const EdgeInsets.fromLTRB(0, 0, 15, 60 + 23),
                            child: const SearchButton(),
                          );
                        }
                      },
                    );
                  } else {
                    return Container();
                  }
                });
          } else {
            return Container();
          }
        });
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (navIndexListener.value == 1) {
          // Navigator.push(
          //   context,
          //   // MaterialPageRoute(
          //   //   builder: (context) => const LocalSearch(),
          //   PageAnimationTransition(
          //     page: const LocalSearch(),
          //     pageAnimationType: RightToLeftFadedTransition(),
          //   ),
          //   // ),
          // );
          showSearch(
            context: context,
            // delegate to customize the search bar

            delegate: CustomSearchDelegate(),
          );
        } else {
          // ytSearchResults.clear();
          // ytSearchResultsCustom.clear();
          Navigator.of(context).push(
            PageAnimationTransition(
                page: const SearchPage(),
                pageAnimationType: LeftToRightFadedTransition()),
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const SearchPage(),
          //   ),
          // );
        }
      },
      child: Container(
        height: (logicalWidth * 0.16),
        width: (logicalWidth * 0.16),
        decoration: BoxDecoration(
          color: bgPurple,
          borderRadius: BorderRadius.all(Radius.circular(logicalWidth * 0.05)),
        ),
        child: const Icon(Icons.search, color: Colors.white),
      ),
    );
  }
}
