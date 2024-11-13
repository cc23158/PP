import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Relatorio extends StatefulWidget {
  const Relatorio({super.key});

  @override
  RelatorioState createState() => RelatorioState();
}

class RelatorioState extends State<Relatorio> {
  String selectedPeriod = "Semanal";
  int totalTreinos = 0;
  Map<String, int> muscleFrequency = {};
  static Map<DateTime, List> allTreinosPorDia = {};
  static List<dynamic> allTrainingData = [];
  static Map<String, String> allMuscles = {};
  List<String> periods = ["Semanal", "Mensal", "Anual"];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (allTrainingData.isEmpty) {
      fetchTrainingData();
    } else {
      filterDataByPeriod();
    }
  }

  Future<void> fetchTrainingData() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Requisição para pegar os músculos
      final muscleUrl = Uri.https(
        'shape-factory-5.onrender.com',
        '/muscle/getAll',
      );
      final muscleResponse = await http.get(muscleUrl, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      if (muscleResponse.statusCode == 200) {
        final List<dynamic> muscleData = json.decode(utf8.decode(muscleResponse.bodyBytes));

        allMuscles.clear();
        for (var muscle in muscleData) {
          allMuscles[muscle['muscle_name']] = muscle['muscle_name'];
        }

        final url = Uri.https(
          'shape-factory-5.onrender.com',
          '/history/getByClientNoDate',
          {'clientId': '6'},
        );
        final response = await http.get(url, headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        });

        if (response.statusCode == 200) {
          allTrainingData = json.decode(utf8.decode(response.bodyBytes));
          filterDataByPeriod();
        }
      }
    } catch (error) {
      print('Erro ao buscar os dados: $error');
    }

    setState(() {
      isLoading = false;
    });
  }

  void filterDataByPeriod() {
    DateTime startDate = _getStartDateForPeriod(selectedPeriod);
    DateTime endDate = DateTime.now();

    // Filtra os treinos dentro do intervalo selecionado
    List<dynamic> filteredData = allTrainingData.where((item) {
      DateTime exerciseDate = DateTime.parse(item['history_date']);
      return exerciseDate.isAfter(startDate) && exerciseDate.isBefore(endDate);
    }).toList();

    // Processa os dados dos treinos
    Map<DateTime, List> groupedExercises = {};
    Map<String, int> muscleCounter = Map.from(allMuscles.map((key, value) => MapEntry(key, 0)));

    for (var item in filteredData) {
      DateTime exerciseDate = DateTime.parse(item['history_date']);
      String muscleName = item['history_exercise']['exercise_muscle']['muscle_name'];

      // Agrupa exercícios pela data
      groupedExercises.putIfAbsent(exerciseDate, () => []).add(item);

      // Conta a frequência dos músculos
      if (muscleCounter.containsKey(muscleName)) {
        muscleCounter[muscleName] = (muscleCounter[muscleName] ?? 0) + 1;
      }
    }

    setState(() {
      allTreinosPorDia = groupedExercises;
      totalTreinos = groupedExercises.keys.length;
      muscleFrequency = muscleCounter;
    });
  }

  DateTime _getStartDateForPeriod(String period) {
    DateTime now = DateTime.now();
    switch (period) {
      case 'Semanal':
        return now.subtract(Duration(days: now.weekday - 1));
      case 'Mensal':
        return DateTime(now.year, now.month, 1);
      case 'Anual':
        return DateTime(now.year, 1, 1);
      default:
        return DateTime(2000);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: Stack(children: [ Padding(
        padding: EdgeInsets.fromLTRB(16, 30, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.fromLTRB(4, 0, 0, 0), child:  const Text(
              "Relatório",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22,
                color: Colors.white,
              ),
            ),),
           
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: periods.map((period) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(
                      period,
                      style: TextStyle(
                        color: selectedPeriod == period ? Colors.black : Colors.white,
                      ),
                    ),
                    selected: selectedPeriod == period,
                    selectedColor: Colors.orange,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          selectedPeriod = period;
                          filterDataByPeriod();
                        });
                      }
                    },
                    backgroundColor: Colors.grey[800],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else
              ...[
                Card(
                  color: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          "Dias Treinados",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          "$totalTreinos",
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  color: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                      children: [
                        const Text(
                          "Músculos Mais Treinados",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(height: 50,),
                        SizedBox(
                          height: 250,
                          
                          child: RadarChart(
                            RadarChartData(
                              titleTextStyle: TextStyle(color: Colors.white54),
                              getTitle: (value, angle) {
                                var muscles = muscleFrequency.keys.toList();
                                return muscles.isNotEmpty
                                    ? RadarChartTitle(
                                        text: muscles[value.toInt() % muscles.length].toString(),
                                      )
                                    : const RadarChartTitle(text: '');
                              },
                              borderData: FlBorderData(show: false),
                              radarShape: RadarShape.circle,
                              dataSets: [
                                RadarDataSet(
                                  dataEntries: muscleFrequency.values
                                      .map((value) => RadarEntry(value: value.toDouble()))
                                      .toList(),
                                  borderColor: Colors.orange,
                                  fillColor: Colors.orange.withOpacity(0.3),
                                  entryRadius: 3,
                                  borderWidth: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                         SizedBox(height: 50,)
                      ],
                    ),
                  ),
                ),
               
              ],
          ],
        ),
      ),

   ] ));
  }
}