import 'package:flutter/material.dart';
import 'package:reprovaca/pages/alertas_vacas.dart';
import 'package:reprovaca/pages/list_vacas.dart';
import 'package:reprovaca/pages/add_vacas.dart';
import 'forms/bezerro.dart';
import 'forms/login_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reprovaca/home.dart';
import 'package:reprovaca/forms/creat_cadstro.dart';
import 'package:reprovaca/pages/list_bezerro.dart';
import 'package:reprovaca/pages/list_bezerro.dart';
import 'package:reprovaca/pages/list_reprodutor.dart';

import 'forms/vaca.dart';

const Color darkBlue = Color.fromARGB(255, 4, 78, 43);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash', // Set the initial route to the splash screen
      routes: {
        '/splash': (context) => SplashScreen(), // Create a new route for the splash screen
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(title: '',),
        '/list': (context) => ListVacs(),
        '/alert': (context) => AlertasVacas(),
        '/add': (context) => AddVacas(),
        '/cadastr': (context) => FormsPage(),
        '/addVacas': (context) => VacasAdd(),
        '/listBezerro': (context) => ListBezerro(),
        '/listrepro': (context) => ListRepro(),

      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin(); // Navigate to the login screen after a delay
  }

  void _navigateToLogin() {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Bem-vindo',
        style: TextStyle(
          color: const Color.fromARGB(255, 0, 0, 0),
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 86),
      Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: darkBlue,
        ),
        child: ClipOval(
          child: Image.asset(
            'imagens/fa.jpg', // Substitua pelo caminho para sua imagem de splash
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(height: 16),
      Text(
        'ReproGado',
        style: TextStyle(
          color: const Color.fromARGB(255, 0, 0, 0),
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
),

    );
  }
}
