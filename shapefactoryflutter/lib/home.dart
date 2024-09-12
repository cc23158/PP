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
  final vetorImagem = {
    "assets/images/paint.png",
    "assets/images/intermediario.png",
    "assets/images/avancado.png"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff000000),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(16, 30, 16, 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          "Shape",
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 22,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                        Text(
                                          "Factory",
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 22,
                                            color: Color(0xfffba808),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                                      child: Text(
                                        "Fabrique o seu corpo",
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: Stack(
                                  children: [
                                    PageView.builder(
                                      controller: pageController,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 3,
                                      itemBuilder: (context, position) {
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 8, 16, 24),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            child: Image.asset(
                                              vetorImagem.elementAt(position),
                                              height: 300,
                                              width: 200,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: SmoothPageIndicator(
                                        controller: pageController,
                                        count: 3,
                                        onDotClicked: (index) {
                                          setState(() {
                                            pageController.jumpToPage(index);
                                          });
                                        },
                                        axisDirection: Axis.horizontal,
                                        effect: const WormEffect(
                                          dotColor: Color(0xff9e9e9e),
                                          activeDotColor: Color(0xff3f51b5),
                                          dotHeight: 12,
                                          dotWidth: 12,
                                          radius: 16,
                                          spacing: 8,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Card(
                      margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                      color: Colors.grey,
                      child: ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: false,
                          physics: const ScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Card(
                                color: const Color(0xffe0e0e0),
                                shadowColor: const Color(0xff000000),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  side: const BorderSide(
                                      color: Color(0x4d9e9e9e), width: 1),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 10, 10, 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Treino A",
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 20, 0, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 5, 0),
                                              child: AnimatedButton(
                                                width: 100,
                                                height: 40,
                                                text: 'Editar',
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13,
                                                  color: Color(0xffffffff),
                                                ),
                                                isReverse: true,
                                                selectedTextColor: Colors.black,
                                                transitionType: TransitionType
                                                    .LEFT_TO_RIGHT,
                                                backgroundColor: Colors.black,
                                                borderColor: Colors.orange,
                                                borderRadius: 12,
                                                borderWidth: 2,
                                                onPress: () {},
                                              ),
                                            ),
                                            AnimatedButton(
                                              width: 100,
                                              height: 40,
                                              text: 'Começar',
                                              isReverse: true,
                                              selectedTextColor: Colors.black,
                                              transitionType:
                                                  TransitionType.LEFT_TO_RIGHT,
                                              textStyle: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13,
                                                color: Color(0xffffffff),
                                              ),
                                              backgroundColor: Colors.black,
                                              borderColor: Colors.orange,
                                              borderRadius: 12,
                                              borderWidth: 2,
                                              onPress: () {},
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: AnimatedButton(
                                text: 'Criar treino',
                                isReverse: true,
                                selectedTextColor: Colors.black,
                                transitionType: TransitionType.LEFT_TO_RIGHT,
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 13,
                                  color: Color(0xffffffff),
                                ),
                                backgroundColor: Colors.black,
                                borderColor: Colors.orange,
                                borderRadius: 12,
                                borderWidth: 2,
                                onPress: () {},
                              ),
                            )
                          ]))),
            ]));
  }
}
