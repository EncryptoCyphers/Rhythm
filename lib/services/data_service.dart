import 'package:http/http.dart' as http;

class DataService {
  void getMusic(String song) async {
    var headers = {
      'X-RapidAPI-Host': 'spotify23.p.rapidapi.com',
      'X-RapidAPI-Key': 'ebafd79f5amshaaf8f6feaebdb5ap1ca9e0jsn50fe88928cac',
    };

    var params = {
      'q': song,
      'type': 'tracks',
      'offset': '0',
      'limit': '10',
      'numberOfTopResults': '5',
    };
    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

    var url = Uri.parse('https://spotify23.p.rapidapi.com/search/?$query');
    var res = await http.get(url, headers: headers);
    if (res.statusCode != 200)
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    print(res.body);
  }
}
