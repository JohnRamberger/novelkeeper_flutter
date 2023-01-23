import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parse;
import 'package:novelkeeper_flutter/Config/config.dart';
import 'package:faker/faker.dart';
import 'package:novelkeeper_flutter/utils/Scraping/scrape_job.model.dart';

class ScrapeClient {
  /// The http client
  var _client = http.Client();

  /// a timeout duration
  final Duration timeout;

  String userAgent = faker.internet.userAgent();

  ScrapeClient({this.timeout = const Duration(seconds: 5)});

  /// Refresh the client with a new user agent
  refresh() {
    _client.close();
    userAgent = faker.internet.userAgent();
    _client = http.Client();
  }

  startJob(ScrapeJob job) {
    try {
      job.status = ScrapeJobStatus.RUNNING;
      _getHtml(job.uri);
    } catch (err) {
      _handleError(err);
    }
  }

  _getHtml(Uri uri) async {
    try {
      // get the html
      final response = await _client.get(uri, headers: {
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
    } catch (err) {
      _handleError(err);
    }
  }

  _handleError(Object err) {
    print(err.toString());
  }
}
