import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:reprovaca/forms/login_page.dart';

class ListPrenhaPage extends StatefulWidget {
  @override
  _ListPrenhaPageState createState() => _ListPrenhaPageState();
}

class _ListPrenhaPageState extends State<ListPrenhaPage> {
  List<VacaPrenha> vacasPrenhas = [];

  @override
  void initState() {
    super.initState();
    getPrenhas();
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

    Uri apiUrl = Uri.parse(
        'http://10.0.0.122:8000/Prenha/?usuario=${LoginPage.userId}');

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
                  child:  Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Erro: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 4, 68, 30),
        title: Text('Vacas Prenhas'),
      ),
      body: ListView.builder(
        itemCount: vacasPrenhas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${vacasPrenhas[index].nome_vaca} - ${vacasPrenhas[index].numero_vaca}'),
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
    );
  }
}

class VacaPrenha {
  final int id;
  final String? nome_vaca;
  final String? numero_vaca;
  final String? dataNascimento;

  VacaPrenha({
    required this.id,
    this.nome_vaca,
    this.numero_vaca,
    this.dataNascimento,
  });

  factory VacaPrenha.fromJson(Map<String, dynamic> json) {
    return VacaPrenha(
      id: json['id'],
      nome_vaca: json['nome_vaca'],
      numero_vaca: json['numero_v'],
      dataNascimento: json['data_nascimento_B'],
    );
  }
}
