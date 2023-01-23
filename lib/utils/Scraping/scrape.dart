import 'package:http/http.dart';
import 'package:novelkeeper_flutter/Config/config.dart';
import 'package:novelkeeper_flutter/Model/scrape_job.model.dart';
import 'package:html/parser.dart' as parse;

scrape({required ScrapeJob job, required Client client}) async {
  await _getHtml(job, client);
}

_getHtml(ScrapeJob job, Client client) async {
  try {
    // get the html
    final response = await client.get(job.uri, headers: {
      "User-Agent": NKConfig.scrapeClient.userAgent,
      "Accept": "text/html",
    }).timeout(NKConfig.scrapeClient.timeout, onTimeout: () {
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
