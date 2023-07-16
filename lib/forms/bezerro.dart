import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import 'login_page.dart';
int? userId = LoginPage.userId;

class BezzerrosAdd extends StatefulWidget {
  @override
  _BezzerrosAddState createState() => _BezzerrosAddState();
}

class _BezzerrosAddState extends State<BezzerrosAdd> {
  TextEditingController nomeBezzerroController = TextEditingController();
  TextEditingController idBezzerroController = TextEditingController();
  TextEditingController racaController = TextEditingController();
  TextEditingController loteBezzerrosController = TextEditingController();
  TextEditingController origemController = TextEditingController();
  TextEditingController usuarioController = TextEditingController();
  late DateTime selectedDate;
Future<void> adicionarBezzerro() async {
  Uri apiUrl = Uri.parse('http://10.0.1.5:8000/bezerros/');

  // Formate a data de nascimento para o formato esperado pelo Django
  String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

  // Crie um mapa com os dados do bezzerro
  Map<String, dynamic> bezzerroData = {
    'nome_bezerro': nomeBezzerroController.text,
    'numero_b': idBezzerroController.text,
    'raca': racaController.text,
    'lote': loteBezzerrosController.text,
    'origem': origemController.text,
    'data_nascimento': formattedDate,
    'usuario': userId.toString(),
  };

  try {
    final response = await http.post(
      apiUrl,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(bezzerroData),
    );

    if (response.statusCode == 201) {
      // Bezzerro adicionado com sucesso
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sucesso'),
            content: const Text('Bezzerro adicionado com sucesso.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/listBezerro');
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Ocorreu um erro ao adicionar o bezzerro
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erro'),
            content: const Text('Ocorreu um erro ao adicionar o bezzerro.'),
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
        title: Text('Adicionar Bezzerro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
          children: [
  TextField(
    controller: nomeBezzerroController,
    decoration: InputDecoration(labelText: 'Nome do bezzerro'),
  ),
  TextField(
    controller: idBezzerroController,
    decoration: InputDecoration(labelText: 'Número do bezzerro'),
  ),
  TextField(
    controller: racaController,
    decoration: InputDecoration(labelText: 'Raça'),
  ),
  TextField(
    controller: loteBezzerrosController,
    decoration: InputDecoration(labelText: 'Lote de bezzerros'),
  ),
  TextField(
    controller: origemController,
    decoration: InputDecoration(labelText: 'Origem'),
  ),
  DateTimeFormField(
    decoration: InputDecoration(
      labelText: 'Data de nascimento',
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
      onPressed: () {
        adicionarBezzerro();
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
