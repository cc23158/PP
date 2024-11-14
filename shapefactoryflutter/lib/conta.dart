import 'package:flutter/material.dart'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shapefactory/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Conta extends StatefulWidget {
  final int clientId;
  const Conta({required this.clientId, super.key});

  @override
  _ContaState createState() => _ContaState();
}

class _ContaState extends State<Conta> {
  String name = '';
  String email = '';
  String password = '';
  String weight = '';
  bool isLoading = true;
  bool isEditingPassword = false;
  bool isEditingWeight = false;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData(widget.clientId).then((userData) {
      setState(() {
        name = userData['name'];
        email = userData['email'];
        password = userData['password'];
        weight = userData['weight'];
        _passwordController.text = password;
        _weightController.text = weight;
        isLoading = false;
      });
    }).catchError((e) {
      print("Erro ao carregar os dados do usuário: $e");
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<Map<String, dynamic>> getUserData(int clientId) async {
    try {
      final response = await http.get(Uri.parse(
          'https://shape-factory-5.onrender.com/client/getById?clientId=$clientId'));

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);

        print("Dados recebidos da API: $decodedData");

        return {
          'name': decodedData['client_name'] ?? 'Nome não disponível',
          'email': decodedData['client_email'] ?? 'Email não disponível',
          'password': decodedData['client_password'] ?? 'Senha não disponível',
          'weight': decodedData['client_weight']?.toString() ?? 'Peso não disponível',
        };
      } else {
        throw Exception('Falha ao carregar dados: ${response.statusCode}');
      }
    } catch (e) {
      print("Erro ao buscar dados: $e");
      throw Exception("Erro ao se conectar com a API.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Conta",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow("Nome: $name", 'name', false),
                  SizedBox(height: 16),
                  _buildInfoRow("Email: $email", 'email', false),
                  SizedBox(height: 16),
                  _buildInfoRow("Peso: ${isEditingWeight ? '' : weight}", 'weight', false, isWeightField: true),
                  SizedBox(height: 16),
                  _buildInfoRow("Senha: ${isEditingPassword ? '' : password}", 'password', true),
                  const SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                      ),
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.remove('clientId');
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: const Text(
                        "Sair",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoRow(String info, String field, bool isPasswordField, {bool isWeightField = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: isPasswordField && isEditingPassword
              ? TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Nova senha",
                    hintStyle: const TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                  ),
                )
              : isWeightField && isEditingWeight
                  ? TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Novo peso",
                        hintStyle: const TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.orange),
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        info,
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
        ),
        if (isPasswordField || isWeightField)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            onPressed: () {
              if (isPasswordField) {
                if (isEditingPassword) {
                  _updatePassword();
                } else {
                  setState(() {
                    isEditingPassword = true;
                    _passwordController.text = password;
                  });
                }
              } else if (isWeightField) {
                if (isEditingWeight) {
                  _updateWeight();
                } else {
                  setState(() {
                    isEditingWeight = true;
                    _weightController.text = weight;
                  });
                }
              }
            },
            child: Text(
              (isPasswordField ? isEditingPassword : isEditingWeight) ? "Salvar" : "Alterar",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _updatePassword() async {
    if (_passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A senha deve ter pelo menos 6 caracteres'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    try {
      final response = await http.put(
        Uri.parse('https://shape-factory-5.onrender.com/client/updatePassword'),
        body: {
          'id': widget.clientId.toString(),
          'password': _passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Senha atualizada com sucesso!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
        setState(() {
          password = _passwordController.text;
          isEditingPassword = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao atualizar a senha. Tente novamente.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro de conexão. Tente novamente.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _updateWeight() async {
    try {
      final response = await http.put(
        Uri.parse('https://shape-factory-5.onrender.com/client/updateData'),
        body: {
          'id': widget.clientId.toString(),
          'weight': _weightController.text,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Peso atualizado com sucesso!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
        setState(() {
          weight = _weightController.text;
          isEditingWeight = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao atualizar o peso. Tente novamente.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro de conexão. Tente novamente.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
