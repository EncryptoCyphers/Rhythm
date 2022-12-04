import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getwidget/components/search_bar/gf_search_bar.dart';
import 'package:music_player_app/services/colours.dart';

class LocalSearch extends StatefulWidget {
  const LocalSearch({super.key});

  @override
  State<LocalSearch> createState() => _LocalSearchState();
}

List list = [
  "Flutter",
  "React",
  "Ionic",
  "Xamarin",
];

class _LocalSearchState extends State<LocalSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Music'),
        backgroundColor: fgPurple,
      ),
      body: GFSearchBar(
        searchList: list,
        searchQueryBuilder: (query, list) {
          return list
              .where((item) =>
                  item.toString().toLowerCase().contains(query.toLowerCase()))
              .toList();
        },
        overlaySearchListItemBuilder: (item) {
          return Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              item.toString(),
              style: const TextStyle(fontSize: 18),
            ),
          );
        },
        onItemSelected: (item) {
          setState(() {
            print('$item');
          });
        },
      ),
    );
  }
}
