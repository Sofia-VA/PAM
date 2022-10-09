import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:t3_books/utils/exceptions.dart';
import 'package:t3_books/utils/secrets.dart';

class GoogleBooksRequest {
  static final GoogleBooksRequest _singleton = GoogleBooksRequest._internal();
  final String _API_URL = 'https://www.googleapis.com/books/v1/volumes/';
  final int maxResults = 20;

  factory GoogleBooksRequest() {
    return _singleton;
  }

  GoogleBooksRequest._internal();

  Future searchBook(String query) async {
    var _url = _API_URL +
        '?q=' +
        query +
        '&maxResults=' +
        maxResults.toString() +
        '&key=' +
        API_KEY;

    var response = await get(Uri.parse(_url));
    var respStr = jsonDecode(response.body);

    if (response.statusCode == HttpStatus.ok) {
      var data = respStr["items"];
      if (data == null) {
        throw new NoBookFoundEx();
      }

      List books = [];
      Map<String, dynamic> bookMap;

      for (var book in data) {
        bookMap = {
          "id": book["id"],
          "title": book["volumeInfo"]["title"],
          "publishedDate": book["volumeInfo"]["publishedDate"] ?? "-",
          "pages": book["volumeInfo"]["pageCount"] ?? "-",
          "cover": book["volumeInfo"]["imageLinks"]?["thumbnail"],
          "description": book["volumeInfo"]["description"] ?? "-",
        };
        books.add(bookMap);
      }

      return books;
    } else {
      throw new ConnectivityErrorEx(
          "${jsonDecode(respStr)["error"]["code"]}: ${jsonDecode(respStr)["error"]["message"]}");
    }
  }
}
