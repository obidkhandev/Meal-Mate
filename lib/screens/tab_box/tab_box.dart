import 'package:meal_mate/screens/profile/profile_screen.dart';
import 'package:meal_mate/screens/tab_box/view_model/view_model.dart';
import '../../utils/tools/file_importer.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> _screens = [
    HomePage(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<TabViewModel>().getIndex,
        onTap: (index) {
          context.read<TabViewModel>().changeIndex(index);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
              activeIcon: Icon(
                Icons.home,
                color: Colors.red,
              )),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "Profile",
            activeIcon: Icon(
              Icons.person,
              color: Colors.red,
            ),
          ),
          // BottomNavigationBarItem(icon: Icon(Icons.home,),label: "Search"),
        ],
      ),
      body: _screens[context.watch<TabViewModel>().getIndex],
    );
  }
}
