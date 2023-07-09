import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:reprovaca/forms/vaca.dart';

import 'login_page.dart';


class PrenhaAdd extends StatefulWidget {
  final int? vacaId;

  PrenhaAdd({Key? key, this.vacaId}) : super(key: key);



  @override
  _PrenhaAddState createState() => _PrenhaAddState();
}

class _PrenhaAddState extends State<PrenhaAdd> {
  TextEditingController dataNascimentoController = TextEditingController();
  late DateTime selectedDate;
  int? selectedVacaId;
  List<Vaca> vacas = [];
  final Client _http = Client();
@override
void initState() {
  super.initState();
  selectedDate = DateTime.now();
  selectedVacaId = widget.vacaId ?? null;
  getVacasPrenhas();
}


  Future<void> getVacasPrenhas() async {
    // Código anterior omitido por simplicidade
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
    String? vacaId = widget.vacaId?.toString();

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
      'data_nascimento_B': formattedDate,
      'usuario': userId,
      'vaca_id': vacaId!, // Usar o valor da variável vacaId
    };

    try {
      final response = await _http.post(
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
                    Navigator.pushReplacementNamed(context, '/list');
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
              TextFormField(
                initialValue: widget.vacaId?.toString() ?? '',
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Vaca ID',
                ),
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
