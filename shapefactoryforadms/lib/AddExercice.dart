import 'package:flutter/material.dart';

class AddExercice extends StatefulWidget {
const AddExercice({super.key});
  @override
   AddExerciceState createState() => AddExerciceState();
  
}

class AddExerciceState extends State<AddExercice>{
 final controllerEmail = TextEditingController();
  final controllerSenha = TextEditingController();
  var mensagemErro = "";

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
    );
  }
}