import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parse;
import 'package:novelkeeper_flutter/Config/config.dart';
import 'package:faker/faker.dart';
import 'package:novelkeeper_flutter/Model/scrape_job.model.dart';

class ScrapeClient {
  /// The http client
  var _client = http.Client();

  /// a timeout duration
  final Duration timeout;

  String userAgent = faker.internet.userAgent(osName: 'android');

  ScrapeClient({this.timeout = const Duration(seconds: 5)});

  /// Refresh the client with a new user agent
  refresh() {
    _client.close();
    userAgent = faker.internet.userAgent(osName: 'android');
    _client = http.Client();
  }

  startJob(ScrapeJob job) {
    try {
      job.status = ScrapeJobStatus.RUNNING;
      _getHtml(job);
    } catch (err, stacktrace) {
      _handleError(job, err, stacktrace);
    }
  }

  _getHtml(ScrapeJob job) async {
    try {
      // get the html
      final response = await _client.get(job.uri, headers: {
        "User-Agent": userAgent,
        "Accept": "text/html",
      }).timeout(timeout, onTimeout: () {
        throw Exception("Request timed out");
      });
      // parse the html
      _parseHtml(job, response.body);
    } catch (err, stacktrace) {
      _handleError(job, err, stacktrace);
    }
  }

  /// Parse the html
  _parseHtml(ScrapeJob job, String body) {
    try {
      // parse the html
      job.setSuccess(parse.parse(body));
    } catch (err, stacktrace) {
      _handleError(job, err, stacktrace);
    }
  }

  _handleError(ScrapeJob job, Object err, StackTrace stacktrace) {
    print(err);
    print(stacktrace);
    job.setError(err);
  }
}
