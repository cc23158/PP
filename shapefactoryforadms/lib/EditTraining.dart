import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shapefactoryforadms/SelectExercise.dart';
class EditTraining extends StatefulWidget {
  final category;
const EditTraining({required this.category,super.key});
  @override
   EditTrainingState createState() => EditTrainingState();
  
}

class EditTrainingState extends State<EditTraining>{
var lista = List.empty(growable: true);
  var listElemento = List<Widget>.empty(growable: true);
  bool isLoading = true; 
  String currentSearchText = '';

 


  Widget getWidget(String nome, String musculo, String imagem, int id) {
    return Card(
     
    );
  }



  @override
  void initState() {
    super.initState();
    
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