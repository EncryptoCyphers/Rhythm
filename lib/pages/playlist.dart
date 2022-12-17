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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_player_app/services/colours.dart';

class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Playlist'),
          backgroundColor: fgPurple,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.solidFaceFrown,
                  size: 80,
                  color: Color.fromARGB(255, 116, 92, 201),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(
                      'ERROR',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: fgPurple,
                      ),
                    ),
                    Text(
                      'Service Unavailable',
                      style: TextStyle(
                        fontSize: 17.5,
                        color: fgPurple,
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ));
  }
}
