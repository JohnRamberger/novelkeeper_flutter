import 'package:html/dom.dart';

import 'package:uuid/uuid.dart';

enum ScrapeJobStatus { PENDING, RUNNING, SUCCESS, ERROR }

class ScrapeJob {
  String _id = "";
  Uri _uri = Uri();

  late Object _error;
  late Document _document;

  ScrapeJobStatus status = ScrapeJobStatus.PENDING;

  final dynamic Function() callback;

  ScrapeJob({required String url, required this.callback, bool https = true}) {
    _id = const Uuid().v4();
    _uri = https ? Uri.https(url, "") : Uri.http(url, "");
  }

  ScrapeJob.fromUri({required Uri uri, required this.callback}) {
    _id = const Uuid().v4();
    _uri = uri;
  }

  // Getters
  get id => _id;
  get uri => _uri;
  get error => _error;
  get document => _document;

  setError(Object err) {
    _error = err;
    status = ScrapeJobStatus.ERROR;
  }

  setSuccess(Document doc) {
    _document = doc;
    status = ScrapeJobStatus.SUCCESS;
  }
}
