import 'package:flutter/cupertino.dart';
import 'package:meal_mate/screens/add_screen/add_screen.dart';
import 'package:meal_mate/screens/tab_box/community/community_screen.dart';
import 'package:meal_mate/screens/tab_box/search/search_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../utils/tools/file_importer.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {



  List<Widget> _buildScreens() {
    return const [
      HomePage(),
      SearchScreen(),
      CommunityScreen(),
      ProfileScreen(),
    ];
  }

  List<BottomNavigationBarItem> bottomNavItems  = const [
    BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.search),label: "Search"),
    BottomNavigationBarItem(icon: Icon(Icons.chat_bubble),label: "Community"),
    BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.borderShade600,
          currentIndex: context.watch<TabViewModel>().getIndex,

          onTap: (newIndex){
            context.read<TabViewModel>().changeIndex(newIndex);
          },
          items: bottomNavItems,
      ),
      body: _buildScreens()[context.watch<TabViewModel>().getIndex],
    );
  }
}
