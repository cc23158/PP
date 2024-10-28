import 'dart:convert';
import 'dart:io';
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
  bool isLoading = true;
  var controllerUpdate = List<int>.empty(growable: true);

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
        'https://shape-factory-5.onrender.com/exercise/insert',
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

  Future<int> deleteExercise(int id) async {
    try {
      final queryParameters = {
        'id': id.toString(),
      };
      final response = await http.delete(
        Uri.https('shape-factory-5.onrender.com', '/exercise/delete',
            queryParameters),
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

  Future<int> uptadeExercise(int id, String nome, String path, int muscle,
      PlatformFile? imagem) async {
    try {
      var dio = Dio();

      var formData = FormData.fromMap({
        'id': id.toString(),
        'muscleId': muscle.toString(),
        'name': nome,
        'path': path,
      });

      // Adiciona a imagem apenas se uma nova imagem foi selecionada
      if (imagem != null && imagem.name != 'null') {
        formData.files.add(MapEntry(
          'image',
          MultipartFile.fromBytes(imagem.bytes!, filename: imagem.name),
        ));
      }

      var response = await dio.put(
        'https://shape-factory-5.onrender.com/exercise/update',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      if (response.statusCode == 200) {
        print("Exercício atualizado com sucesso");
        return 1;
      } else {
        throw Exception('Falha ao enviar dados');
      }
    } catch (e) {
      print(e.toString());
      return 0;
    }
  }

  void getExercises() async {
    setState(() {
      isLoading = true;
    });
    print("Iniciando busca de exercícios");
    var lista = <Map<String, dynamic>>[];
    try {
      final response = await http.get(
        Uri.parse('https://shape-factory-5.onrender.com/exercise/getAll'),
      );
      print("Resposta recebida");
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        if (decodedResponse != null && decodedResponse is List) {
          setState(() {
            for (var exercise in decodedResponse) {
              listCamera.add(Icon(Icons.camera_alt));
              controllerNome.add(TextEditingController());
              controllerUrl.add(TextEditingController());
              controllerCamera.add(PlatformFile(name: 'null', size: 0));
              controllerMusculo.add(-1);
              controllerRow.add(ScrollController());
              listElement
                  .add(getWidget(widget.musculos, controllerRow.length - 1));
              controllerNome[controllerNome.length - 1].text =
                  exercise["exercise_name"];
              controllerUrl[controllerUrl.length - 1].text =
                  exercise["exercise_path"];
              controllerMusculo[controllerMusculo.length - 1] =
                  exercise["exercise_muscle"]["muscle_id"];
              controllerId.add(exercise["exercise_id"]);
              listCamera[listCamera.length - 1] = ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Image.network(
                    exercise["exercise_image"],
                    height: 46,
                    width: 46,
                    fit: BoxFit.cover,
                  ));
            }
            isLoading = false;
          });

          print("Lista de exércicios: $lista");
        } else {
          setState(() {
            isLoading = false;
          });
          print("Resposta não é uma lista ou está vazia");
          return null;
        }
      } else {
        setState(() {
          isLoading = false;
        });
        print("Erro na resposta: ${response.statusCode}");
        return null;
      }
    } catch (erro) {
      setState(() {
        isLoading = false;
      });
      print("Erro ao buscar exercícios: ${erro.toString()}");
      return null;
    }
  }

  Widget getWidget(dynamic musculos, int controllerIndex) {
    List<DropdownMenuItem<int>> dropdownItems =
        (musculos as List<dynamic>).map<DropdownMenuItem<int>>((musculo) {
      final Map<String, dynamic> item = musculo as Map<String, dynamic>;
      return DropdownMenuItem<int>(
        value: (item['id'] as int) - 1,
        child: Text(item['nome'] as String),
      );
    }).toList();

    return Card(
      color: const Color(0xffe0e0e0),
      shadowColor: const Color(0xff000000),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return RawScrollbar(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            thumbColor: Colors.black,
            radius: const Radius.circular(12),
            controller: controllerRow[controllerIndex],
            scrollbarOrientation: ScrollbarOrientation.bottom,
            interactive: true,
            child: SingleChildScrollView(
              controller: controllerRow[controllerIndex],
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: IntrinsicWidth(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Campo de Nome - Flex menor para reduzir mais rapidamente
                      Flexible(
                        flex: 4, // Flex menor
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                          child: Container(constraints: BoxConstraints(minWidth: 200), child:  TextField(
                            onChanged: (value) {
                              if (!controllerUpdate
                                  .contains(controllerId[controllerIndex])) {
                                setState(() {
                                  controllerUpdate
                                      .add(controllerId[controllerIndex]);
                                });
                              }
                            },
                            cursorColor: Colors.orange,
                            controller: controllerNome[controllerIndex],
                            decoration: _inputDecoration("Nome"),
                          ),
                        ),
                      ),),

                      // Campo de URL - Flex maior para manter tamanho mais estável
                      Flexible(
                        flex: 5, // Flex maior
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                          child: TextField(
                            onChanged: (value) {
                              if (!controllerUpdate
                                  .contains(controllerId[controllerIndex])) {
                                setState(() {
                                  controllerUpdate
                                      .add(controllerId[controllerIndex]);
                                });
                              }
                            },
                            cursorColor: Colors.orange,
                            controller: controllerUrl[controllerIndex],
                            decoration: _inputDecoration("URL do vídeo"),
                          ),
                        ),
                      ),

                      // Dropdown de Músculo
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                        child: SizedBox(
                          width: 200,
                          child: DropdownButtonFormField<int>(
                            decoration: _inputDecoration("Músculo"),
                            value: controllerMusculo[controllerIndex] == -1
                                ? null
                                : controllerMusculo[controllerIndex] - 1,
                            onChanged: (int? newValue) {
                              setState(() {
                                controllerMusculo[controllerIndex] =
                                    newValue! + 1;
                                if (!controllerUpdate
                                    .contains(controllerId[controllerIndex])) {
                                  controllerUpdate
                                      .add(controllerId[controllerIndex]);
                                }
                              });
                            },
                            items: dropdownItems,
                          ),
                        ),
                      ),

                      // Botão de Upload de Imagem
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                        child: MaterialButton(
                          minWidth: 52,
                          height: 52,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Colors.black),
                          ),
                          padding: const EdgeInsets.all(0),
                          child: listCamera[controllerIndex],
                          onPressed: () async {
                            var picked = await FilePicker.platform
                                .pickFiles(type: FileType.image);
                            if (picked != null) {
                              setState(() {
                                if (!controllerUpdate
                                    .contains(controllerId[controllerIndex])) {
                                  controllerUpdate
                                      .add(controllerId[controllerIndex]);
                                }
                                controllerCamera[controllerIndex] =
                                    picked.files.first;
                                listCamera[controllerIndex] = ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.memory(
                                    picked.files.first.bytes!,
                                    height: 46,
                                    width: 46,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              });
                            }
                          },
                        ),
                      ),

                      // Botão de Remover Item
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
                        child: MaterialButton(
                          minWidth: 52,
                          height: 52,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Colors.red),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              podeMudar = false;
                              listElement.removeAt(controllerIndex);
                              controllerRow.removeAt(controllerIndex);
                              controllerNome.removeAt(controllerIndex);
                              controllerUrl.removeAt(controllerIndex);
                              controllerMusculo.removeAt(controllerIndex);
                              listCamera.removeAt(controllerIndex);
                              controllerCamera.removeAt(controllerIndex);
                              controllerExcluir
                                  .add(controllerId[controllerIndex]);
                              controllerId.removeAt(controllerIndex);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontSize: 16,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    print("build");

    // Ajusta a cor da borda com base na orientação da tela
    if (MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height) {
      corBorda = const BorderSide(color: Colors.grey, width: 2);
    } else {
      corBorda = const BorderSide(color: Colors.black);
    }

    // Carrega os exercícios apenas uma vez
    if (listElement.isEmpty && podeMudar) {
      getExercises();
    }

    // Atualiza a lista de widgets
    listElement.clear();
    for (int i = 0; i < controllerRow.length; i++) {
      listElement.add(getWidget(widget.musculos, i));
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Conteúdo principal
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 1600,
                height: MediaQuery.of(context).size.height,
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
                        child: RawScrollbar(
                          thumbColor: Colors.orange,
                          controller: controllerList,
                          interactive: true,
                          minThumbLength:
                              50, // Tamanho mínimo do thumb da scrollbar
                          radius: const Radius.circular(12),
                          padding: const EdgeInsets.fromLTRB(10, 40, 0, 10),
                          child: ListView.builder(
                            controller: controllerList,
                            itemCount: listElement.length + 1,
                            itemBuilder: (context, index) {
                              if (index < listElement.length) {
                                // Renderiza os elementos dinâmicos
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  child: listElement[index],
                                );
                              } else {
                                return Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 6, 10, 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        // Botão Adicionar
                                        Flexible(
                                          child: MaterialButton(
                                            height: 50,
                                            onPressed: () {
                                              setState(() {
                                                listCamera.add(
                                                    Icon(Icons.camera_alt));
                                                controllerNome.add(
                                                    TextEditingController());
                                                controllerUrl.add(
                                                    TextEditingController());
                                                controllerCamera.add(
                                                    PlatformFile(
                                                        name: 'null', size: 0));
                                                controllerMusculo.add(-1);
                                                controllerRow
                                                    .add(ScrollController());
                                                controllerId.add(-1);
                                                listElement.add(getWidget(
                                                    widget.musculos,
                                                    controllerRow.length - 1));
                                              });
                                              controllerList.jumpTo(
                                                controllerList.position
                                                        .maxScrollExtent +
                                                    40,
                                              );
                                            },
                                            color: Colors.orange,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                bottomLeft: Radius.circular(12),
                                              ),
                                            ),
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
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
                                        // Botão Salvar
                                        Flexible(
                                          child: MaterialButton(
                                            height: 50,
                                            onPressed: () async {
                                              setState(() {
                                                isLoading = true;
                                              });

                                              for (int i = 0;
                                                  i < controllerRow.length;
                                                  i++) {
                                                if (controllerId[i] == -1) {
                                                  await postExercise(
                                                    controllerNome[i].text,
                                                    controllerUrl[i].text,
                                                    controllerMusculo[i],
                                                    controllerCamera[i],
                                                  );
                                                } else if (controllerUpdate
                                                    .contains(
                                                        controllerId[i])) {
                                                  await uptadeExercise(
                                                    controllerId[i],
                                                    controllerNome[i].text,
                                                    controllerUrl[i].text,
                                                    controllerMusculo[i],
                                                    controllerCamera[i].name !=
                                                            'null'
                                                        ? controllerCamera[i]
                                                        : null,
                                                  );
                                                }
                                              }

                                              for (int i = 0;
                                                  i < controllerExcluir.length;
                                                  i++) {
                                                if (controllerExcluir[i] !=
                                                    -1) {
                                                  await deleteExercise(
                                                      controllerExcluir[i]);
                                                }
                                              }

                                              setState(() {
                                                controllerUpdate.clear();
                                                controllerCamera.clear();
                                                controllerExcluir.clear();
                                                controllerId.clear();
                                                controllerMusculo.clear();
                                                controllerNome.clear();
                                                controllerRow.clear();
                                                controllerUrl.clear();
                                                listCamera.clear();
                                                listElement.clear();
                                                isLoading = false;
                                              });

                                              podeMudar = true;
                                            },
                                            color: Colors.orange,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(12),
                                                bottomRight:
                                                    Radius.circular(12),
                                              ),
                                            ),
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
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
                                        ),
                                      ],
                                    ));
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(1), // Fundo semitransparente
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                ),
              ),
          ],
        ),
      ),
      // Exibe o CircularProgressIndicator durante o carregamento
    );
  }
}
