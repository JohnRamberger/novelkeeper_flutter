String getBaseUrl(String url) {
  final uri = Uri.parse(url);
  return '${uri.scheme}://${uri.host}';
}

/// Get the full url from a base url and a relative url
/// , if not relative, return the url
String getFullUrl(String baseUrl, String url) {
  if (url.startsWith("http")) {
    return url;
  }
  return "$baseUrl$url";
}
