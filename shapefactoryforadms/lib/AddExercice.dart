import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddExercice extends StatefulWidget {
  final dynamic musculos;
  const AddExercice(this.musculos, {super.key});
  @override
  AddExerciceState createState() => AddExerciceState();
}

class AddExerciceState extends State<AddExercice> {
  final controllerNome = List<TextEditingController>.empty(growable: true);
  final controllerUrl = List<TextEditingController>.empty(growable: true);
  final controllerMusculo = List<TextEditingController>.empty(growable: true);
  final controllerList = ScrollController();
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
        padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
        child: 
        
            Row(
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
                              color: Color.fromARGB(255, 0, 0, 0), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 1),
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
                              color: Color.fromARGB(255, 0, 0, 0), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 1),
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
                Padding(padding: const EdgeInsets.all(5) ,child: 
                DropdownMenu<String>(
                  controller: controllerMusculo[controllerMusculo.length - 1],
                  inputDecorationTheme: InputDecorationTheme(
                                            disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 1),
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
      dropdownMenuEntries: musculos.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    )
                )
                
              ],
            ),
          
        ),
      );

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
                                child: ListView(
                                    controller: controllerList,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(children: listElement),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: MaterialButton(
                                          onPressed: () {
                                            setState(() {
                                              controllerNome
                                                  .add(TextEditingController());
                                              controllerUrl
                                                  .add(TextEditingController());
                                              controllerMusculo.add(TextEditingController());
                                              listElement.add(getWidget(widget.musculos));
                                            });
                                            controllerList.jumpTo(controllerList
                                                    .position.maxScrollExtent +
                                                40);
                                          },
                                          color: Colors.orange,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12))),
                                          minWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          padding: const EdgeInsets.all(20),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.add),
                                              Text(
                                                "Adicionar a lista",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ])))
                      ],
                    )))));
  }
}
