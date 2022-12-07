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
