import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../components/hamburguer_botton.dart';

class ListBezerro extends StatefulWidget {
  @override
  _ListBezerroState createState() => _ListBezerroState();
}

class _ListBezerroState extends State<ListBezerro> {
  int _selectedIndex = 0;
  List<BottomNavigationBarItem> _bottomBarItems = BottomNavigationItems.getItems();
  Color darkBlue = Color.fromARGB(255, 4, 78, 43);
  List<Map<String, dynamic>> bezerros = [];
  final apiUrl = 'http://10.0.0.122:8000/bezerros/';

  @override
  void initState() {
    super.initState();
    fetchBezerros();
  }

  Future<void> fetchBezerros() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          bezerros = data.cast<Map<String, dynamic>>();
        });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erro'),
              content: const Text('Ocorreu um erro ao obter os bezerros.'),
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

  Future<void> excluirBezerro(int id) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl$id/'));

      if (response.statusCode == 204) {
        fetchBezerros();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sucesso'),
              content: const Text('Bezerro excluído com sucesso.'),
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
              content: const Text('Ocorreu um erro ao excluir o bezerro.'),
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

  void editarBezerro(Map<String, dynamic> bezerro) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController nome_bezerroController = TextEditingController(text: bezerro['nome_bezerro'] ?? '');
        TextEditingController numero_bController = TextEditingController(text: bezerro['numero_b'] ?? '');
        TextEditingController racaController = TextEditingController(text: bezerro['raca'] ?? '');
        TextEditingController loteController = TextEditingController(text: bezerro['lote'] ?? '');
        TextEditingController origemController = TextEditingController(text: bezerro['origem'] ?? '');
        TextEditingController dataNascimentoController = TextEditingController(text: bezerro['data_nascimento'] ?? '');
        TextEditingController usuarioController = TextEditingController(text: bezerro['usuario'].toString());

        return AlertDialog(
          title: const Text('Editar Bezerro'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nome_bezerroController,
                  decoration: InputDecoration(labelText: 'Nome'),
                ),
                TextFormField(
                  controller: numero_bController,
                  decoration: InputDecoration(labelText: 'Número'),
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
                  controller: origemController,
                  decoration: InputDecoration(labelText: 'Origem'),
                ),
                TextFormField(
                  controller: dataNascimentoController,
                  decoration: InputDecoration(labelText: 'Data de Nascimento'),
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
                    'nome_bezerro': nome_bezerroController.text,
                    'numero_b': numero_bController.text,
                    'raca': racaController.text,
                    'lote': loteController.text,
                    'origem': origemController.text,
                    'data_nascimento': dataNascimentoController.text,
                    'usuario': usuarioController.text,
                  };

                  final response = await http.put(
                    Uri.parse('$apiUrl${bezerro['id']}/'),
                    headers: headers,
                    body: json.encode(requestBody),
                  );

                  if (response.statusCode == 200) {
                    Navigator.pop(context);
                    fetchBezerros();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Sucesso'),
                          content: const Text('Bezerro atualizado com sucesso.'),
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
                          content: const Text('Ocorreu um erro ao editar o bezerro.'),
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
        title: Text('Lista de Bezerros'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: bezerros.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Card(
                color: Color.fromARGB(255, 231, 228, 228),
                elevation: 3,
                child: ListTile(
                  title: Text(bezerros[index]['nome_bezerro']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Número: ${bezerros[index]['nome_bezerro']}'),
                      Text('Raça: ${bezerros[index]['raca']}'),
                      Text('Lote: ${bezerros[index]['lote']}'),
                      Text('Origem: ${bezerros[index]['origem']}'),
                    ],
                  ),
                  trailing: Wrap(
                    runSpacing: 8,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit,color: Color.fromARGB(255, 7, 87, 167),),
                        onPressed: () {
                          editarBezerro(bezerros[index]);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color:Color.fromARGB(255, 255, 0, 0),),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirmar'),
                                content: const Text('Deseja excluir este bezerro?'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancelar'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      excluirBezerro(bezerros[index]['id'] as int);
                                    },
                                    child: const Text('Excluir'),
                                  ),
                                ],
                              );
                            },
                          );
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

   
