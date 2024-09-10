import 'package:flutter/material.dart';
import 'package:shapefactory/conta.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class Relatorio extends StatefulWidget {
  const Relatorio({super.key});
  @override
  RelatorioState createState() => RelatorioState();
}

class RelatorioState extends State<Relatorio> {
  final pageController = PageController();
  final vetorImagem = {
    "assets/images/paint.png",
    "assets/images/intermediario.png",
    "assets/images/avancado.png"
  };

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff000000),
    );
  }
}
