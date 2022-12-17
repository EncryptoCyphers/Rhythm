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
class TrendingSongs {
  TrendingSongs({
    required this.title,
    required this.videoId,
    required this.author,
    required this.lengthSeconds,
  });

  String title;
  String videoId;
  String author;
  int lengthSeconds;

  factory TrendingSongs.fromJson(Map<String, dynamic> json) => TrendingSongs(
        title: json["title"],
        videoId: json["videoId"],
        author: json["author"],
        lengthSeconds: json["lengthSeconds"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "videoId": videoId,
        "author": author,
        "lengthSeconds": lengthSeconds,
      };
}
