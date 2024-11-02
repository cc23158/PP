import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shapefactory/conta.dart';
import 'package:shapefactory/home.dart';
import 'package:shapefactory/relatorio.dart';
import 'package:http/http.dart' as http;

class CentralPage extends StatefulWidget {
  final int clientId;
  const CentralPage({required this.clientId,super.key});

  @override
  State<StatefulWidget> createState() => CentralPageState();
}

class CentralPageState extends State<CentralPage> {
  late List<Widget> _pages;
  var _selectedIndex = 0;
    bool isLoading = true;
  
  List<Map<String, dynamic>> lista = List.empty(growable: true);
  
  var listMuscles = List.empty(growable: true);

Future<void> getExercises({int maxRetries = 3, int currentRetry = 0}) async {

    try {
      final response = await http.get(
        Uri.parse('https://shape-factory-5.onrender.com/exercise/getAll'),
      );

      if (response.statusCode == 200) {
        List<dynamic> decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));

        if (decodedResponse.isEmpty && currentRetry < maxRetries) {
          // Se a lista está vazia e ainda não atingimos o número máximo de tentativas
          print('Tentativa ${currentRetry + 1}: Lista vazia recebida, tentando novamente...');
          
          // Espera um tempo crescente entre as tentativas (0.5s, 1s, 1.5s, etc)
          await Future.delayed(Duration(milliseconds: 500 * (currentRetry + 1)));
          
          // Faz uma nova tentativa
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
print(lista.toString());
isLoading = false;
          });
        } else {
          print("Resposta não é uma lista");
        }
      } else {
        print("Erro na resposta: ${response.statusCode}");

      }
    } catch (erro) {
      print("Erro ao buscar exercícios: ${erro.toString()}");

    }
}

// Função auxiliar para tratamento de erro

// Modifique a função fetchExercises para usar as novas opções
void fetchExercises() async {
  await getExercises(maxRetries: 3);
  setState(() {
      _pages = <Widget>[Home(clientId: widget.clientId, lista: lista, listaMuscle: listMuscles,), const Relatorio(), Conta()]; 
  });

}




@override
  void initState() {
    fetchExercises();
    
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    print(widget.clientId);
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading ? Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.orange, size: 50),) : Center(
        child: _pages.elementAt(_selectedIndex), // New
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.article_rounded), label: "Relatório"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Conta"),
        ],
        backgroundColor: Colors.black,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}







