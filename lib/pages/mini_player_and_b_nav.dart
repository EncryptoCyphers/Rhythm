import 'package:flutter/cupertino.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:music_player_app/services/screen_sizes.dart';

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
        ValueListenableBuilder<EdgeInsets>(
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
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, logicalWidth - 90, 10),
          child: const CircularMiniPlayer(),
        ),
      ],
    );
  }
}
