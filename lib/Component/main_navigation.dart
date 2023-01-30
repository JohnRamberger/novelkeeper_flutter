import 'package:flutter/material.dart';
import 'package:novelkeeper_flutter/View/library.view.dart';
import 'package:novelkeeper_flutter/View/settings.view.dart';
import 'package:novelkeeper_flutter/View/sources.view.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  // int _selectedIndex = 0;

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        // icons: const [
        //   Icons.local_library,
        //   Icons.south_america,
        //   Icons.settings,
        // ],
        itemCount: 3,
        tabBuilder: (index, isActive) {
          var color =
              isActive ? Theme.of(context).colorScheme.primary : Colors.grey;

          switch (index) {
            case 0:
              return Tooltip(
                  message: "Library",
                  child: Icon(
                    Icons.local_library,
                    color: color,
                  ));
            case 1:
              return Tooltip(
                  message: "Sources",
                  child: Icon(
                    Icons.south_america,
                    color: color,
                  ));
            case 2:
              return Tooltip(
                  message: "Settings",
                  child: Icon(
                    Icons.settings,
                    color: color,
                  ));
            default:
              return Tooltip(
                  message: "Library",
                  child: Icon(
                    Icons.local_library,
                    color: color,
                  ));
          }
        },
        backgroundColor: Theme.of(context).colorScheme.background,
        
        splashRadius: 20,
        splashColor: Theme.of(context).colorScheme.secondary,
        height: 80,
        gapLocation: GapLocation.none,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        activeIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  // List<PersistentBottomNavBarItem> _navBarItems() {
  //   return [
  //     PersistentBottomNavBarItem(
  //       icon: const Icon(Icons.local_library),
  //       title: ("Library"),
  //       activeColorPrimary: Theme.of(context).primaryColor,
  //       inactiveColorPrimary: Colors.grey,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: const Icon(Icons.south_america),
  //       title: ("Sources"),
  //       activeColorPrimary: Theme.of(context).primaryColor,
  //       inactiveColorPrimary: Colors.grey,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: const Icon(Icons.settings),
  //       title: ("Settings"),
  //       activeColorPrimary: Theme.of(context).primaryColor,
  //       inactiveColorPrimary: Colors.grey,
  //     ),
  //   ];
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

// BottomNavigationBar(
//       items: const [
//         BottomNavigationBarItem(
//             icon: Icon(Icons.local_library), label: "Library"),
//         BottomNavigationBarItem(
//             icon: Icon(Icons.south_america), label: "Sources"),
//         BottomNavigationBarItem(
//             icon: Icon(Icons.settings), label: "Settings"),
//       ],
//       onTap: (newIndex) {
//         setState(() {
//           _selectedIndex = newIndex;
//         });
//       },
//       currentIndex: _selectedIndex,
//     ),




