import 'package:flutter/material.dart';
import 'package:reprovaca/components/hamburguer_botton.dart';
import '../forms/bezerro.dart';
import '../main.dart';
import 'package:reprovaca/forms/vaca.dart';
import 'package:reprovaca/forms/reprodutor.dart';

class AddVacas extends StatefulWidget {
  @override
  _AddVacasState createState() => _AddVacasState();
}

class _AddVacasState extends State<AddVacas> {
  int _selectedIndex = 0;
  List<BottomNavigationBarItem> _bottomBarItems = BottomNavigationItems.getItems();
  Color darkBlue = Color.fromARGB(255, 4, 78, 43);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        title: Text('Add Vacas'),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(8.0),
            width: 180.0,
            height: 100.0,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 241, 241, 241),
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: Color.fromARGB(255, 54, 54, 54),
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: TextButton(
             onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VacasAdd()),
              );
            },
              style: ButtonStyle(
                mouseCursor: MaterialStateMouseCursor.clickable,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'imagens/download1.jpg',
                      fit: BoxFit.cover,
                      width: 65.0,
                      height: 65.0,
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Vacas Paridas',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 36.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.all(8.0),
            width: 180.0,
            height: 100.0,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 241, 241, 241),
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: Color.fromARGB(255, 54, 54, 54),
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: TextButton(
             onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BezzerrosAdd()),
              );
            },
              style: ButtonStyle(
                mouseCursor: MaterialStateMouseCursor.clickable,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'imagens/download1.jpg',
                      fit: BoxFit.cover,
                      width: 65.0,
                      height: 65.0,
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Bezerros',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 36.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ],
              ),
            ),
          ),
 SizedBox(height: 10),
           Container(
            margin: const EdgeInsets.all(8.0),
            width: 180.0,
            height: 100.0,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 241, 241, 241),
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: Color.fromARGB(255, 54, 54, 54),
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: TextButton(
             onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddRepro()),
              );
            },
              style: ButtonStyle(
                mouseCursor: MaterialStateMouseCursor.clickable,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'imagens/download1.jpg',
                      fit: BoxFit.cover,
                      width: 65.0,
                      height: 65.0,
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Reprodutores',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 36.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomBarItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: darkBlue,
        onTap: _onBottomBarItemTapped,
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
