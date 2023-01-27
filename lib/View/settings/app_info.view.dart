import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:novelkeeper_flutter/ViewModel/settings/app_info.viewmodel.dart';
import 'package:provider/provider.dart';

class AppInfoView extends StatefulWidget {
  const AppInfoView({super.key});

  @override
  State<AppInfoView> createState() => _AppInfoViewState();
}

class _AppInfoViewState extends State<AppInfoView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AppInfoViewModel(), child: _buildLoading());
  }

  Widget _buildLoading() {
    return Consumer<AppInfoViewModel>(
      builder: (context, model, child) {
        if (model.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return _buildDetails();
        }
      },
    );
  }

  Widget _buildDetails() {
    return Consumer<AppInfoViewModel>(builder: (context, model, child) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          body: ListView(
            children: [
              ListTile(
                  title: const Text("App Name"),
                  subtitle: Text(model.packageInfo.appName),
                  onLongPress: () {
                    _copyToClipboard(model.packageInfo.appName);
                  }),
              ListTile(
                  title: const Text("Package Name"),
                  subtitle: Text(model.packageInfo.packageName),
                  onLongPress: () {
                    _copyToClipboard(model.packageInfo.packageName);
                  }),
              ListTile(
                  title: const Text("Version"),
                  subtitle: Text(model.packageInfo.version),
                  onLongPress: () {
                    _copyToClipboard(model.packageInfo.version);
                  }),
              ListTile(
                  title: const Text("Build Number"),
                  subtitle: Text(model.packageInfo.buildNumber),
                  onLongPress: () {
                    _copyToClipboard(model.packageInfo.buildNumber);
                  }),
            ],
          ));
    });
  }

  _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
