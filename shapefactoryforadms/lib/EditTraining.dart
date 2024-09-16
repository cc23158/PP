import 'package:flutter/material.dart';
class EditTraining extends StatefulWidget {
const EditTraining({super.key});
  @override
   EditTrainingState createState() => EditTrainingState();
  
}

class EditTrainingState extends State<EditTraining>{
 final controllerEmail = TextEditingController();
  final controllerSenha = TextEditingController();
  var mensagemErro = "";

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
    );
  }
}