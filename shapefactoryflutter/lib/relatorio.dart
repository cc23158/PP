
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Relatorio extends StatefulWidget {
  const Relatorio({super.key});

  @override
  RelatorioState createState() => RelatorioState();
}

class RelatorioState extends State<Relatorio> {
  int totalTreinos = 10; // Exemplo de total de treinos
  String totalTempo = "15 horas"; // Exemplo de tempo total

  // Para o calendário
  final Map<DateTime, List> treinosPorDia = {
    DateTime(2024, 9, 20): ['Treino A'],
    DateTime(2024, 9, 22): ['Treino B'],
    // Adicione mais datas conforme necessário
  };

  List<DateTime> get markedDays {
    return treinosPorDia.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Total de Treinos",
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tempo Total Treinado",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      totalTempo,
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Espaço para descer o calendário
          const SizedBox(height: 40), // Altere o valor conforme necessário
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TableCalendar(
                focusedDay: DateTime.now(),
                firstDay: DateTime.now().subtract(const Duration(days: 365)),
                lastDay: DateTime.now().add(const Duration(days: 365)),
                calendarStyle: CalendarStyle(
                  // Estilo para dias sem eventos (circular cinza)
                  defaultDecoration: BoxDecoration(
                    color: const Color.fromARGB(255, 78, 78, 78).withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  // Estilo para o texto padrão (número branco)
                  defaultTextStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  // Estilo dos dias com eventos
                  markerDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  // Estilo do dia de hoje
                  todayDecoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    if (markedDays.contains(date)) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Icon(
                          Icons.circle,
                          color: Colors.blue,
                          size: 8.0,
                        ),
                      );
                    }
                    return null;
                  },
                ),
                eventLoader: (date) {
                  return treinosPorDia[date] ?? [];
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}