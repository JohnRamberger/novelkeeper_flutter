import 'package:flutter/cupertino.dart';

class TextClosed extends ChangeNotifier {
  bool _mounted = true;
  bool get mounted => _mounted;

  /// Whether the textbox is closed
  bool _isClosed = true;

  /// Whether the textbox is closed
  bool get isClosed => _isClosed;

  /// Toggles the textbox closed state
  void toggle() {
    _isClosed = !_isClosed;
    if (_mounted) notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }
}
