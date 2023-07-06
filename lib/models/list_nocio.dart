import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../components/hamburguer_botton.dart';
import '../forms/login_page.dart';


class List_nocio extends StatefulWidget {
  static int? totalSolteira;

  @override
  _List_nocioState createState() => _List_nocioState();
}

class _List_nocioState extends State<List_nocio> {
  int _selectedIndex = 0;
  List<BottomNavigationBarItem> _bottomBarItems = BottomNavigationItems.getItems();
  Color darkBlue = Color.fromARGB(255, 4, 78, 43);
  List<Map<String, dynamic>> vacas = [];
  final apiUrl = 'http://10.0.0.122:8000/vacas/';
  int? userId;
  int totalSolteira = 0;

  @override
  void initState() {
    super.initState();
    fetchVacas();
  }

  Future<void> fetchVacas() async {
    // Assuming LoginPage.userId is available globally or stored somewhere after login
    userId = LoginPage.userId;

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(json.decode(response.body));

        // Filter vacas by "usuario" field and status "solteiras"
        List<Map<String, dynamic>> filteredVacas = data
            .where((vaca) =>
                vaca['usuario'].toString() == userId.toString() &&
                vaca['statu'] == 'no_cio')
            .toList();

        setState(() {
          vacas = filteredVacas;
          totalSolteira = vacas.length;
        });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erro'),
              content: const Text('Ocorreu um erro ao obter as vacas.'),
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

  Future<void> excluirVaca(int id) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl$id/'));

      if (response.statusCode == 204) {
        fetchVacas();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sucesso'),
              content: const Text('Vaca excluída com sucesso.'),
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
              content: const Text('Ocorreuum erro ao excluir a vaca.'),
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

  void editarVaca(Map<String, dynamic> vaca) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController nomeController =
            TextEditingController(text: vaca['nome_vaca'] ?? '');
        TextEditingController racaController =
            TextEditingController(text: vaca['raca'] ?? '');
        TextEditingController loteController =
            TextEditingController(text: vaca['lote'] ?? '');
        TextEditingController numeroController =
            TextEditingController(text: vaca['numero_v'] ?? '');
        TextEditingController origemController =
            TextEditingController(text: vaca['origem'] ?? '');
        TextEditingController dataNascimentoController =
            TextEditingController(text: vaca['data_nascimento'] ?? '');
        TextEditingController statuController =
            TextEditingController(text: vaca['statu'] ?? '');
        TextEditingController usuarioController =
            TextEditingController(text: vaca['usuario'].toString());

        return AlertDialog(
          title: const Text('Editar Vaca'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nomeController,
                  decoration: InputDecoration(labelText: 'Nome'),
                ),
                TextFormField(
                  controller: racaController,
                  decoration: InputDecoration(labelText: 'Raça'),
                ),
                TextFormField(
                  controller: loteController,
                  decoration: InputDecoration(labelText: 'Lote'),
                ),
                TextFormField(
                  controller: numeroController,
                  decoration: InputDecoration(labelText: 'Número'),
                ),
                TextFormField(
                  controller: origemController,
                  decoration: InputDecoration(labelText: 'Origem'),
                ),
                TextFormField(
                  controller: dataNascimentoController,
                  decoration: InputDecoration(labelText: 'Data de Nascimento'),
                ),
                DropdownButtonFormField<String>(
                  value: statuController.text,
                  decoration: InputDecoration(labelText: 'Status'),
                  items: [
                    DropdownMenuItem<String>(
                      value: 'parida',
                      child: Text('Parida'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'solteira',
                      child: Text('Solteira'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'no_cio',
                      child: Text('No cio'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'inseminada',
                      child: Text('Inseminada'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'prenha',
                      child: Text('Prenha'),
                    ),
                  ],
                  onChanged: (value) {
                    statuController.text = value!;
                  },
                ),
                TextFormField(
                  controller: usuarioController,
                  decoration: InputDecoration(labelText: 'Usuário'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  Map<String, String> headers = {
                    'Content-Type': 'application/json',
                  };

                  Map<String, dynamic> requestBody = {
                    'nome_vaca': nomeController.text,
                    'raca': racaController.text,
                    'lote': loteController.text,
                    'numero_v': numeroController.text,
                    'origem': origemController.text,
                    'data_nascimento': dataNascimentoController.text,
                    'statu': statuController.text,
                    'usuario': usuarioController.text,
                  };

                  final response = await http.put(
                    Uri.parse('$apiUrl${vaca['id']}/'),
                    headers: headers,
                    body: json.encode(requestBody),
                  );

                  if (response.statusCode == 200) {
                    Navigator.pop(context);
                    fetchVacas();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Sucesso'),
                          content: const Text('Vaca atualizada com sucesso.'),
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
                          content: const Text('Ocorreu um erro ao editar a vaca.'),
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
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 52, 23),
        title: Text('Listas Vacas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: vacas.isEmpty
            ? Center(
                child: Text(
                  'Não há vacas disponíveis.',
                  style: TextStyle(fontSize: 18),
                ),
              )
            : ListView.builder(
                itemCount: vacas.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Card(
                      color: Color.fromARGB(255, 231, 228, 228),
                      elevation: 3,
                      child: ListTile(
                        title: Text(vacas[index]['nome_vaca']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Raça: ${vacas[index]['raca']}'),
                            Text('Número: ${vacas[index]['numero_v']}'),
                            Text('Origem: ${vacas[index]['origem']}'),
                            Text('Status: ${vacas[index]['statu'] ?? 'N/A'}'),
                          ],
                        ),
                        trailing: Wrap(
                          runSpacing: 8,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit,
                                  color: Color.fromARGB(255, 7, 87, 167),
                                  size: 35),
                              onPressed: () {
                                editarVaca(vacas[index]);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete,
                                  color: Color.fromARGB(255, 255, 0, 0),
                                  size: 35),
                              onPressed: () {
                                excluirVaca(vacas[index]['id']);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: _bottomBarItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
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
