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

class AddExercise extends StatefulWidget {
  final dynamic musculos;
  const AddExercise(this.musculos, {super.key});
  @override
  AddExerciceState createState() => AddExerciceState();
}

class AddExerciceState extends State<AddExercise> {
  final controllerNome = List<TextEditingController>.empty(growable: true);
  final controllerUrl = List<TextEditingController>.empty(growable: true);
  final controllerMusculo = List<int>.empty(growable: true);
  final controllerList = ScrollController();
  final controllerRow = List<ScrollController>.empty(growable: true);
  bool podeMudar = true;
  var mensagemErro = "";
  var listElement = List<Widget>.empty(growable: true);
  var listCamera = List<Widget>.empty(growable: true);
  var controllerCamera = List.empty(growable: true);
  var controllerId = List<int>.empty(growable: true);
  var controllerExcluir = List<int>.empty(growable: true);
  var corBorda;
  var dropdownvalue;

  void getExercises() async {
    print("Iniciando busca de exercícios");
    var lista = <Map<String, dynamic>>[];
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8080/exercise/getAll'),
      );
      print("Resposta recebida");
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        if (decodedResponse != null && decodedResponse is List) {
          setState(() {
            for (var exercise in decodedResponse){
            listCamera.add(Icon(Icons.camera_alt));
            controllerNome.add(TextEditingController());
            controllerUrl.add(TextEditingController());
            controllerCamera.add(PlatformFile(name: 'null', size: 0));
            controllerMusculo.add(-1);
            controllerRow.add(ScrollController());
            listElement
                .add(getWidget(widget.musculos, controllerRow.length - 1));
            controllerNome[controllerNome.length - 1].text = exercise["exercise_name"];
            controllerUrl[controllerUrl.length - 1].text = exercise["exercise_path"];
            controllerMusculo[controllerMusculo.length - 1] = exercise["exercise_muscle"]["muscle_id"];
            controllerId.add(exercise["exercise_id"]);
            listCamera[listCamera.length - 1] = ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    child: Image.network(
                                      exercise["exercise_image"],
                                      height: 46,
                                      width: 46,
                                      fit: BoxFit.cover,
                                    ));
          }});

          print("Lista de exércicios: $lista");
        } else {
          print("Resposta não é uma lista ou está vazia");
          return null;
        }
      } else {
        print("Erro na resposta: ${response.statusCode}");
        return null;
      }
    } catch (erro) {
      print("Erro ao buscar exercícios: ${erro.toString()}");
      return null;
    }
  }

  Widget getWidget(dynamic musculos, int controllerIndex) {
    return Card(
        color: const Color(0xffe0e0e0),
        shadowColor: const Color(0xff000000),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: RawScrollbar(
            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            thumbColor: Colors.black,
            radius: Radius.circular(12),
            controller: controllerRow[controllerIndex],
            scrollbarOrientation: ScrollbarOrientation.bottom,
            interactive: true,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: SingleChildScrollView(
                controller: controllerRow[controllerIndex],
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.33,
                        child: TextField(
                          cursorColor: Colors.orange,
                          controller: controllerNome[controllerIndex],
                          obscureText: false,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  width: 1),
                            ),
                            labelText: "Nome",
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            filled: true,
                            fillColor: const Color(0x00ffffff),
                            isDense: false,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.39,
                        child: TextField(
                          cursorColor: Colors.orange,
                          controller: controllerUrl[controllerIndex],
                          obscureText: false,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  width: 1),
                            ),
                            labelText: "URL do vídeo",
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            filled: true,
                            fillColor: const Color(0x00ffffff),
                            isDense: false,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(5),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: DropdownButtonFormField<int>(
                              decoration: InputDecoration(
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    width: 1,
                                  ),
                                ),
                                labelText: "Músculo", // Define o rótulo
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                              ),
                              value: controllerMusculo[controllerIndex] == -1
                                  ? null
                                  : controllerMusculo[controllerIndex] - 1,
                              onChanged: (int? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                  controllerMusculo[controllerIndex] =
                                      newValue + 1;
                                });
                              },
                              items: musculos.map<DropdownMenuItem<int>>(
                                  (Map<String, dynamic> musculo) {
                                return DropdownMenuItem<int>(
                                  value: (musculo['id'] as int) - 1,
                                  child: Text(musculo['nome'] as String),
                                );
                              }).toList(),
                            ))),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                      child: MaterialButton(
                          minWidth: 56,
                          height: 56,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.black)),
                          padding: EdgeInsets.all(10),
                          child: listCamera[controllerIndex],
                          onPressed: () async {
                            var picked = await FilePicker.platform
                                .pickFiles(type: FileType.image);

                            if (picked != null) {
                              setState(() {
                                print(picked.files.first.name);
                                controllerCamera[controllerIndex] =
                                    picked.files.first;
                                listCamera[controllerIndex] = ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    child: Image.memory(
                                      picked.files.first.bytes!,
                                      height: 46,
                                      width: 46,
                                      fit: BoxFit.cover,
                                    ));
                              });
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                      child: MaterialButton(
                        minWidth: 56,
                        height: 56,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.red)),
                        padding: EdgeInsets.all(10),
                        child: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            // Remove the widget first
                            podeMudar = false;
                            listElement.removeAt(controllerIndex);
                            controllerRow.removeAt(controllerIndex);
                            controllerNome
                                .remove(controllerNome[controllerIndex]);
                            controllerUrl
                                .remove(controllerUrl[controllerIndex]);
                            controllerMusculo.removeAt(controllerIndex);
                            listCamera.remove(listCamera[controllerIndex]);
                            controllerCamera
                                .remove(controllerCamera[controllerIndex]);
                            controllerExcluir.add(controllerId[controllerIndex]);
                            controllerId.removeAt(controllerIndex);
                            podeMudar = false;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
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
      getExercises();
    }

    setState(() {
      listElement.clear();
      for (int i = 0; i < controllerRow.length; i++) {
        listElement.add(getWidget(widget.musculos, i));
      }
    });

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.black,
            body: Align(
                alignment: Alignment.center,
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.96,
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
                                        Radius.circular(12))),
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
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Flexible(
                                                child: MaterialButton(
                                                  height: 50,
                                                  onPressed: () {
                                                    setState(() {
                                                      listCamera.add(Icon(
                                                          Icons.camera_alt));
                                                      controllerNome.add(
                                                          TextEditingController());
                                                      controllerUrl.add(
                                                          TextEditingController());
                                                      controllerCamera.add(
                                                          PlatformFile(
                                                              name: 'null',
                                                              size: 0));
                                                      controllerMusculo.add(-1);
                                                      controllerRow.add(
                                                          ScrollController());
                                                      controllerId.add(-1);
                                                      listElement.add(getWidget(
                                                          widget.musculos,
                                                          controllerRow.length -
                                                              1));
                                                    });
                                                    controllerList.jumpTo(
                                                      controllerList.position
                                                              .maxScrollExtent +
                                                          40,
                                                    );
                                                  },
                                                  color: Colors.orange,
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(12),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      12))),
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Icon(Icons.add),
                                                      Text(
                                                        "Adicionar",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: MaterialButton(
                                                  height: 50,
                                                  onPressed: () async {
                                                    print(controllerMusculo[0]);
                                                    for (int i = 0;
                                                        i <
                                                            controllerRow
                                                                .length;
                                                        i++) {
                                                          if (controllerId[i] == -1){
                                                      await postExercise(
                                                          controllerNome[i]
                                                              .text,
                                                          controllerUrl[i].text,
                                                          controllerMusculo[i],
                                                          controllerCamera[i]);}
                                                          else {
                                                            
                                                          }
                                                    }
                                                    for (int i = 0; i < controllerExcluir.length; i++){
                                                      if (controllerExcluir[i] != -1){
                                                      await deleteExercise(controllerExcluir[i]);}
                                                    }
                                                    controllerCamera.clear();
                                                    controllerExcluir.clear();
                                                    controllerId.clear();
                                                    controllerMusculo.clear();
                                                    controllerNome.clear();
                                                    controllerRow.clear();
                                                    controllerUrl.clear();
                                                    listCamera.clear();
                                                    listElement.clear();
                                                    getExercises();
                                                    podeMudar = true;
                                                  },
                                                  color: Colors.orange,
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(12),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Icon(Icons.save_as),
                                                      Text(
                                                        "Salvar",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ]),
                                )))
                      ],
                    )))));
  }
}

Future<int> postExercise(
    String nome, String path, int muscle, PlatformFile imagem) async {
  print(imagem.name);
  try {
    var dio = Dio();

    var formData = FormData.fromMap({
      'muscleId': muscle.toString(),
      'name': nome,
      'path': path,
      'image': MultipartFile.fromBytes(imagem.bytes!, filename: imagem.name),
    });

    var response = await dio.post(
      'http://localhost:8080/exercise/insert',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    if (response.statusCode == 200) {
      print("Exercício registrado com sucesso");
      return 1;
    } else {
      throw Exception('Falha ao enviar dados');
    }
  } catch (e) {
    print(e.toString());
    return 0;
  }
}

Future<int> deleteExercise(int id) async{

  try {
    final queryParameters = {
  'id': id.toString(),
};
    final response = await http.delete(
      Uri.http('localhost:8080', '/exercise/delete', queryParameters ), 
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

Future<int> uptadeExercise(int id) async{

  try {
    final queryParameters = {
  'id': id.toString(),
};
    final response = await http.delete(
      Uri.http('localhost:8080', '/exercise/delete', queryParameters ), 
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

