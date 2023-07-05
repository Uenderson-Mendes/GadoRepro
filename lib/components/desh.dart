import 'package:flutter/material.dart';
import 'package:reprovaca/components/desh.dart';
import 'dart:async';
import 'package:reprovaca/models/list_solteira.dart';

import 'desh.dart';

int? totalSolteira = ListSolteiras.totalSolteira;

class DeshContainer extends StatefulWidget {
  const DeshContainer({Key? key}) : super(key: key);

  @override
  _DeshContainerState createState() => _DeshContainerState();
}

class _DeshContainerState extends State<DeshContainer> {
  late final PageController _pageController;
  late final Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(Duration(seconds: 3), (_) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30.0),
      height: 180.0,
      child: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            width: 10.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // downward offset
                ),
              ],
              border: Border.all(
                color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                width: 1.0,
              ),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Vacas Solteiras',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 1.5,
                  width: double.infinity,
                  color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${ListSolteiras.totalSolteira}',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.pets,
                        size: 40.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
       
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            width: 180.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // downward offset
                ),
              ],
              border: Border.all(
                color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                width: 1.0,
              ),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Vacas Solteiras',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 1.5,
                  width: double.infinity,
                  color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '2',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.pets,
                        size: 40.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            width: 180.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // downward offset
                ),
              ],
              border: Border.all(
                color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                width: 1.0,
              ),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Vacas no Cio',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 1.5,
                  width: double.infinity,
                  color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '2',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.pets,
                        size: 40.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            width: 180.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // downward offset
                ),
              ],
              border: Border.all(
                color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                width: 1.0,
              ),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Vacas inceminadas',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 1.5,
                  width: double.infinity,
                  color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '2',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.pets,
                        size: 40.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            width: 180.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // downward offset
                ),
              ],
              border: Border.all(
                color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                width: 1.0,
              ),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Vacas Paridas',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 1.5,
                  width: double.infinity,
                  color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '2',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.pets,
                        size: 40.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
         
        ],
      ),
    );
  }
}


