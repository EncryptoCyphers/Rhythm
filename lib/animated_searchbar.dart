import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget with PreferredSizeWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchBarState extends State<SearchBar> {
  bool _toggle = true;

  void _doToggle() => setState(() => _toggle = !_toggle);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Stack(children: [
        GestureDetector(
          onTap: _doToggle,
          child: SizedBox(
              height: kToolbarHeight * 0.8,
              child: Row(
                children: const [
                  Icon(
                    Icons.search,
                    size: 24.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text("Search"),
                ],
              )),
        ),
        AnimatedContainer(
          width: _toggle ? 0 : MediaQuery.of(context).size.width,
          transform: Matrix4.translationValues(
              _toggle ? MediaQuery.of(context).size.width : 0, 0, 0),
          duration: const Duration(seconds: 1),
          height: kToolbarHeight * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              width: 1,
              color: Colors.grey[600]!,
            ),
          ),
          child: TextField(
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
                prefixIcon: AnimatedOpacity(
                    duration: const Duration(seconds: 1),
                    opacity: _toggle ? 0 : 1,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: _doToggle,
                    )),
                border: InputBorder.none),
          ),
        )
      ]),
    );
  }
}
