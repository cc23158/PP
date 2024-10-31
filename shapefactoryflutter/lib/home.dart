import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final pageController = PageController();

  final List<PageController> treinoPageControllers = [
    PageController(),
    PageController(),
    PageController()
  ];


  final List<String> vetorImagens = [
    "assets/images/paint.png",
    "assets/images/intermediario.png",
    "assets/images/avancado.png"
  ];
  late PageController cardPageController;



double _currentPageValue = 0.0;

  Future<List<Map<String, dynamic>>> getTraining(int id) async {
    final url = Uri.parse(
        'https://shape-factory-5.onrender.com/training/getByClient?clientId=$id');

    // Print da URL da requisição
    print("GET $url");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print('Treinos obtidos com sucesso: ${response.body}');

        // Decodifica o JSON e retorna a lista de treinos
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse
            .map((item) => item as Map<String, dynamic>)
            .toList();
      } else {
        print('Falha ao obter treinos: ${response.statusCode}');
        print('Response: ${response.body}');
        return [];
      }
    } catch (error) {
      print('Erro ao obter treinos: $error');
      return [];
    }
  }

@override
void initState() {
  super.initState();
  cardPageController = PageController(
    viewportFraction: 0.85, // Ajusta o quanto do próximo card será visível
    initialPage: 0,
  );
  cardPageController.addListener(() {
    setState(() {
      _currentPageValue = cardPageController.page ?? 0;
    });
  });


}

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xff000000),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 30, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Shape",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: Color(0xffffffff),
                ),
              ),
              Text(
                "Factory",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: Color(0xfffba808),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Text(
            "Fabrique o seu corpo",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xffffffff),
            ),
          ),
        ),
        Expanded(
          child: PageView.builder(
            controller: cardPageController,
            itemCount: null, // Permite scroll infinito
            itemBuilder: (context, index) {
              // Calcula o índice real para o loop infinito
              final realIndex = index % vetorImagens.length;
              
              // Calcula a diferença entre o índice atual e a página atual
              final difference = (index - _currentPageValue).abs();
              // Aplica uma escala suave baseada na diferença
              final scale = 1 - (difference * 0.1).clamp(0.0, 0.1);
              
              return TweenAnimationBuilder(
                duration: const Duration(milliseconds: 100),
                tween: Tween(begin: scale, end: scale),
                builder: (context, double value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                      child: Card(
                        color: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.asset(
                                vetorImagens[realIndex],
                                fit: BoxFit.cover,
                                height: 200,
                                width: double.infinity,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Treino A",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Editar'),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Começar'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    ),
  );
}}