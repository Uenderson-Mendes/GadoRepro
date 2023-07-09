import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../forms/login_page.dart';
import '../components/hamburguer_botton.dart';

class ListRepro extends StatefulWidget {
  @override
  _ListReproState createState() => _ListReproState();
}

class _ListReproState extends State<ListRepro> {
   int _selectedIndex = 0;
  List<BottomNavigationBarItem> _bottomBarItems = BottomNavigationItems.getItems();
  Color darkBlue = Color.fromARGB(255, 4, 78, 43);
  List<Map<String, dynamic>> reprodutores = [];
  final apiUrl = 'http://10.0.0.122:8000/reprodutor/';
 int? userId;

  @override
  void initState() {
    super.initState();
    userId = LoginPage.userId;
    fetchReprodutores();
  }

  Future<void> fetchReprodutores() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(json.decode(response.body));

        // Filter bezerros by "usuario" field
        List<Map<String, dynamic>> filteredBezerros = data
            .where(
                (reprodutor) => reprodutor['usuario'].toString() == userId.toString())
            .toList();

        setState(() {
          reprodutores = filteredBezerros;
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

  Future<void> excluirReprodutor(int id) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl$id/'));

      if (response.statusCode == 204) {
        fetchReprodutores();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sucesso'),
              content: const Text('Reprodutor excluído com sucesso.'),
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
              content: const Text('Ocorreu um erro ao excluir o reprodutor.'),
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

  void editarReprodutor(Map<String, dynamic> reprodutor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController nomeReprodutorController =
            TextEditingController(text: reprodutor['nome_reprodutor'] ?? '');
        TextEditingController numeroRController =
            TextEditingController(text: reprodutor['numero_r'] ?? '');
        TextEditingController racaController =
            TextEditingController(text: reprodutor['raca'] ?? '');
        TextEditingController loteController =
            TextEditingController(text: reprodutor['lote'] ?? '');
        TextEditingController origemController =
            TextEditingController(text: reprodutor['origem'] ?? '');
        TextEditingController dataNascimentoController =
            TextEditingController(text: reprodutor['data_nascimento'] ?? '');
      

        return AlertDialog(
          title: const Text('Editar Reprodutor'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nomeReprodutorController,
                  decoration: InputDecoration(labelText: 'Nome reprodutor'),
                ),
                TextFormField(
                  controller: numeroRController,
                  decoration: InputDecoration(labelText: 'Número R'),
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
                  controller: dataNascimentoController,
                  decoration: InputDecoration(labelText: 'Data de nascimento'),
                ),
                TextFormField(
                  controller: origemController,
                  decoration: InputDecoration(labelText: 'Origem'),
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
                    'nome_reprodutor': nomeReprodutorController.text,
                    'numero_r': numeroRController.text,
                    'raca': racaController.text,
                    'lote': loteController.text,
                    'data_nascimento': dataNascimentoController.text,
                    'origem': origemController.text,
                    
                  };

                  final response = await http.put(
                    Uri.parse('$apiUrl${reprodutor['id']}/'),
                    headers: headers,
                    body: json.encode(requestBody),
                  );

                  if (response.statusCode == 200) {
                    Navigator.pop(context);
                    fetchReprodutores();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Sucesso'),
                          content: const Text('Reprodutor atualizado com sucesso.'),
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
                          content: const Text('Ocorreu um erro ao editar o reprodutor.'),
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
      title: Text('Lista de Reprodutores'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: reprodutores.isEmpty
          ? Center(
              child: Text(
                'Não há reprodutores disponíveis.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: reprodutores.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Card(
                    color: Color.fromARGB(255, 231, 228, 228),
                    elevation: 3,
                    child: ListTile(
                      title: Text(reprodutores[index]['nome_reprodutor']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Número R: ${reprodutores[index]['numero_r']}'),
                          Text('Raça: ${reprodutores[index]['raca']}'),
                          Text('Lote: ${reprodutores[index]['lote']}'),
                          Text('Data de Nascimento: ${reprodutores[index]['data_nascimento']}'),
                          Text('Origem: ${reprodutores[index]['origem']}'),
                        ],
                      ),
                      trailing: Wrap(
                        runSpacing: 8,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Color.fromARGB(255, 7, 87, 167), size: 35),
                            onPressed: () {
                              editarReprodutor(reprodutores[index]);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Color.fromARGB(255, 255, 0, 0), size: 35),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirmar'),
                                    content: const Text('Deseja excluir este reprodutor?'),
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
                                          excluirReprodutor(reprodutores[index]['id'] as int);
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
            ),),
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

//A classe "ListRepro" foi atualizada para listar e manipular reprodutores. Os campos específicos do reprodutor fornecidos anteriormente foram adicionados ao formulário de edição.
