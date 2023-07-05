import 'package:flutter/material.dart';
import 'components/cards_categoria.dart';
import 'components/hamburguer.dart';
import 'pages/list_vacas.dart';
import 'pages/alertas_vacas.dart';
import 'pages/add_vacas.dart';
import 'components/hamburguer_botton.dart';
import 'package:reprovaca/components/desh.dart';



const Color darkBlue = Color.fromARGB(255, 4, 78, 43);

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<BottomNavigationBarItem> _bottomBarItems = BottomNavigationItems.getItems();
  HamburgerMenu hamburguer = HamburgerMenu();
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color.fromARGB(255, 4, 78, 43),
      ),
      drawer: const HamburgerMenu(),
      backgroundColor: Color.fromARGB(255, 4, 78, 43),
      body: Column(
        children: [
          const SizedBox(height: 0),
          DeshContainer(), // Adiciona o novo componente DeshContainer
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 8.0),
              padding: const EdgeInsets.only(top: 8.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 92, 140, 119),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, -3),
                  ),
                ],
                border: Border.all(
                  color: Color.fromARGB(255, 2, 72, 42).withOpacity(0.5),
                  width: 1.0,
                ),
              ),
              child: SingleChildScrollView(
                child: ListView(
                  padding: const EdgeInsets.only(top: 18.0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: CardCategoriar(),
                    ),
                    // Other items you want to add inside the ListView
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomBarItems,
        currentIndex: _selectedIndex,
        onTap: _onBottomBarItemTapped,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: darkBlue,
      ),
    );
  }

  void _onBottomBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.pushNamed(context, '/home');
          break;
        case 1:
          Navigator.pushNamed(context, '/add');
          break;
        case 2:
          Navigator.pushNamed(context, '/alert');
          break;
        case 3:
          Navigator.pushNamed(context, '/list');
          break;
      }
    });
  }
}
