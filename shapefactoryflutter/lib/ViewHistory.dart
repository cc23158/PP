import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shapefactory/SelectExercise.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shapefactory/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewHistory extends StatefulWidget {
  final nome;
  final List listaHistory;
  const ViewHistory(
      {
      super.key,
      required this.nome, required this.listaHistory});



  @override
  ViewHistoryState createState() => ViewHistoryState();
}

class ViewHistoryState extends State<ViewHistory> {
  var listElemento = List<Widget>.empty(growable: true);
  var controllerNome;
  bool isLoading = false;
  String currentSearchText = '';
  bool isTraining = false; // Para controlar o estado do treino

  Duration elapsedTime = Duration.zero;

  var corBorda;
  List<Map<String, dynamic>> exercises = [];


Future<void> fetchRecipeFromList(List recipesData) async {
  try {
    // Converte os dados da lista passada para o formato desejado.
    exercises = recipesData.map<Map<String, dynamic>>((recipe) {
      final recipeExercise = recipe['history_exercise'];
      final weight = recipe['history_weight'] ?? '';
      final reps = recipe['history_reps'] ?? '';

      // Separa as cargas e reps usando a '/' como delimitador.
      final weights = weight.split('/');
      final repsList = reps.split('/');

      // Cria a lista de sets, unindo carga e reps na ordem correta.
      List<Map<String, dynamic>> sets = [];
      for (int i = 0; i < weights.length; i++) {
        sets.add({
          'carga': weights[i].trim(),
          'reps': repsList.length > i ? repsList[i].trim() : '',
          'isCompleted': false
        });
      }

      return {
        'id': recipeExercise['exercise_id'],
        'name': recipeExercise['exercise_name'],
        'musculo': recipeExercise['exercise_muscle']['muscle_name'],
        'image': recipeExercise['exercise_image'],
        'sets': sets,
      };
    }).toList();

  } catch (e) {
    // Trate a exceção de acordo com sua lógica.
    print('Erro: $e');
  }
}

 
  @override
  void initState() {
    super.initState();
    fetchRecipeFromList(widget.listaHistory);
    }


  



  // Função para parar o temporizador e limpar o estado
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      appBar: AppBar(
        
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back, color: Colors.white,)),
        title: Text(widget.nome, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
        centerTitle: true,
        toolbarHeight: 40,
      ),
      body: Center(
        
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
          alignment: Alignment.topCenter,
          color: Colors.black,
          constraints: const BoxConstraints(maxWidth: 550),
          child: Card(
            color: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
            children: [            
                Expanded(
                  child: CustomScrollView(
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {

                                    return _exerciseCard(exercises[index]);


                                 
                                },
                                childCount: exercises.length
                              ),
                            ),
                          ],
                        ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Função para cabeçalhos da GridView
  Widget _gridHeader(String text) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }

  // Função para exibir número do set
// Função para exibir número do set
  Widget _exerciseCard(Map<String, dynamic> exercise) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
        child: Card(
          color: const Color(0xffe0e0e0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getWidget(
                  exercise["name"],
                  exercise["musculo"],
                  exercise["image"],
                  exercise["id"],
                ),
                // Aqui pode incluir o widget personalizado para o cabeçalho

                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        exercise["sets"].length * 3 + 3, // +3 for headers
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 4,
                    ),
                    itemBuilder: (context, index) {
                      if (index < 3) {
                        // Header row
                        return _gridHeader(["Set", "Carga", "Reps"][index]);
                      } else {
                        // Body rows with sets
                        final setIndex = (index - 3) ~/ 3;
                        final set = exercise["sets"][setIndex];
                        final fieldIndex = (index - 3) % 3;

                        if (fieldIndex == 0) {
                          // Display set number
                          return _setNumberWidget(
                            setIndex,
                            set["isCompleted"] ??
                                false, // Passa o estado de conclusão
                            () {
                              setState(() {
                                set["isCompleted"] = !(set["isCompleted"] ??
                                    false); // Alterna o estado
                              });
                            },
                          );
                        } else if (fieldIndex == 1) {
                          // Editable carga field
                          return _editableField(
                            initialValue: set["carga"],
                            onChanged: (value) => set["carga"] = value,
                          );
                        } else if (fieldIndex == 2) {
                          return _editableField(
                            initialValue: set["reps"],
                            onChanged: (value) => set["reps"] = value,
                          );
                        }
                      }
                    }),

              
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Atualização do widget setNumber com animação de cor verde para set concluído
  Widget _setNumberWidget(int setNumber, bool isCompleted, VoidCallback onTap) {
    return TextField(
      controller: TextEditingController(text: "${setNumber + 1}"),
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 16, color: Colors.white),
      onTap: isTraining ? onTap : VoidCallbackAction.new,
      readOnly: true,
      cursorColor: Colors.orange,
      decoration: InputDecoration(
        filled: true,
        fillColor: isCompleted ? Colors.orange : Colors.black,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      ),
    );
  }

  // Widget para campos editáveis sem alterações de cor
  Widget _editableField({
    required String initialValue,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      child: TextField(
        controller: TextEditingController(text: initialValue),
        readOnly: true,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16, color: Colors.black),
        cursorColor: Colors.orange,
        
        decoration: const InputDecoration(
          filled: true, fillColor: Colors.black26,
          border: OutlineInputBorder(
            
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.black)
            
          ),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.black)),
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        ),
      ),
    );
  }
}

// Função personalizada fornecida
Widget getWidget(String nome, String musculo, String imagem, int id) {
  return Card(
    color: const Color(0xffffffff),
    shadowColor: const Color(0x4d939393),
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xfff2f2f2),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imagem,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nome,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    musculo,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
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
