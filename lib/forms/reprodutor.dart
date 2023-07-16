import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'login_page.dart';
int? userId = LoginPage.userId;
class AddRepro extends StatefulWidget {
  @override
  _AddReproState createState() => _AddReproState();
}

class _AddReproState extends State<AddRepro> {
  TextEditingController nomeReprodutorController = TextEditingController();
  TextEditingController numeroRController = TextEditingController();
  TextEditingController racaController = TextEditingController();
  TextEditingController loteController = TextEditingController();
  TextEditingController origemController = TextEditingController();
  TextEditingController usuarioController = TextEditingController();
  late DateTime selectedDate;

  Future<void> adicionarReprodutor() async {
    Uri apiUrl = Uri.parse('http://10.0.1.5:8000/reprodutor/');

    // Formate a data de nascimento para o formato esperado pelo Django
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    // Crie um mapa com os dados do reprodutor
    Map<String, dynamic> reprodutorData = {
      'nome_reprodutor': nomeReprodutorController.text,
      'numero_r': numeroRController.text,
      'raca': racaController.text,
      'lote': loteController.text,
      'origem': origemController.text,
      'data_nascimento': formattedDate,
      'usuario': userId.toString(),
    };

    try {
      final response = await http.post(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(reprodutorData),
      );

      if (response.statusCode == 201) {
        // Reprodutor adicionado com sucesso
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sucesso'),
              content: const Text('Reprodutor adicionado com sucesso.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/listrepro');
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Ocorreu um erro ao adicionar o reprodutor
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erro'),
              content: const Text('Ocorreu um erro ao adicionar o reprodutor.'),
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
        title: Text('Adicionar Reprodutor'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: nomeReprodutorController,
                decoration: InputDecoration(labelText: 'Nome do reprodutor'),
              ),
              TextField(
                controller: numeroRController,
                decoration: InputDecoration(labelText: 'Número R'),
              ),
              TextField(
                controller: racaController,
                decoration: InputDecoration(labelText: 'Raça'),
              ),
              TextField(
                controller: loteController,
                decoration: InputDecoration(labelText: 'Lote'),
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
              TextField(
                controller: origemController,
                decoration: InputDecoration(labelText: 'Origem'),
              ),
            
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    adicionarReprodutor();
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
