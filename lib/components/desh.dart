import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../forms/bezerro.dart';

class DeshContainer extends StatefulWidget {
  final int? userId;

  DeshContainer({Key? key, this.userId}) : super(key: key);

  @override
  _DeshContainerState createState() => _DeshContainerState();
}

class _DeshContainerState extends State<DeshContainer> {
  late final PageController _pageController;
  late final Timer _timer;
  int _currentPage = 0;

  int totalInseminadas = 0;
  int totalCows = 0;
  int totalParida = 0;
  int totalSolteira = 0;
  int totalNoCio = 0;
  int totalPrenha = 0;

  List<String> containerTitles = [
    'Vacas Inseminadas',
    'Vacas Paridas',
    'Vacas Solteiras',
    'Vacas no Cio',
    'Vacas Prenhas',
  ];
  List<String> containerImages = [
    'imagens/solteira.jpg',
    'imagens/fa.jpg',
    'imagens/solteira.jpg',
    'imagens/fa.jpg',
    'imagens/fa.jpg',
  ];
  List<int> containerValues = [0, 0, 0, 0, 0];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(Duration(seconds: 3), (_) {
      if (_currentPage < 4) {
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
    fetchCowsData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  Future<void> fetchCowsData() async {
  final url = 'http://10.0.0.122:8000/vacas/?usuario=$userId'; // Replace with the correct URL
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    try {
      final data = jsonDecode(response.body);
      if (data is List) {
        final cows = data as List;
        int newTotalInseminadas = 0;
        int newTotalParida = 0;
        int newTotalSolteira = 0;
        int newTotalNoCio = 0;
        int newTotalPrenha = 0;

        for (final cow in cows) {
          final status = cow['statu'];
          switch (status) {
            case 'inseminada':
              newTotalInseminadas++;
              break;
            case 'parida':
              newTotalParida++;
              break;
            case 'solteira':
              newTotalSolteira++;
              break;
            case 'no_cio':
              newTotalNoCio++;
              break;
            case 'prenha':
              newTotalPrenha++;
              break;
          }
        }

        setState(() {
          containerValues[0] = newTotalInseminadas;
          containerValues[1] = newTotalParida;
          containerValues[2] = newTotalSolteira;
          containerValues[3] = newTotalNoCio;
          containerValues[4] = newTotalPrenha;
        });
      } else {
        print('Invalid response format: $data');
      }
    } catch (e) {
      print('Error decoding JSON response: $e');
    }
  } else {
    print('Failed to fetch cow data. Status code: ${response.statusCode}');
  }
}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30.0),
      height: 180.0,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        controller: _pageController,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1.0;
              if (_pageController.position.haveDimensions) {
                value = _pageController.page! - index;
                value = (1 - (value.abs() * 0.2)).clamp(0.0, 1.0);
              }
              return Transform.scale(
                scale: Curves.easeInOut.transform(value),
                child: child,
              );
            },
            child: Container(
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
                      containerTitles[index],
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
                              '${containerValues[index]}',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            containerImages[index],
                            fit: BoxFit.cover,
                            width: 130.0,
                            height: 100.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
