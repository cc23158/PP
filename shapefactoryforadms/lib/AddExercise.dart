import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddExercise extends StatefulWidget {
  final dynamic musculos;
  const AddExercise(this.musculos, {super.key});
  @override
  AddExerciceState createState() => AddExerciceState();
}

class AddExerciceState extends State<AddExercise> {
  final controllerNome = List<TextEditingController>.empty(growable: true);
  final controllerUrl = List<TextEditingController>.empty(growable: true);
  final controllerMusculo = List<TextEditingController>.empty(growable: true);
  final controllerList = ScrollController();
  final controllerRow = List<ScrollController>.empty(growable: true);

  var mensagemErro = "";
  var listElement = List<Widget>.empty(growable: true);
  var corBorda;
  var dropdownvalue;

  Widget getWidget(dynamic musculos) {
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
            controller: controllerRow[controllerRow.length - 1],
            scrollbarOrientation: ScrollbarOrientation.bottom,
            interactive: true,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: SingleChildScrollView(
                controller: controllerRow[controllerRow.length - 1],
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        width: 100,
                        child: TextField(
                          cursorColor: Colors.orange,
                          controller: controllerNome[controllerNome.length - 1],
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
                        width: 200,
                        child: TextField(
                          cursorColor: Colors.orange,
                          controller: controllerUrl[controllerUrl.length - 1],
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
                        child: DropdownMenu<String>(
                          hintText: "Músculo",
                          controller:
                              controllerMusculo[controllerMusculo.length - 1],
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
                          initialSelection: musculos.first,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownvalue = value!;
                            });
                          },
                          dropdownMenuEntries: musculos
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        )),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: MaterialButton(
                          minWidth: 56,
                          height: 56,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.black)),
                          padding: EdgeInsets.all(10),
                          child: const Icon(Icons.camera_alt),
                          onPressed: () async {
                            var picked = await FilePicker.platform
                                .pickFiles(type: FileType.image);

                            if (picked != null) {
                              print(picked.files.first.name);
                            }
                          }),
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

    if (listElement.isEmpty == true) {
      setState(() {
        controllerNome.add(TextEditingController());
        controllerUrl.add(TextEditingController());
        controllerMusculo.add(TextEditingController());
        controllerRow.add(ScrollController());
        listElement.add(getWidget(widget.musculos));
      });
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.black,
            body: Align(
                alignment: Alignment.center,
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.5,
                    constraints:
                        const BoxConstraints(minHeight: 700, minWidth: 400),
                    child: Column(
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
                                              20, 0, 20, 20),
                                          child: MaterialButton(
                                            onPressed: () {
                                              setState(() {
                                                controllerNome.add(
                                                    TextEditingController());
                                                controllerUrl.add(
                                                    TextEditingController());
                                                controllerMusculo.add(
                                                    TextEditingController());
                                                controllerRow
                                                    .add(ScrollController());
                                                listElement.add(
                                                    getWidget(widget.musculos));
                                              });
                                              controllerList.jumpTo(
                                                  controllerList.position
                                                          .maxScrollExtent +
                                                      40);
                                            },
                                            color: Colors.orange,
                                            minWidth: 1000,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12))),
                                            padding: const EdgeInsets.all(20),
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.add),
                                                Text(
                                                  "Adicionar a lista",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ]),
                                )))
                      ],
                    )))));
  }
}