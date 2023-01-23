import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parse;
import 'package:novelkeeper_flutter/Config/config.dart';

class Scrape {
  /// a valid sting url
  final String url;

  /// The uri to scrape
  Uri _uri = Uri();

  /// The http client
  final _client = http.Client();

  /// a timeout duration
  final Duration timeout;

  /// called when an error occurs. returns the error. Error is already printed.
  final dynamic Function(Object) onError;

  /// called when the scraping is successful. returns the parsed html document.
  final dynamic Function(Document) onSuccess;

  Scrape(
      {required this.url,
      required this.onError,
      required this.onSuccess,
      this.timeout = const Duration(seconds: 5)}) {
    // convert url to valid uri
    _uri = Uri.https(url);

    try {
      // get the html
      _getHtml();
    } catch (err) {
      _handleError(err);
    }
  }

  _getHtml() async {
    try {
      // get the html
      final response = await _client.get(_uri, headers: {
        "User-Agent": NKConfig.userAgent,
        "Accept": "text/html",
      }).timeout(timeout, onTimeout: () {
        throw Exception("Request timed out");
      });
      // parse the html
      _parseHtml(response.body);
    } catch (err) {
      _handleError(err);
    }
  }

  /// Parse the html
  _parseHtml(String body) {
    try {
      // parse the html
      var document = parse.parse(body);
      onSuccess(document);
    } catch (err) {
      _handleError(err);
    }
  }

  _handleError(Object err) {
    print(err.toString());
    onError(err);
  }
}
