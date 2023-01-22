import 'package:flutter/material.dart';
import 'package:novelkeeper_flutter/Views/library.view.dart';

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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
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
          title: Text("Library"),
        );
      case 1:
        return AppBar(
          title: Text("Home"),
        );
      default:
        return AppBar(
          title: Text("NovelKeeper"),
        );
    }
  }

  _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return LibraryView();
      case 1:
        return Container();
      case 2:
        return Container();
      case 3:
        return Container();
      default:
        return Container();
    }
  }
}
