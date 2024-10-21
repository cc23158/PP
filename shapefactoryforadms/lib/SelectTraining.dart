import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:shapefactoryforadms/EditTraining.dart';

class SelectTraining extends StatefulWidget {
  const SelectTraining({super.key});
  @override
  SelectTrainingState createState() => SelectTrainingState();
}

class SelectTrainingState extends State<SelectTraining>
    with SingleTickerProviderStateMixin {
  final controllerList = ScrollController();
  final controllerRow = List<ScrollController>.empty(growable: true);
  bool podeMudar = true;
  var mensagemErro = "";
  var listElement = List<Widget>.empty(growable: true);
  var treinos = List<Map<String, dynamic>>.empty();
  var corBorda;
  late TabController tabController;
  bool isLoading = false;

  Future<int> deleteExercise(int id) async {
    try {
      final queryParameters = {
        'id': id.toString(),
      };
      final response = await http.delete(
        Uri.http('localhost:8080', '/exercise/delete', queryParameters),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return 1;
      } else {
        throw Exception('Falha ao deletar');
      }
    } catch (erro) {
      print(erro.toString());
      return 0;
    }
  }
  Future<List<Map<String, dynamic>>> getTraining() async {
    final url = Uri.parse('https://shape-factory-5.onrender.com/training/getByClient?clientId=1');

    // Print da URL da requisição
    print("GET $url");

    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        print('Treinos obtidos com sucesso: ${response.body}');
        
        // Decodifica o JSON e retorna a lista de treinos
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((item) => item as Map<String, dynamic>).toList();
      } else {
        print('Falha ao obter treinos: ${response.statusCode}');
        print('Response: ${response.body}');
        return [];
      }
    } catch (error) {
      print('Erro ao obter treinos: $error');
      return [];
    }
  }

Widget getWidget(Map<String, dynamic> treino) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
    child: Card(
      margin: const EdgeInsets.all(0),
      color: const Color(0xffe0e0e0),
      shadowColor: const Color(0xff000000),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                treino['training_name'] ?? "Treino",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xff000000),
                ),
              ),
            ),
Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    height: 52,
                    color: Colors.orange,
                    shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                    onPressed: () {
                      // Lógica para editar
                    },
                    child: const Text(
                      'Editar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 5),
                  MaterialButton(
                    color: Colors.red,
                          minWidth: 52,
                          height: 52,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Colors.red),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: const Icon(Icons.delete, color: Colors.white),
                          onPressed: () {
                          },
                        ),
                ],
              
            ),
          ],
        ),
      ),
    ),
  );
}


   Future<void> fetchTrainings() async {
    treinos = await getTraining(); // Obtém os treinos
    // Filtra e cria widgets apenas para treinos com training_category == 1
    listElement = treinos
        .where((treino) => treino['training_category'] == 1)
        .map((treino) => getWidget(treino)) // Chama sua função getWidget
        .toList();
    setState(() {}); // Atualiza a interface
  }

  @override
  void initState(){
    super.initState();
    tabController = TabController(length: 3, vsync: this); // 3 tipos de treino
    fetchTrainings();
  }


@override
Widget build(BuildContext context) {
  print("build");

  // Atualiza a cor da borda com base na orientação da tela
  if (MediaQuery.of(context).size.width > MediaQuery.of(context).size.height) {
    setState(() {
      corBorda = const BorderSide(color: Colors.grey, width: 2);
    });
  } else {
    setState(() {
      corBorda = const BorderSide(color: Colors.black);
    });
  }

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Align(
              alignment: Alignment.center,
              child: Container(
                width: 700,
                height: MediaQuery.of(context).size.height * 1,
                constraints: const BoxConstraints(minHeight: 300, minWidth: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Card(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          side: corBorda,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          children: [
                            // TabBar para seleção do tipo de treino
                            Container(
                              color: Colors.black,
                              child: TabBar(
                                controller: tabController,
                                onTap: (value) {
                                  listElement = treinos
        .where((treino) => treino['training_category'] == value + 1)
        .map((treino) => getWidget(treino)) // Chama sua função getWidget
        .toList();
    setState(() {}); // Atualiza a interface
                                },
                                labelColor: Colors.white,
                                indicatorColor: Colors.orange,

                                unselectedLabelColor: Colors.white60,
                                tabs: const [
                                  Tab(text: 'Superiores'),
                                  Tab(text: 'Inferiores'),
                                  Tab(text: 'Full-body'),
                                ],
                              ),
                            ),
                            // ListView.builder para exibir os elementos
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.83, // Define a altura do ListView
                              child: RawScrollbar(
                                thumbColor: Colors.orange,
                                controller: controllerList,
                                interactive: true,
                                radius: const Radius.circular(12),
                                padding: const EdgeInsets.all(10),
                                child: ListView.builder(
                                  controller: controllerList,
                                  itemCount: listElement.length + 1, // +1 para o botão de adicionar
                                  itemBuilder: (context, index) {
                                    if (index < listElement.length) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                                        child: listElement[index],
                                      );
                                    } else {
                                      // Botão Adicionar
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(26, 5, 26, 20),
                                        child: MaterialButton(
                                          height: 50,
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => EditTraining(
                                                  category: tabController.index + 1,
                                                ),
                                              ),
                                            );
                                          },
                                          color: Colors.orange,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12)),
                                          child: const Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Icon(Icons.add),
                                              Text(
                                                "Adicionar",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    ),
  );
}

}