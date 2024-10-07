import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shapefactoryforadms/AddExercise.dart';

class SelectExercise extends StatefulWidget {
  const SelectExercise({super.key});
  @override
  SelectExerciseState createState() => SelectExerciseState();
}

class SelectExerciseState extends State<SelectExercise> {
  var lista = List.empty(growable: true);
  var listElemento = List<Widget>.empty(growable: true);
  bool isLoading = true; // Adiciona um indicador de carregamento

  Widget getWidget(String nome, String musculo, String imagem, int id) {
    return Card(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      color: const Color(0xffffffff),
      shadowColor: const Color(0x4d939393),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Color(0xfff2f2f2),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image(
                  image: NetworkImage(imagem),
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      nome,
                      textAlign: TextAlign.left,
                      maxLines: 10,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text(
                        musculo,
                        textAlign: TextAlign.left,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff6c6c6c),
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
    );
  }

  Future getExercises() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8080/exercise/getAll'),
      );
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        if (decodedResponse != null && decodedResponse is List) {
          setState(() {
            lista = decodedResponse;
            listElemento = decodedResponse.map<Widget>((exercise) {
              return getWidget(
                exercise['exercise_name'],
                exercise['exercise_muscle']['muscle_name'],
                exercise['exercise_image'],
                exercise['exercise_id'],
              );
            }).toList();
            isLoading = false; // Remover o indicador de carregamento
          });
        }
      } else {
        print("Erro na resposta: ${response.statusCode}");
      }
    } catch (erro) {
      print("Erro ao buscar exercícios: ${erro.toString()}");
    }
  }

  @override
  void initState() {
    super.initState();
    getExercises(); // Chama o método de busca uma única vez
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: isLoading
            ? const Center(
                child:
                    CircularProgressIndicator()) // Mostra um indicador de carregamento
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.keyboard_return_rounded,
                          color: Colors.white,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            cursorColor: Colors.orange,
                            onChanged: (value) => {
                              if (value == "")
                                {
                                  setState(() {
                                                                      listElemento = lista.map<Widget>((exercise) {
                                    return getWidget(
                                      exercise['exercise_name'],
                                      exercise['exercise_muscle']
                                          ['muscle_name'],
                                      exercise['exercise_image'],
                                      exercise['exercise_id'],
                                    );
                                  }).toList();
                                  })

                                }
                              else
                                {
                                  setState(() {
                                     listElemento = lista.where((exercise) {
                                    return exercise['exercise_name']
                                        .toLowerCase()
                                        .contains(value
                                            .toLowerCase()); // Filtra pela string digitada
                                  }).map<Widget>((exercise) {
                                    return getWidget(
                                      exercise['exercise_name'],
                                      exercise['exercise_muscle']
                                          ['muscle_name'],
                                      exercise['exercise_image'],
                                      exercise['exercise_id'],
                                    );
                                  }).toList();
                                  })
                                 
                                }
                            },
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color(0xffffffff),
                            ),
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Color(0xff9e9e9e), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Color(0xff9e9e9e), width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Color(0xff9e9e9e), width: 1),
                              ),
                              labelText: "Pesquisar",
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0xff9e9e9e),
                              ),
                              filled: true,
                              fillColor: const Color(0x00ffffff),
                              isDense: false,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                    ListView(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      children: listElemento,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
