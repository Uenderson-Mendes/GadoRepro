import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  static String email = '';
  static int? userId; // Variável para armazenar o ID do usuário

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  Future<void> _performLogin() async {
    if (!mounted) {
      return; // Check if the widget is still mounted
    }

    String email = _emailController.text.trim();
    String senha = _senhaController.text.trim();

    // Replace 'http://192.168.66.32:8000' with the appropriate API URL
    Uri apiUrl = Uri.parse('http://10.0.1.5:8000/usuario/');
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      List<dynamic> users = json.decode(response.body);
      bool isAuthenticated = false;

      for (var user in users) {
        if (user['email'] == email && user['senha'] == senha) {
          isAuthenticated = true;
          LoginPage.userId = user['id']; // Armazena o ID do usuário na variável userId
          break;
        }
      }

      if (isAuthenticated) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Login realizado com sucesso!',
              style: TextStyle(color: Colors.green),
            ),
            duration: Duration(seconds: 2),
          ),
        );

        LoginPage.email = email; // Atribui o valor de 'nome' à variável estática na classe LoginPage
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erro de Login'),
              content: Text('Usuário ou senha inválidos.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
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
            title: Text('Erro de Login'),
            content: Text('Não foi possível acessar a API.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _logout() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 50.0),
              Center(
                child: Text(
                  'ReproGado',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              CircleAvatar(
                backgroundImage: AssetImage('imagens/fa.jpg'),
                radius: 100.0,
              ),
              const SizedBox(height: 15.0),
              Center(
                child: Text(
                  'Conecte-se',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 70.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Color.fromARGB(177, 8, 72, 27)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Color.fromARGB(177, 8, 72, 27)),
                  ),
                ),
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O campo usuário é obrigatório.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18.0),
              TextFormField(
                controller: _senhaController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Color.fromARGB(255, 5, 67, 24)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Color.fromARGB(255, 5, 67, 24)),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                    child: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: !_passwordVisible,
              ),
              const SizedBox(height: 34.0),
              ElevatedButton(
                onPressed: _performLogin,
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 4, 71, 26),
                  onPrimary: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Login'),
              ),
              const SizedBox(height: 26.0),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/cadastr'); // Navigates to the registration page
                },
                child: Text(
                  "Não tem uma conta? Crie uma",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
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
