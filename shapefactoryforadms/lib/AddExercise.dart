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
  var controllerCamera = List<PlatformFile>.empty(growable: true);
  var corBorda;
  var dropdownvalue;

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
                        width: MediaQuery.of(context).size.width * 0.4,
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
                        child: DropdownMenu<int>(
                          width: 210,
                          hintText: "Músculo",
                          inputDecorationTheme: InputDecorationTheme(
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
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            filled: true,
                            fillColor: const Color(0x00ffffff),
                            isDense: false,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                          ),
                          initialSelection: controllerMusculo[controllerIndex],
                          onSelected: (int? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownvalue = value!;
                              controllerMusculo[controllerIndex] = value;
                            });
                          },
                          dropdownMenuEntries: musculos
                    .map<DropdownMenuEntry<int>>((Map<String, dynamic> musculo) {
                  return DropdownMenuEntry<int>(
                    value: musculo['id'] as int,
                    label: musculo['nome'] as String,
                  );
                }).toList(),
                        )),
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
                                controllerCamera[controllerIndex] = picked.files.first;
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
                            controllerMusculo
                                .removeAt(controllerIndex);
                            listCamera.remove(listCamera[controllerIndex]);
                            controllerCamera.remove(controllerCamera[controllerIndex]);
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
                        const Text("Lista de novas formas de fábricar o corpo",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700)),
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
                                                      controllerCamera.add(PlatformFile(name: 'null', size: 0));
                                                      controllerMusculo.add(0);
                                                      controllerRow.add(
                                                          ScrollController());
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
                                                      postExercise(
                                                          controllerNome[i]
                                                              .text,
                                                          controllerUrl[i].text,
                                                          controllerMusculo[i], controllerCamera[i]);
                                                    }
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


Future<int> postExercise(String nome, String path, int muscle, PlatformFile imagem) async {
  try {
    var dio = Dio();

    var formData = FormData.fromMap({
      'muscleId': muscle.toString(),
      'name': nome,
      'path': path,
      'image': MultipartFile.fromBytes(imagem.bytes!, filename: imagem.name),
    });

    var response = await dio.post(
      'http://localhost:8080/exercise/insert/',
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

