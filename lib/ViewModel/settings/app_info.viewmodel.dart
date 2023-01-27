import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoViewModel extends ChangeNotifier {
  /// This is used to prevent calling notifyListeners() after dispose()
  bool _mounted = true;

  /// Whether this provider is mounted
  bool get mounted => _mounted;

  late PackageInfo _packageInfo;
  PackageInfo get packageInfo => _packageInfo;

  bool _isLoading = true;

  /// Whether the app info is still loading
  bool get isLoading => _isLoading;

  AppInfoViewModel() {
    _init();
  }

  Future<void> _init() async {
    _packageInfo = await PackageInfo.fromPlatform();
    _isLoading = false;
    if (_mounted) notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }
}
