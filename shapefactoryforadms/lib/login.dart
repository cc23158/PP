import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shapefactoryforadms/centralpage.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final controllerEmail = TextEditingController();
  final controllerSenha = TextEditingController();
  var mensagemErro = "";
  var corBorda;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height) {
      setState(() {
        corBorda = const BorderSide(color: Colors.grey);
      });
    } else {
      setState(() {
        corBorda = const BorderSide(color: Colors.black);
      });
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xff000000),
        body: Align(
            alignment: Alignment.center,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.5,
                constraints:
                    const BoxConstraints(minHeight: 700, minWidth: 400),
                child: Card(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      side: corBorda,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  child: SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Image(
                            image: AssetImage(
                                "assets/images/shapeforadmslogo.png"),
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
                              cursorColor: Colors.orange,
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
                            cursorColor: Colors.orange,
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
                                      var verified = await verifyAccount(
                                          controllerEmail.text,
                                          controllerSenha.text);
                                      print(verified);
                                      if (verified == true) {
                                        setState(() {
                                          mensagemErro = "";
                                        });
                                        var musculosOfc = await getMuscles();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CentralPage(
                                                        musculos:
                                                            musculosOfc)));
                                      } else if (verified == false) {
                                        setState(() {
                                          mensagemErro =
                                              "Usuário ou senha incorretos";
                                        });
                                      } else {
                                        setState(() {
                                          mensagemErro = "Erro no servidor";
                                        });
                                      }
                                    },
                                    color:
                                        const Color.fromARGB(255, 255, 120, 40),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    textColor: const Color(0xffffffff),
                                    height: 60,
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
                        ]),
                  )),
                ))),
      ),
    );
  }
}

Future<Object?> verifyAccount(String email, String password) async {
  try {
    final queryParameters = {
      'email': email,
      'password': password,
    };
    final response = await http.get(
      Uri.https('shape-factory-5.onrender.com', '/adm/verify', queryParameters),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (erro) {
    print(erro.toString());
    return 0;
  }
}

Future<List<Map<String, dynamic>>?> getMuscles() async {
  print("Iniciando busca de músculos");
  var lista = <Map<String, dynamic>>[];
  try {
    final response = await http.get(
      Uri.parse('https://shape-factory-5.onrender.com/muscle/getAll'),
    );
    print("Resposta recebida");
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      if (decodedResponse != null && decodedResponse is List) {
        for (var muscle in decodedResponse) {
          lista.add({
            'id': muscle['muscle_id'],
            'nome': muscle['muscle_name'],
          });
        }
        print("Lista de músculos: $lista");
        return lista;
      } else {
        print("Resposta não é uma lista ou está vazia");
        return null;
      }
    } else {
      print("Erro na resposta: ${response.statusCode}");
      return null;
    }
  } catch (erro) {
    print("Erro ao buscar músculos: ${erro.toString()}");
    return null;
  }
}
