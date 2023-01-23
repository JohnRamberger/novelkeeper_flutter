// import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
// import 'package:novelkeeper_flutter/Config/config.dart';
import 'package:faker/faker.dart';
import 'package:novelkeeper_flutter/Model/scrape_job.model.dart';

import 'package:novelkeeper_flutter/utils/Scraping/scrape.dart';

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

  startJob(ScrapeJob job) async {
    job.status = ScrapeJobStatus.RUNNING;
    await scrape(job: job, client: _client);
    print(job.status);
  }
}
