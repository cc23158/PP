import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shapefactoryforadms/SelectExercise.dart';

class EditTraining extends StatefulWidget {
  final category;
  const EditTraining({required this.category, super.key});
  @override
  EditTrainingState createState() => EditTrainingState();
}

class EditTrainingState extends State<EditTraining> {
  var lista = List.empty(growable: true);
  var listElemento = List<Widget>.empty(growable: true);
  final controllerNome = TextEditingController();
  bool isLoading = false;
  String currentSearchText = '';
  var corBorda;
  List<Map<String, dynamic>> exercises = [];

  Future<void> _navigateToSelectExercise() async {
    final selectedExercisesFrom = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectExercise(selectedExercises: exercises),
      ),
    );

    if (selectedExercisesFrom != null) {
      print(selectedExercisesFrom.toString());
      setState(() {
        exercises = selectedExercisesFrom;
      });
    }
  }

  Future<int?> insertTraining(String name, int clientId, int category) async {
    final url =
        Uri.parse('https://shape-factory-5.onrender.com/training/insert');

    final body = {
      'name': name,
      'clientId': clientId.toString(),
      'category': category.toString(),
    };

    // Print da URL e do corpo da requisição
    print("POST $url");
    print("Body: $body");

    try {
      final response = await http.post(url, body: body);

      if (response.statusCode == 200) {
        // Aqui assumo que o ID do treino é retornado como resposta
        return int.tryParse(response.body);
      } else {
        print('Failed to insert training: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error inserting training: $error');
      return null;
    }
  }

  // Método para inserir os exercícios com os sets concatenados
  Future<void> insertExercises(int trainingId, List<Map<String, dynamic>> selectedExercises) async {
    final url = Uri.parse('https://shape-factory-5.onrender.com/recipe/insert');
    
    for (var exercise in selectedExercises) {
      String exerciseId = exercise['id'].toString();
      List<Map<String, String>> sets = exercise['sets'];

      // Concatenar as cargas e reps com "/"
      String weight = sets.map((set) => set['carga'] ?? "").join('/');
      String reps = sets.map((set) => set['reps'] ?? "").join('/');

      // Número de sets é o tamanho da lista 'sets'
      int setsCount = sets.length;

      // Parâmetros do corpo da requisição
      final body = {
        'trainingId': trainingId.toString(),
        'exerciseId': exerciseId,
        'weight': weight,
        'reps': reps,
        'sets': setsCount.toString(),
      };

      // Print da URL e do corpo da requisição
      print("POST $url");
      print("Body: $body");

      try {
        final response = await http.post(url, body: body);
        
        if (response.statusCode == 200) {
          print('Exercise $exerciseId inserted successfully');
        } else {
          print('Failed to insert exercise $exerciseId: ${response.statusCode}');
          print('Response: ${response.body}');
        }
      } catch (error) {
        print('Error inserting exercise $exerciseId: $error');
      }
    }
  }

  // Método principal que insere o treino e os exercícios
  Future<void> addTrainingWithExercises(String name, int clientId, int category,
      List<Map<String, dynamic>> selectedExercises) async {
    // Primeiro, insere o treino
    int? trainingId = await insertTraining(name, clientId, category);

    if (trainingId != null) {
      // Se o treino foi inserido com sucesso, insere os exercícios associados
      await insertExercises(trainingId, selectedExercises);
    } else {
      print('Failed to insert training.');
    }
  }

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
              const SizedBox(height: 5),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: exercise["sets"].length * 3 + 3,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 4,
                ),
                itemBuilder: (context, setIndex) {
                  if (setIndex < 3) {
                    return _gridHeader(["Set", "Carga", "Reps"][setIndex]);
                  } else {
                    final setNumber = (setIndex - 3) ~/ 3;
                    final set = exercise["sets"][setNumber];
                    final fieldIndex = (setIndex - 3) % 3;

                    if (fieldIndex == 0) {
                      return _setNumberWidget(setNumber);
                    } else if (fieldIndex == 1) {
                      return _editableField(
                        initialValue: set["carga"],
                        onChanged: (value) => set["carga"] = value,
                      );
                    } else {
                      return _editableField(
                        initialValue: set["reps"],
                        onChanged: (value) => set["reps"] = value,
                      );
                    }
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        exercise["sets"].add({"carga": "", "reps": ""});
                      });
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text("Adicionar Set",
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
        corBorda = const BorderSide(color: Colors.grey);
      });
    } else {
      setState(() {
        corBorda = const BorderSide(color: Colors.black);
      });
    }
    return Scaffold(
        backgroundColor: const Color(0xff000000),
        body: Center(
            child: Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                alignment: Alignment.topCenter,
                color: Colors.black,
                constraints: BoxConstraints(maxWidth: 550),
                child: Card(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      side: corBorda, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.white),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              constraints: BoxConstraints(maxWidth: 400),
                              child: TextFormField(
                                controller: controllerNome,
                                cursorColor: Colors.orange,
                                decoration: InputDecoration(
                                  labelText: "Nome do Treino",
                                  labelStyle:
                                      const TextStyle(color: Color(0xff9e9e9e)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xff9e9e9e)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon:
                                  const Icon(Icons.check, color: Colors.orange),
                              onPressed: () async {
                                await addTrainingWithExercises(
                                    controllerNome.text,
                                    1,
                                    widget.category,
                                    exercises);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: CustomScrollView(
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  if (index < exercises.length) {
                                    return _exerciseCard(exercises[index]);
                                  } else {
                                    return _novoExercicioButton(context);
                                  }
                                },
                                childCount: exercises.length + 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))));
  }

  Widget _novoExercicioButton(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        height: 50,
        constraints: BoxConstraints(maxWidth: 515),
        child: MaterialButton(
          color: Colors.orange,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          onPressed: () async {
            await _navigateToSelectExercise();
          },
          child: const Text(
            "Novo Exercício",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black,
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
  Widget _setNumberWidget(int setNumber) {
    var onChanged;
    return Container(
      child: TextField(
        controller: TextEditingController(text: "${setNumber + 1}"),
        onChanged: onChanged,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16, color: Colors.white),
        readOnly: true,
        cursorColor: Colors.orange,
        decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.black,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide.none),
            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
      ),
    );
  }

// Função para campos editáveis
  Widget _editableField({
    required String initialValue,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      child: TextField(
        controller: TextEditingController(
          text: initialValue,
        ),
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16),
        cursorColor: Colors.orange,
        decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Colors.orange)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange)),
            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
      ),
    );
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
}
