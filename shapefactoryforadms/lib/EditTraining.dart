import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shapefactoryforadms/SelectExercise.dart';
class EditTraining extends StatefulWidget {
const EditTraining({super.key});
  @override
   EditTrainingState createState() => EditTrainingState();
  
}

class EditTrainingState extends State<EditTraining>{
var lista = List.empty(growable: true);
  var listElemento = List<Widget>.empty(growable: true);
  bool isLoading = true; // Adiciona um indicador de carregamento
  var selectedMuscles = List.empty(growable: true);
  var listMuscles = List<String>.empty(growable: true);
  String currentSearchText = '';

 


  Widget getWidget(String nome, String musculo, String imagem, int id) {
    return Card(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      color: const Color(0xffffffff),
      shadowColor: const Color(0x4d939393),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
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
 
                      Text(
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
              if (listMuscles
                      .contains(exercise['exercise_muscle']['muscle_name']) ==
                  false) {
                listMuscles.add(exercise['exercise_muscle']['muscle_name']);
              }
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

              : Column(
children: [
                    Flexible(
                      child: RawScrollbar(
                        thumbColor: Colors.orange,
                        thumbVisibility:
                            true, // Exibe a barra mesmo quando não está rolando
                        thickness: 6, // Define a espessura do Scrollbar
                        radius: const Radius.circular(
                            10), // Define o raio para cantos arredondados
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.02,
                              10,
                              MediaQuery.of(context).size.width * 0.02,
                              0),
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          children: listElemento,
                        ),
                      ),
                    )
                  ],
                ),
        ));
  }
}