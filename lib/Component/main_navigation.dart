import 'package:flutter/material.dart';
import 'package:novelkeeper_flutter/View/library.view.dart';
import 'package:novelkeeper_flutter/View/settings.view.dart';
import 'package:novelkeeper_flutter/View/sources.view.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  // int _selectedIndex = 0;

  late PersistentTabController _controller;
  int _selectedIndex = 0;
  late bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: _selectedIndex);
    _hideNavBar = false;

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: PersistentTabView(
          context,
          screens: _buildScreens(),
          items: _navBarItems(),
          controller: _controller,
          hideNavigationBar: _hideNavBar,
          confineInSafeArea: true,
          // backgroundColor: Theme.of(context).backgroundColor,
          decoration: const NavBarDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          handleAndroidBackButtonPress: true,
          stateManagement: true,
          // padding: const NavBarPadding.only(right: 8, left: 8, bottom: 64, top: 64),
          navBarStyle: NavBarStyle.style11,
        ));
  }

  List<Widget> _buildScreens() {
    return [
      const LibraryView(),
      const SourcesView(),
      const SettingsView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.local_library),
        title: ("Library"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.south_america),
        title: ("Sources"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: ("Settings"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
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
}

//   _buildBody() {
//     switch (_selectedIndex) {
//       case 0:
//         return const LibraryView();
//       case 1:
//         return const SourcesView();
//       case 2:
//         return const SettingsView();
//       case 3:
//         return Container();
//       default:
//         return Container();
//     }
//   }
// }
