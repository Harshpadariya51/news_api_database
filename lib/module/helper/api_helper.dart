import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quotes_api_app/module/models/news_model.dart';

class APIHelper {
  APIHelper._();

  static final APIHelper apiHelper = APIHelper._();

  String apiKey = "989a4495824248bfbb4d43051fb54cf0";

  Future<List<News>?> fetchedQuote() async {
    String api = "https://newsapi.org/v2/top-headlines/sources?apiKey=$apiKey";

    http.Response response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      String data = response.body;

      Map decodedData = jsonDecode(data);

      List news = decodedData['sources'];

      return news
          .map(
            (e) => News(
              id: e['id'],
              name: e['name'],
              description: e['description'],
              url: e['url'],
              category: e['category'],
              language: e['language'],
              country: e['country'],
            ),
          )
          .toList();
    }
    return null;
  }
}
