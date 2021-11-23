import 'package:flutter/material.dart';
import 'package:tugas_akhir/pages/episode.pages.dart';
import 'package:tugas_akhir/pages/home.pages.dart';
import 'package:tugas_akhir/pages/profile.pages.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedNavbar = 0;
  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Episode(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Character'),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_collection), label: 'Episode'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        currentIndex: _selectedNavbar,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _selectedNavbar = index;
          });
        },
      ),
      body: _widgetOptions.elementAt(_selectedNavbar),
    );
  }
}
