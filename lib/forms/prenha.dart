import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import 'login_page.dart';

class PrenhaAdd extends StatefulWidget {
  @override
  _PrenhaAddState createState() => _PrenhaAddState();
}

class _PrenhaAddState extends State<PrenhaAdd> {
  TextEditingController dataNascimentoController = TextEditingController();
  late DateTime selectedDate;
  int? selectedVacaId;
  List<Vaca> vacas = [];

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    getVacasPrenhas();
  }

  Future<void> getVacasPrenhas() async {
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
      List<dynamic> vacasData = json.decode(response.body);

      setState(() {
        vacas = vacasData.map((data) => Vaca.fromJson(data)).toList();
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

 Future<void> adicionarPrenha() async {
  if (selectedVacaId == null) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro'),
          content: const Text('Selecione uma vaca.'),
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

  Uri apiUrl = Uri.parse('http://10.0.0.122:8000/Prenha/');

  String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

  String? userId = LoginPage.userId?.toString();

  if (userId == null) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro'),
          content: const Text('Ocorreu um erro ao obter o ID do usuário.'),
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

  Map<String, dynamic> prenhaData = {
    'data_nascimento': formattedDate,
    'usuario': userId,
    'vaca': selectedVacaId?.toString(),
  };

  try {
    final response = await http.post(
      apiUrl,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(prenhaData),
    );

    if (response.statusCode == 201) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sucesso'),
            content: const Text('Prenha adicionada com sucesso.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/listPrenha');
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
            content: const Text('Ocorreu um erro ao adicionar a prenha.'),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 4, 68, 30),
        title: Text('Adicionar Prenha'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  labelText: 'Vaca',
                ),
                value: selectedVacaId,
                items: vacas.map((vaca) {
                  return DropdownMenuItem<int>(
                    value: vaca.id,
                    child: Text(vaca.nomeVaca ?? ''),
                  );
                }).toList(),
                onChanged: (int? value) {
                  setState(() {
                    selectedVacaId = value;
                  });
                },
              ),
              DateTimeFormField(
                decoration: InputDecoration(
                  labelText: 'Data de Nascimento',
                ),
                dateFormat: DateFormat('yyyy-MM-dd'),
                onDateSelected: (DateTime value) {
                  setState(() {
                    selectedDate = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: adicionarPrenha,
                  child: Text('Adicionar'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Vaca {
  final int id;
  final String? nomeVaca;

  Vaca({
    required this.id,
    required this.nomeVaca,
  });

  factory Vaca.fromJson(Map<String, dynamic> json) {
    return Vaca(
      id: json['id'],
      nomeVaca: json['nome_vaca'],
    );
  }
}
