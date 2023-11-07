import 'package:flutter/material.dart';
import './studentListScreen.dart';
import './feesScreen.dart';
import './academicScreen.dart';
import './eventScreen.dart';
import '../models/profile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    StudentListScreen(),
    UpcomingEventsScreen(),
    FeePaymentScreen(),
    AcademicsPage(),
  ];

  final List<String> _screenName = ["Home", "Events", "Fee", "Academics"];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 12, 12),
        title: Text("${_screenName[_selectedIndex]}"),
      ),
      backgroundColor: Color.fromARGB(20, 20, 20, 0),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 12, 12, 12),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Students',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_sharp),
            label: 'Fees',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Academics',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.limeAccent,
        unselectedItemColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 12, 12, 12),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('Keerthana'),
                accountEmail: Text('keerthana@example.com'),
                currentAccountPicture: ProfileAvatar(
                  iconData: Icons.person_outlined,
                  backgroundColor: Colors.orange,
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 26, 26, 26),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                selected: _selectedIndex == 0,
                title: Text(
                  _screenName[0],
                  style: TextStyle(
                    color:
                        _selectedIndex == 0 ? Colors.limeAccent : Colors.white,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                    Navigator.pop(context);
                  });
                },
                trailing: Image.asset('assets/nav1.png'),
              ),
              Divider(thickness: 1, color: Colors.grey),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                selected: _selectedIndex == 1,
                title: Text(
                  _screenName[1],
                  style: TextStyle(
                    color:
                        _selectedIndex == 1 ? Colors.limeAccent : Colors.white,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                    Navigator.pop(context);
                  });
                },
                trailing: Image.asset('assets/nav2.png'),
              ),
              Divider(thickness: 1, color: Colors.grey),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                selected: _selectedIndex == 2,
                title: Text(
                  _screenName[2],
                  style: TextStyle(
                    color:
                        _selectedIndex == 2 ? Colors.limeAccent : Colors.white,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 2;
                    Navigator.pop(context);
                  });
                },
                trailing: Image.asset('assets/pending.png'),
              ),
              Divider(thickness: 1, color: Colors.grey),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                selected: _selectedIndex == 3,
                title: Text(
                  _screenName[3],
                  style: TextStyle(
                    color:
                        _selectedIndex == 3 ? Colors.limeAccent : Colors.white,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 3;
                    Navigator.pop(context);
                  });
                },
                trailing: Image.asset('assets/exam.png'),
              ),
              Divider(thickness: 1, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
