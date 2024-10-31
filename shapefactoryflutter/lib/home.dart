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
  final PageController cardPageController = PageController(viewportFraction: 0.9);



  double _currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
              itemCount: vetorImagens.length,
              itemBuilder: (context, index) {
                double scale = (index == _currentPageValue.round()) ? 1.0 : 0.9;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Transform.scale(
                    scale: scale,
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
                              vetorImagens[index],
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
                                  style: ElevatedButton.styleFrom(

                                  ),
                                  child: const Text('Editar'),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                  ),
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
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cardPageController.dispose();
    super.dispose();
  }
}



