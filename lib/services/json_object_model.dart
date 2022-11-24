import 'dart:convert';

TrackList welcomeFromJson(String str) => TrackList.fromJson(json.decode(str));

String welcomeToJson(TrackList data) => json.encode(data.toJson());

class TrackList {
  TrackList({
    required this.query,
    required this.tracks,
  });

  String query;
  Tracks tracks;

  factory TrackList.fromJson(Map<String, dynamic> json) => TrackList(
        query: json["query"],
        tracks: Tracks.fromJson(json["tracks"]),
      );

  Map<String, dynamic> toJson() => {
        "query": query,
        "tracks": tracks.toJson(),
      };
}

class Tracks {
  Tracks({
    required this.totalCount,
    required this.items,
    required this.pagingInfo,
  });

  int totalCount;
  List<TracksItem> items;
  PagingInfo pagingInfo;

  factory Tracks.fromJson(Map<String, dynamic> json) => Tracks(
        totalCount: json["totalCount"],
        items: List<TracksItem>.from(
            json["items"].map((x) => TracksItem.fromJson(x))),
        pagingInfo: PagingInfo.fromJson(json["pagingInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "pagingInfo": pagingInfo.toJson(),
      };
}

class TracksItem {
  TracksItem({
    required this.data,
  });

  Data data;

  factory TracksItem.fromJson(Map<String, dynamic> json) => TracksItem(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.uri,
    required this.id,
    required this.name,
    required this.albumOfTrack,
    required this.artists,
    //required this.contentRating,
    required this.duration,
    required this.playability,
  });

  String uri;
  String id;
  String name;
  AlbumOfTrack albumOfTrack;
  Artists artists;
  //ContentRating contentRating;
  Duration duration;
  Playability playability;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        uri: json["uri"],
        id: json["id"],
        name: json["name"],
        albumOfTrack: AlbumOfTrack.fromJson(json["albumOfTrack"]),
        artists: Artists.fromJson(json["artists"]),
        //contentRating: ContentRating.fromJson(json["contentRating"]),
        duration: Duration.fromJson(json["duration"]),
        playability: Playability.fromJson(json["playability"]),
      );

  Map<String, dynamic> toJson() => {
        "uri": uri,
        "id": id,
        "name": name,
        "albumOfTrack": albumOfTrack.toJson(),
        "artists": artists.toJson(),
        //"contentRating": contentRating.toJson(),
        "duration": duration.toJson(),
        "playability": playability.toJson(),
      };
}

class AlbumOfTrack {
  AlbumOfTrack({
    required this.uri,
    required this.name,
    required this.coverArt,
    required this.id,
    required this.sharingInfo,
  });

  String uri;
  String name;
  CoverArt coverArt;
  String id;
  SharingInfo sharingInfo;

  factory AlbumOfTrack.fromJson(Map<String, dynamic> json) => AlbumOfTrack(
        uri: json["uri"],
        name: json["name"],
        coverArt: CoverArt.fromJson(json["coverArt"]),
        id: json["id"],
        sharingInfo: SharingInfo.fromJson(json["sharingInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "uri": uri,
        "name": name,
        "coverArt": coverArt.toJson(),
        "id": id,
        "sharingInfo": sharingInfo.toJson(),
      };
}

class CoverArt {
  CoverArt({
    required this.sources,
  });

  List<Source> sources;

  factory CoverArt.fromJson(Map<String, dynamic> json) => CoverArt(
        sources:
            List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
      };
}

class Source {
  Source({
    required this.url,
    required this.width,
    required this.height,
  });

  String url;
  int width;
  int height;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
      };
}

class SharingInfo {
  SharingInfo({
    required this.shareUrl,
  });

  String shareUrl;

  factory SharingInfo.fromJson(Map<String, dynamic> json) => SharingInfo(
        shareUrl: json["shareUrl"],
      );

  Map<String, dynamic> toJson() => {
        "shareUrl": shareUrl,
      };
}

class Artists {
  Artists({
    required this.items,
  });

  List<ArtistsItem> items;

  factory Artists.fromJson(Map<String, dynamic> json) => Artists(
        items: List<ArtistsItem>.from(
            json["items"].map((x) => ArtistsItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class ArtistsItem {
  ArtistsItem({
    required this.uri,
    required this.profile,
  });

  String uri;
  Profile profile;

  factory ArtistsItem.fromJson(Map<String, dynamic> json) => ArtistsItem(
        uri: json["uri"],
        profile: Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "uri": uri,
        "profile": profile.toJson(),
      };
}

class Profile {
  Profile({
    required this.name,
  });

  String name;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
/*
class ContentRating {
    ContentRating({
        required this.label,
    });

    Label? label;

    factory ContentRating.fromJson(Map<String, dynamic> json) => ContentRating(
        label: labelValues.map[json["label"]],
    );

    Map<String, dynamic> toJson() => {
        "label": labelValues.reverse[label],
    };
}

enum Label { NONE }

final labelValues = EnumValues({
    "NONE": Label.NONE
});
*/

class Duration {
  Duration({
    required this.totalMilliseconds,
  });

  int totalMilliseconds;

  factory Duration.fromJson(Map<String, dynamic> json) => Duration(
        totalMilliseconds: json["totalMilliseconds"],
      );

  Map<String, dynamic> toJson() => {
        "totalMilliseconds": totalMilliseconds,
      };
}

class Playability {
  Playability({
    required this.playable,
  });

  bool playable;

  factory Playability.fromJson(Map<String, dynamic> json) => Playability(
        playable: json["playable"],
      );

  Map<String, dynamic> toJson() => {
        "playable": playable,
      };
}

class PagingInfo {
  PagingInfo({
    required this.nextOffset,
    required this.limit,
  });

  int nextOffset;
  int limit;

  factory PagingInfo.fromJson(Map<String, dynamic> json) => PagingInfo(
        nextOffset: json["nextOffset"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "nextOffset": nextOffset,
        "limit": limit,
      };
}
