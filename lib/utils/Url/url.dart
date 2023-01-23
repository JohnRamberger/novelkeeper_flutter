String getBaseUrl(String url) {
  final uri = Uri.parse(url);
  return '${uri.scheme}://${uri.host}';
}
