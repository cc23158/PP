import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shapefactory/cadastro.dart';
import 'package:shapefactory/centralpage.dart';
import 'package:http/http.dart' as http;
import 'package:shapefactory/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({super.key});
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final controllerEmail = TextEditingController();
  final controllerSenha = TextEditingController();
  var mensagemErro = "";

  @override
  void initState() {
    
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color(0xff000000),
          body: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                    ///***If you have exported images you must have to copy those images in assets/images directory.
                    Image(
                      image: const AssetImage(
                          "assets/images/SF-removebg-preview.png"),
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Login",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 24,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 0),
                      child: TextField(
                        controller: controllerEmail,
                        obscureText: false,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: const BorderSide(
                                color: Color(0xff9e9e9e), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: const BorderSide(
                                color: Color(0xff9e9e9e), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: const BorderSide(
                                color: Color(0xff9e9e9e), width: 1),
                          ),
                          labelText: "Email",
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Color(0xff9e9e9e),
                          ),
                          filled: true,
                          fillColor: const Color(0x00f2f2f3),
                          isDense: false,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                        ),
                      ),
                    ),
                    TextField(
                      controller: controllerSenha,
                      obscureText: true,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(
                              color: Color(0xff9e9e9e), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(
                              color: Color(0xff9e9e9e), width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(
                              color: Color(0xff9e9e9e), width: 1),
                        ),
                        labelText: "Senha",
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          color: Color(0xff9e9e9e),
                        ),
                        filled: true,
                        fillColor: const Color(0x00f2f2f3),
                        isDense: false,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Esqueceu sua senha?",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff9e9e9e),
                          ),
                        ),
                      ),
                    ),
                    Text(mensagemErro,
                        style: const TextStyle(color: Colors.red)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(
                            width: 0,
                          ),
                          Expanded(
                            flex: 1,
                            child: MaterialButton(
                              onPressed: () async {
                                List? cliente = await getClientPassword(
                                    controllerEmail.text);
                                if (cliente != null &&
                                    cliente[0] == controllerSenha.text) {
                                  setState(() {
                                    mensagemErro = "";
                                  });
                                  Home.listaCompleta.clear();
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setBool('isLoggedIn', true);
                                  await prefs.setInt('clientId', cliente[1]);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CentralPage(
                                              clientId: (cliente[1]))));
                                } else {
                                  setState(() {
                                    mensagemErro =
                                        "Usuário ou senha incorretos";
                                  });
                                }
                              },
                              color: Colors.orange,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              padding: const EdgeInsets.all(16),
                              textColor: const Color(0xffffffff),
                              height: 40,
                              minWidth: 140,
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      "Ainda não tem uma conta?",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xffffffff),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Cadastro()))
                      },
                      child: const Text(
                        "Cadastrar",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff9e9e9e),
                        ),
                      ),
                    )
                  ])),
            ),
          ),
        ));
  }
}

Future<List?> getClientPassword(String email) async {
  try {
    var listReturn = List.empty(growable: true);
    final queryParameters = {'email': email};

    // URL corrigida para usar apenas o caminho no segundo parâmetro do Uri.https
    final url = Uri.https(
        'shape-factory-5.onrender.com', '/client/getByEmail', queryParameters);
    print("URL: $url");

    final response = await http.get(url);

    // Verificar o status da resposta antes de tentar decodificar
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);

      // Verifica se a resposta tem os campos esperados
      if (decodedResponse != null &&
          decodedResponse['client_password'] != null) {
        listReturn.add(decodedResponse['client_password']);
        listReturn.add(decodedResponse['client_id']);
        return listReturn;
      }
    }

    // Retornar uma lista vazia se não encontrar a senha
    return List.empty();
  } catch (erro) {
    print("Erro ao obter senha do cliente: $erro");
    return List.empty();
  }
}
