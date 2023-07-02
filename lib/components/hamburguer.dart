import 'dart:io';
import 'package:flutter/material.dart';
import 'package:reprovaca/pages/alertas_vacas.dart';
import 'package:reprovaca/pages/list_vacas.dart';
import 'package:reprovaca/main.dart';

import '../forms/login_page.dart';
String nome = LoginPage.nome; 
class HamburgerMenu extends StatelessWidget {
   const HamburgerMenu({Key? key}) : super(key: key);

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
                              padding: const EdgeInsets.only(
                                  top: 98.0, right: 20.0),
                              child: Flexible(
                                child: Text(
                                  '${LoginPage.nome}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
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
