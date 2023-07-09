import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reprovaca/pages/alertas_vacas.dart';
import 'package:reprovaca/pages/list_vacas.dart';
import 'package:reprovaca/main.dart';
import '../forms/login_page.dart';

String email = LoginPage.email;

class HamburgerMenu extends StatefulWidget {
  const HamburgerMenu({Key? key}) : super(key: key);

  @override
  _HamburgerMenuState createState() => _HamburgerMenuState();
}

class _HamburgerMenuState extends State<HamburgerMenu> {
  String? userName;

  @override
  void initState() {
    super.initState();
    fetchUserName(LoginPage.userId);
  }

  Future<void> fetchUserName(int? userId) async {
    final url = 'http://10.0.0.122:8000/usuario/$userId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final nome = jsonData['nome'];
      setState(() {
        userName = nome;
      });
    } else {
      throw Exception('Falha ao buscar o nome do usuário.');
    }
  }

  void _logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 4, 78, 43),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: Icon(
                      Icons.close,
                      size: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, right: 10.0),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('imagens/fa.jpg'),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 98.0, right: 20.0),
                              child: Text(
                                userName ?? '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Gerenciar clientes'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Alertas'),
            onTap: () {
              Navigator.pushNamed(context, '/alert');
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Vacas'),
            onTap: () {
              Navigator.pushNamed(context, '/list');
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Sair'),
            onTap: () {
              _logout(context);
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
