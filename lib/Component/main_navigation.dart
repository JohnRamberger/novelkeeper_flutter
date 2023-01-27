import 'package:flutter/material.dart';
import 'package:novelkeeper_flutter/View/library.view.dart';
import 'package:novelkeeper_flutter/View/settings.view.dart';
import 'package:novelkeeper_flutter/View/sources.view.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.local_library), label: "Library"),
          BottomNavigationBarItem(
              icon: Icon(Icons.south_america), label: "Sources"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
        onTap: (newIndex) {
          setState(() {
            _selectedIndex = newIndex;
          });
        },
        currentIndex: _selectedIndex,
      ),
    );
  }

  _buildAppBar() {
    switch (_selectedIndex) {
      case 0:
        return AppBar(
          title: const Text("Library"),
        );
      case 1:
        return AppBar(
          title: const Text("Sources"),
        );
      case 2:
        return AppBar(
          title: const Text("Settings"),
        );
      default:
        return AppBar(
          title: const Text("NovelKeeper"),
        );
    }
  }

  _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const LibraryView();
      case 1:
        return const SourcesView();
      case 2:
        return const SettingsView();
      case 3:
        return Container();
      default:
        return Container();
    }
  }
}
