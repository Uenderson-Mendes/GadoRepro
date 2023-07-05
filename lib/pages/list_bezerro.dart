import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../components/hamburguer_botton.dart';
import '../forms/login_page.dart';

class ListBezerro extends StatefulWidget {
  @override
  _ListBezerroState createState() => _ListBezerroState();
}

class _ListBezerroState extends State<ListBezerro> {
  int _selectedIndex = 0;
  List<BottomNavigationBarItem> _bottomBarItems =
      BottomNavigationItems.getItems();
  Color darkBlue = Color.fromARGB(255, 4, 78, 43);
  List<Map<String, dynamic>> bezerros = [];
  final apiUrl = 'http://10.0.0.122:8000/bezerros/';
  int? userId;

  @override
  void initState() {
    super.initState();
    userId = LoginPage.userId;
    fetchBezerros();
  }

  Future<void> fetchBezerros() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(json.decode(response.body));

        // Filter bezerros by "usuario" field
        List<Map<String, dynamic>> filteredBezerros = data
            .where(
                (bezerro) => bezerro['usuario'].toString() == userId.toString())
            .toList();

        setState(() {
          bezerros = filteredBezerros;
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

  Future<void> editarBezerro(Map<String, dynamic> bezerro) async {
    TextEditingController nome_bezerroController = TextEditingController();
    TextEditingController numero_bController = TextEditingController();
    TextEditingController racaController = TextEditingController();
    TextEditingController loteController = TextEditingController();
    TextEditingController origemController = TextEditingController();
    TextEditingController data_nascimentoController = TextEditingController();

    nome_bezerroController.text = bezerro['nome_bezerro'] ?? '';
    numero_bController.text = bezerro['numero_b'] ?? '';
    racaController.text = bezerro['raca'] ?? '';
    loteController.text = bezerro['lote'] ?? '';
    origemController.text = bezerro['origem'] ?? '';
    data_nascimentoController.text = bezerro['data_nascimento'] ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Bezerro'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: nome_bezerroController,
                  decoration:
                      const InputDecoration(labelText: 'Nome do Bezerro'),
                ),
                TextField(
                  controller: numero_bController,
                  decoration: const InputDecoration(labelText: 'Número B'),
                ),
                TextField(
                  controller: racaController,
                  decoration: const InputDecoration(labelText: 'Raça'),
                ),
                TextField(
                  controller: loteController,
                  decoration: const InputDecoration(labelText: 'Lote'),
                ),
                TextField(
                  controller: origemController,
                  decoration: const InputDecoration(labelText: 'Origem'),
                ),
                TextField(
                  controller: data_nascimentoController,
                  decoration:
                      const InputDecoration(labelText: 'Data de Nascimento'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Save the changes
                bezerro['nome_bezerro'] = nome_bezerroController.text;
                bezerro['numero_b'] = numero_bController.text;
                bezerro['raca'] = racaController.text;
                bezerro['lote'] = loteController.text;
                bezerro['origem'] = origemController.text;
                bezerro['data_nascimento'] = data_nascimentoController.text;
                bezerro['usuario'] = userId
                    .toString(); // Atribuir o usuário presente em userId

                final response = await http.put(
                  Uri.parse('$apiUrl${bezerro['id']}/'),
                  body: json.encode(bezerro),
                  headers: {'Content-Type': 'application/json'},
                );

                if (response.statusCode == 200) {
                  fetchBezerros();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Sucesso'),
                        content: const Text('Alterações salvas com sucesso.'),
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
                        content: const Text(
                            'Ocorreu um erro ao salvar as alterações.'),
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

                Navigator.pop(context);
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
        title: const Text('Bezerros'),
        backgroundColor: darkBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: bezerros.isEmpty
            ? Center(
                child: Text(
                  'Não há bezerros disponíveis para este usuário.',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: bezerros.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> bezerro = bezerros[index];
                  return Card(
                    child: ListTile(
                      title: Text(bezerro['nome_bezerro']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Número B: ${bezerro['numero_b']}'),
                          Text('Raça: ${bezerro['raca']}'),
                          Text(
                              'Lote: ${bezerro['lote'] ?? 'N/A'}'), // Informação adicional: Lote
                          Text(
                              'Origem: ${bezerro['origem'] ?? 'N/A'}'), // Informação adicional: Origem
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Color.fromARGB(255, 7, 87, 167), size: 35),
                            onPressed: () => editarBezerro(bezerro),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Color.fromARGB(255, 255, 0, 0), size: 35),
                            onPressed: () => excluirBezerro(bezerro['id']),
                          ),
                        ],
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
