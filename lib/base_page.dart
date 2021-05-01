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
          leading: Icon(Icons.account_balance_wallet_rounded ),
          title: Text("Dompet"), backgroundColor: Colors.teal[700]),
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
              Icons.account_balance_wallet_outlined,
              color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
            ),
            title: Text("Home",
                style: TextStyle(
                    color: _selectedIndex == 0 ? Colors.blue : Colors.grey)),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.calculate_outlined,
                color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
              ),
              title: Text("Budget",
                  style: TextStyle(
                      color: _selectedIndex == 1 ? Colors.blue : Colors.grey))),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.monetization_on_outlined,
                color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
              ),
              title: Text("Debt",
                  style: TextStyle(
                      color: _selectedIndex == 2 ? Colors.blue : Colors.grey))),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.insert_chart_outlined_rounded,
                color: _selectedIndex == 3 ? Colors.blue : Colors.grey,
              ),
              title: Text("Graph",
                  style: TextStyle(
                      color: _selectedIndex == 3 ? Colors.blue : Colors.grey))),
        ],
      ),
    );
  }
}
