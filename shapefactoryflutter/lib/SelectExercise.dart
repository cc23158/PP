import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class SelectExercise extends StatefulWidget {
  final selectedExercises;
  const SelectExercise({this.selectedExercises ,super.key});
  @override
  SelectExerciseState createState() => SelectExerciseState();
}

class SelectExerciseState extends State<SelectExercise> {
  final scrollController = ScrollController();
  var lista = List.empty(growable: true);
  var listElemento = List<Widget>.empty(growable: true);
  bool isLoading = true;
  var selectedMuscles = List.empty(growable: true);
  var listMuscles = List<String>.empty(growable: true);
  String currentSearchText = '';
  ValueNotifier<List<dynamic>> selectedExercisesNotifier = ValueNotifier([]);

  void _applyFilters(String value) {
    setState(() {
      listElemento = lista.where((exercise) {
        bool matchesText = exercise['exercise_name']
            .toLowerCase()
            .contains(value.toLowerCase());

        bool matchesMuscles = selectedMuscles.isEmpty ||
            selectedMuscles.any((selectedMuscle) =>
                selectedMuscle.toLowerCase() ==
                exercise['exercise_muscle']['muscle_name'].toLowerCase());

        return matchesText && matchesMuscles;
      }).map<Widget>((exercise) {
        return getWidget(
          exercise['exercise_name'],
          exercise['exercise_muscle']['muscle_name'],
          exercise['exercise_image'],
          exercise['exercise_id'],
        );
      }).toList();
    });
  }



  void _showFilterBottomSheet(BuildContext context, List<String> muscles) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.4,
              maxChildSize: 0.8,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.close, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Selecione Músculos',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Wrap(
                              spacing:
                                  8.0, 
                              runSpacing:
                                  8.0, 
                              children: muscles.map((muscle) {
                                bool isSelected =
                                    selectedMuscles.contains(muscle);

                                return GestureDetector(
                                  onTap: () {
                                    setModalState(() {
                                      if (isSelected) {
                                        setState(() {
                                          selectedMuscles.remove(muscle);
                                        });
                                      } else {
                                        setState(() {
                                          selectedMuscles.add(muscle);
                                        });
                                      }
                                      _applyFilters(currentSearchText);
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors
                                              .orange 
                                          : const Color.fromARGB(255, 50, 50,
                                              50),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      muscle,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget getWidget(String nome, String musculo, String imagem, int id) {
    return ValueListenableBuilder<List<dynamic>>(
      valueListenable: selectedExercisesNotifier,
      builder: (context, selectedExercises, child) {
        bool isSelected = selectedExercises.contains(id);
        return GestureDetector(
           onTap: () {
            if (isSelected) {
              selectedExercisesNotifier.value.remove(id);
            } else {
              selectedExercisesNotifier.value.add(id);
            }
            selectedExercisesNotifier.notifyListeners();
          },
          child: Card(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            color: isSelected ? Colors.orange : const Color(0xffffffff),
            shadowColor: const Color(0x4d939393),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xfff2f2f2),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            nome,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color:
                                  isSelected ? Colors.white : Color(0xff000000),
                            ),
                          ),
                          Text(
                            musculo,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: isSelected
                                  ? Colors.white70
                                  : Color(0xff6c6c6c),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (isSelected) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          (selectedExercises.indexOf(id) + 1)
                              .toString(), 
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

Future<void> getExercises({int maxRetries = 10, int currentRetry = 0}) async {
    if (currentRetry == 0) {

    }

    try {
      final response = await http.get(
        Uri.parse('https://shape-factory-5.onrender.com/exercise/getAll'),
      );

      if (response.statusCode == 200) {
        List<dynamic> decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));

        if (decodedResponse.isEmpty && currentRetry < maxRetries) {
          print('Tentativa ${currentRetry + 1}: Lista vazia recebida, tentando novamente...');
          
          await Future.delayed(Duration(milliseconds: 500 * (currentRetry + 1)));
          
          return getExercises(
            maxRetries: maxRetries,
            currentRetry: currentRetry + 1,
          );
        }

        if (decodedResponse is List) {
          setState(() {
            lista = decodedResponse.map((exercise) {
              if (listMuscles.contains(exercise['exercise_muscle']['muscle_name']) == false) {
                listMuscles.add(exercise['exercise_muscle']['muscle_name']);
              }
              return {
                'exercise_id': exercise['exercise_id'],
                'exercise_name': exercise['exercise_name'],
                'exercise_image': exercise['exercise_image'],
                'exercise_muscle': {
                  'muscle_name': exercise['exercise_muscle']['muscle_name']
                }
              };
            }).toList();

            listElemento = lista.map<Widget>((exercise) {
              return getWidget(
                exercise['exercise_name'],
                exercise['exercise_muscle']['muscle_name'],
                exercise['exercise_image'],
                exercise['exercise_id'],
              );
            }).toList();

            isLoading = false;
          });
        } else {
          print("Resposta não é uma lista");
          _handleError("Formato de resposta inválido");
        }
      } else {
        print("Erro na resposta: ${response.statusCode}");
        _handleError("Erro ao carregar exercícios");
      }
    } catch (erro) {
      print("Erro ao buscar exercícios: ${erro.toString()}");
      _handleError("Erro ao carregar exercícios");
    }
}

void _handleError(String message) {
  setState(() {
    isLoading = false;
  });
  
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Tentar Novamente',
        textColor: Colors.white,
        onPressed: () {
          getExercises();
        },
      ),
    ),
  );
}

void fetchExercises() async {
  await getExercises(maxRetries: 3);
}

  @override
  void initState() {
    super.initState();
    fetchExercises();
        selectedExercisesNotifier = ValueNotifier<List<dynamic>>(
      widget.selectedExercises.map((e) => e["id"]).toList(),
    );
    print("teste");
    print(lista);
  }

 

    @override
  void dispose() {
    selectedExercisesNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        floatingActionButton: FloatingActionButton(
   onPressed: () {
  final selectedIds = selectedExercisesNotifier.value;

List<Map<String, dynamic>> getSets(String exerciseId) {
  final exerciseWithSets = widget.selectedExercises.firstWhere(
    (e) => e['id'].toString() == exerciseId,
    orElse: () => <String, dynamic>{},
  );

  return (exerciseWithSets['sets'] ?? [{"carga": "", "reps": "", "isCompleted": false}]).map<Map<String, dynamic>>((set) {
    return {
      ...Map<String, dynamic>.from(set), 
      'isCompleted': set.containsKey('isCompleted') ? set['isCompleted'] : false, 
    };
  }).toList();
}

        final selectedExercises = selectedIds.map((id) {
          final exercise = lista.firstWhere((e) => e['exercise_id'] == id);

          return {
            'id': exercise['exercise_id'],
            'name': exercise['exercise_name'],
            'musculo': exercise['exercise_muscle']['muscle_name'],
            'image': exercise['exercise_image'],
            'sets': getSets(exercise['exercise_id'].toString()),
          };
        }).toList();

        print(selectedExercises.toString());
        Navigator.of(context).pop(selectedExercises);
}
,
          backgroundColor: Colors.orange,
          child: Icon(Icons.check, color: Colors.white),
        ),
        backgroundColor: const Color(0xff000000),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          child: isLoading
              ? const Center(
                  child:
                      CircularProgressIndicator(color: Colors.orange,)) 

              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.05,
                          20,
                          MediaQuery.of(context).size.width * 0.05,
                          10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: TextFormField(
                              cursorColor: Colors.orange,
                              onChanged: (value) => {
                                setState(() {
                                  currentSearchText = value;
                                }),
                                _applyFilters(value)
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
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.filter_list,
                              color: Colors.white,
                            ),
                            onTap: () {
                              _showFilterBottomSheet(context, listMuscles);
                            },
                          )
                        ],
                      ),
                    ),
                    if (selectedMuscles.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: MediaQuery.of(context).size.width * 0.02,
                        ),
                        child: Wrap(
                          spacing: 8.0, 
                          runSpacing: 8,
                          children: selectedMuscles.map((muscle) {
                            return Chip(
                              side: BorderSide(style: BorderStyle.none),
                              label: Text(
                                muscle,
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.orange,
                              deleteIcon: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onDeleted: () {
                                setState(() {
                                  selectedMuscles.remove(muscle);
                                  _applyFilters(currentSearchText);
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    Expanded(
                      child: RawScrollbar(
                        thumbColor: Colors.orange,
                        controller: scrollController,
                        padding: EdgeInsets.only(bottom: 15),
                        thumbVisibility:
                            true, 
                        thickness: 6, 
                        radius: const Radius.circular(
                            10),
                        child: ListView(
                          controller: scrollController,
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.02,
                              0,
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