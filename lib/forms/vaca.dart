import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:reprovaca/forms/login_page.dart';
import 'package:reprovaca/forms/prenha.dart';
import 'login_page.dart';

int? userId = LoginPage.userId;

class VacasAdd extends StatefulWidget {
   static int? vacaId;
  @override
  _VacasAddState createState() => _VacasAddState();
}

class _VacasAddState extends State<VacasAdd> {
  TextEditingController loteVacasController = TextEditingController();
  TextEditingController nomeVacaController = TextEditingController();
  TextEditingController racaController = TextEditingController();
  TextEditingController numeroVacaController = TextEditingController();
  TextEditingController origemController = TextEditingController();
  TextEditingController usuarioController = TextEditingController();
  late DateTime selectedDate;
  String? selectedStatus;
  List<Map<String, String>> statusChoices = [
    {
      "value": "parida",
      "display_name": "Parida",
    },
    {
      "value": "solteira",
      "display_name": "Solteira",
    },
    {
      "value": "no_cio",
      "display_name": "No cio",
    },
    {
      "value": "inseminada",
      "display_name": "Inseminada",
    },
    {
      "value": "prenha",
      "display_name": "Prenha",
    },
  ];

  int? createdVacaId;
  int? vacaId;

  Future<Map<String, dynamic>> fetchUserData(String name, String password, String cpf) async {
    Uri apiUrl = Uri.parse('http://10.0.1.5:8000/usuario/?name=$name&password=$password&cpf=$cpf');

    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        Map<String, dynamic> userData = json.decode(response.body);

        return userData;
      } else {
        throw Exception('Failed to fetch user data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<void> adicionarVaca() async {
    Uri apiUrl = Uri.parse('http://10.0.1.5:8000/vacas/');

    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    String nome = usuarioController.text;

    Map<String, dynamic> vacaData = {
      'nome_vaca': nomeVacaController.text,
      'raca': racaController.text,
      'lote': loteVacasController.text,
      'numero_v': numeroVacaController.text,
      'origem': origemController.text,
      'data_nascimento': formattedDate,
      'statu': selectedStatus,
      'usuario': userId.toString(),
    };

    try {
      final response = await http.post(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(vacaData),
      );

      if (response.statusCode == 201) {
        createdVacaId = json.decode(response.body)['id'];

    if (selectedStatus == "prenha" && createdVacaId != null) {
  setState(() {
    vacaId = createdVacaId;
  });
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PrenhaAdd(vacaId: vacaId),
    ),
  );
}
 else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Sucesso'),
                content: const Text('Vaca adicionada com sucesso.'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/list');
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erro'),
              content: const Text('Ocorreu um erro ao adicionar a vaca.'),
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erro'),
            content: const Text('Ocorreu um erro ao adicionar a vaca.'),
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
      print('Erro: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 4, 68, 30),
        title: Text('Adicionar Vaca'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: nomeVacaController,
                decoration: InputDecoration(labelText: 'NOME'),
              ),
              TextField(
                controller: racaController,
                decoration: InputDecoration(labelText: 'Raça'),
              ),
              TextField(
                controller: loteVacasController,
                decoration: InputDecoration(labelText: 'Lote'),
              ),
              TextField(
                controller: numeroVacaController,
                decoration: InputDecoration(labelText: 'Número'),
              ),
              TextField(
                controller: origemController,
                decoration: InputDecoration(labelText: 'Origem'),
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
              DropdownButtonFormField<String>(
                value: selectedStatus,
                items: statusChoices.map((choice) {
                  return DropdownMenuItem<String>(
                    value: choice['value'],
                    child: Text(choice['display_name']!),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedStatus = value;
                    if (selectedStatus == "prenha") {
                      vacaId = createdVacaId;
                    } else {
                      vacaId = null;
                    }
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Status',
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    adicionarVaca();
                  },
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
