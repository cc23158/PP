import 'package:flutter/material.dart'; 
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
  bool isLoading = true;
  bool isEditingPassword = false;

  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData(widget.clientId).then((userData) {
      setState(() {
        name = userData['name'];
        email = userData['email'];
        password = userData['password'];
        _passwordController.text = password;
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
        var decodedData = jsonDecode(response.body);

        // Verificar se os campos existem e se não são nulos
        return {
          'name': decodedData['client_name'] ?? 'Nome não disponível',
          'email': decodedData['client_email'] ?? 'Email não disponível',
          'password': decodedData['client_password'] ?? 'Senha não disponível',
        };
      } else {
        throw Exception('Falha ao carregar dados: ${response.statusCode}');
      }
    } catch (e) {
      print("Erro ao buscar dados: $e");
      throw e;
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
                  _buildInfoRow("Senha: ${isEditingPassword ? '' : password}",
                      'password', true),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoRow(String info, String field, bool isPasswordField) {
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
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    info,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
        ),
        if (isPasswordField)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange, // Cor de fundo
              foregroundColor: Colors.white, // Cor do texto
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Bordas arredondadas
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            onPressed: () {
              if (isEditingPassword) {
                _updatePassword();
              } else {
                setState(() {
                  isEditingPassword = true;
                  _passwordController.text = password;
                });
              }
            },
            child: Text(
              isEditingPassword ? "Salvar" : "Alterar",
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
    try {
      final response = await http.put(
        Uri.parse('https://shape-factory-5.onrender.com/client/updatePassword'),
        body: {
          'id': widget.clientId.toString(), // Passando o ID do cliente
          'password': _passwordController.text, // Nova senha
        },
      );

      if (response.statusCode == 200) {
        print("Senha atualizada com sucesso!");
        // Recarregar os dados após atualizar a senha
        setState(() {
          password = _passwordController.text; // Atualiza a senha na UI
          isEditingPassword = false; // Desativa o modo de edição
        });
        getUserData(widget.clientId); // Recarregar dados do usuário
      } else {
        print("Erro ao atualizar a senha: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao fazer a requisição PUT: $e");
    }
  }

  String _getFieldValue(String field) {
    switch (field) {
      case 'name':
        return name;
      case 'email':
        return email;
      case 'password':
        return password;
      default:
        return '';
    }
  }
}
