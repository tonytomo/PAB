import 'package:flutter/material.dart';
import 'package:pab_dompet/budget_page.dart';
import 'package:pab_dompet/debt_page.dart';
import 'package:pab_dompet/graph_page.dart';
import 'package:pab_dompet/home_page.dart';

class Base extends StatefulWidget {
  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
  PageController _pageController = PageController();
  List<Widget> _screen = [MainPage(), Budget(), Debt(), Graph()];

  int _selectedIndex = 0;

  _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("RipCoding"), backgroundColor: Colors.lightBlue[900]),
      body: PageView(
        controller: _pageController,
        children: _screen,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
            ),
            title: Text("Home",
                style: TextStyle(
                    color: _selectedIndex == 0 ? Colors.blue : Colors.grey)),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
              ),
              title: Text("Search",
                  style: TextStyle(
                      color: _selectedIndex == 1 ? Colors.blue : Colors.grey))),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
              ),
              title: Text("Cart",
                  style: TextStyle(
                      color: _selectedIndex == 2 ? Colors.blue : Colors.grey))),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                color: _selectedIndex == 3 ? Colors.blue : Colors.grey,
              ),
              title: Text("My Account",
                  style: TextStyle(
                      color: _selectedIndex == 3 ? Colors.blue : Colors.grey))),
        ],
      ),
    );
  }
}
