import 'package:flutter/material.dart';
import 'package:gdsc/commmon/component/bottombar.dart';
import 'package:gdsc/commmon/component/layout/default_layout.dart';
import 'package:gdsc/home/view/home_view.dart';
import 'package:gdsc/profile/profile_view.dart';
import '../../trophy/my_trophy.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key ? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
        });
      }

  static List<Widget> pages = <Widget>[
    MyTrophy(),
    HomeView(),
    ProfileView()
  ];



  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: pages[_selectedIndex],
      bottomNavigationBar: BottomBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
