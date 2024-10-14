import 'dart:convert';
import 'dart:io';
import 'dart:js_interop';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
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
  var corBorda;
  var dropdownvalue;
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

  void getTraining() async {}

  Widget getWidget(int controllerIndex) {
    return Card(
      color: const Color(0xffe0e0e0),
      shadowColor: const Color(0xff000000),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this); // 3 tipos de treino
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    if (MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height) {
      setState(() {
        corBorda = const BorderSide(color: Colors.grey, width: 2);
      });
    } else {
      setState(() {
        corBorda = const BorderSide(color: Colors.black);
      });
    }
    if (listElement.isEmpty && podeMudar) {
      //   getTraining();
    }

    setState(() {
      listElement.clear();
      for (int i = 0; i < controllerRow.length; i++) {
        listElement.add(getWidget(i));
      }
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Align(
                alignment: Alignment.center,
                child: Container(
                  width: 1600,
                  height: MediaQuery.of(context).size.height * 0.5,
                  constraints:
                      const BoxConstraints(minHeight: 700, minWidth: 400),
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
                              // ListView e elementos
                              Expanded(
                                child: RawScrollbar(
                                  thumbColor: Colors.orange,
                                  controller: controllerList,
                                  interactive: true,
                                  radius: Radius.circular(12),
                                  padding: EdgeInsets.all(10),
                                  child: ListView(
                                    controller: controllerList,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(children: listElement),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            26, 0, 26, 20),
                                        child: MaterialButton(
                                          height: 50,
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditTraining(category: tabController.index,)));
                                          },
                                          color: Colors.orange,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                      ),
                                    ],
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
