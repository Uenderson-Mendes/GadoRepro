import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:reprovaca/forms/login_page.dart';
import '../components/hamburguer_botton.dart';

class ListPrenhaPage extends StatefulWidget {
  static var totalVacasPrenhas;

  @override
  _ListPrenhaPageState createState() => _ListPrenhaPageState();
}

class _ListPrenhaPageState extends State<ListPrenhaPage> {
  int _selectedIndex = 0;
  List<BottomNavigationBarItem> _bottomBarItems = BottomNavigationItems.getItems();
  Color darkBlue = Color.fromARGB(255, 4, 78, 43);
  List<VacaPrenha> vacasPrenhas = [];
  int totalVacasPrenhas = 0;
  int? userId;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getPrenhas();
    });
  }

  Future<void> getPrenhas() async {
    if (LoginPage.userId == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erro'),
            content: const Text('Ocorreu um erro ao obter as vacas prenhas.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    Uri apiUrl = Uri.parse('http://10.0.0.122:8000/Prenha/?usuario=${LoginPage.userId}');

    try {
      final response = await http.get(apiUrl, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        List<dynamic> vacasPrenhasData = json.decode(response.body);

        setState(() {
          vacasPrenhas = vacasPrenhasData
              .map<VacaPrenha>((data) => VacaPrenha.fromJson(data))
              .toList();

          totalVacasPrenhas = vacasPrenhas.length;
        });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erro'),
              content: const Text('Ocorreu um erro ao obter as vacas prenhas.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Erro: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erro'),
            content: const Text('Ocorreu um erro ao obter as vacas prenhas.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> updatePrenha(int id, String novoStatus) async {
    Uri apiUrl = Uri.parse('http://10.0.0.122:8000/Prenha/$id/');

    try {
      final response = await http.put(apiUrl,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'status': novoStatus,
          }));

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sucesso'),
              content: const Text('Status atualizado com sucesso.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erro'),
              content: const Text('Ocorreu um erro ao atualizar o status.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Erro: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erro'),
            content: const Text('Ocorreu um erro ao atualizar o status.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 4, 68, 30),
        title: Text('Total Prenhas: ${totalVacasPrenhas ?? 0}'),
      ),
      body: ListView.builder(
        itemCount: vacasPrenhas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${vacasPrenhas[index].nomeVaca} - ${vacasPrenhas[index].numeroVaca}'),
            subtitle: Text(vacasPrenhas[index].dataNascimento ?? ''),
            trailing: ElevatedButton(
              onPressed: () {
                updatePrenha(vacasPrenhas[index].id, 'Novo Status');
              },
              child: Text('Atualizar'),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomBarItems,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 120, 120, 120),
        unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
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

class VacaPrenha {
  final int id;
  final String? nomeVaca;
  final String? numeroVaca;
  final String? dataNascimento;

  VacaPrenha({
    required this.id,
    this.nomeVaca,
    this.numeroVaca,
    this.dataNascimento,
  });

  factory VacaPrenha.fromJson(Map<String, dynamic> json) {
    return VacaPrenha(
      id: json['id'],
      nomeVaca: json['nome_vaca'],
      numeroVaca:json['numero_vaca'],
      dataNascimento: json['data_nascimento_B'],
    );
  }
}
