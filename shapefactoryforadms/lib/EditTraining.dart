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
  bool isLoading = false;
  String currentSearchText = '';
  final List<Map<String, dynamic>> exercises = [
    {
      "id": 1,
      "name": "Supino",
      "musculo": "Peitoral",
      "image": "https://picsum.photos/250?image=9",
      "sets": [
        {"carga": "50kg", "reps": "10"}
      ]
    },
  ];

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xff000000),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: exercises.isEmpty // Verifica se a lista está vazia
          ? Center(
              child: Text(
                "Nenhum exercício encontrado.",
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: exercises.length + 1,
              itemBuilder: (context, index) {
                if (index < exercises.length) {
                  final exercise = exercises[index];
                  return Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 500),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        color: const Color(0xffe0e0e0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
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
    childAspectRatio: 2, // Igualar a altura e a largura
    crossAxisSpacing: 15,
    mainAxisSpacing: 2,
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
                                padding: const EdgeInsets.only(top: 8.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        exercise["sets"].add({"carga": "", "reps": ""});
                                      });
                                    },
                                    icon: const Icon(Icons.add, color: Colors.black),
                                    label: const Text("Adicionar Set", style: TextStyle(color: Colors.black)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange,
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
                    ),
                  );
                } else {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        width: 500,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SelectExercise()),
                            );
                          },
                          child: const Text(
                            "Adicionar Novo Exercício",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange, // Mesma cor de fundo
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),)))));
                }
              },
            ),
    ),
  );
}}

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
      
      controller: TextEditingController(text: "${setNumber+1}"),
      onChanged: onChanged,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 16, color: Colors.white),
      readOnly: true,
      cursorColor: Colors.orange,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.black,
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none),
        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 10)
        
        
        
      ),
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
      controller: TextEditingController(text: initialValue),
      onChanged: onChanged,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 16),
      cursorColor: Colors.orange,
      decoration: const InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(color: Colors.orange)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 10)
        
      ),
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
        padding: const EdgeInsets.all(5),
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