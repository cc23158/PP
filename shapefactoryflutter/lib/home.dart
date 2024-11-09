import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shapefactory/EditTraining.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shapefactory/StartTraining.dart';

class Home extends StatefulWidget {
  final clientId;
  const Home({required this.clientId, super.key});
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final pageController = PageController();


  double _currentPageValue = 1000.0;

  var listaMestra = List.empty(growable: true);
  final List<String> vetorImagens = [
    "assets/images/paint.png",
    "assets/images/intermediario.png",
    "assets/images/avancado.png",
    "assets/images/musculos.png"
  ];
  var cardPageController = PageController(
    viewportFraction: 0.85,
    initialPage: 1000,
  );

  List<Map<String, dynamic>> clientTrainings = [];
  List<Map<String, dynamic>> defaultTrainings = [];

  List<Widget> clientTrainingsWidgets = List<Widget>.empty();

  List<Widget> defaultTrainingsCategory1 = List<Widget>.empty();

  List<Widget> defaultTrainingsCategory3 = List<Widget>.empty();

  List<Widget> defaultTrainingsCategory2 = List<Widget>.empty();

  bool isLoading = false;

  var controllerList = ScrollController();

  @override
  void initState() {
    super.initState();

    // Initialize PageController

    cardPageController.addListener(() {
      setState(() {
        _currentPageValue = cardPageController.page ?? 1000;
      });
    });

    // Fetch trainings when the page initializes
    fetchTrainings();
  }

  Widget getWidgetClient(Map<String, dynamic> treino) {
    return GestureDetector(
      onTap: () async {
        if (StartTraining.trainingIdAtivo == - 1 || StartTraining.trainingIdAtivo == treino['training_id']){
  await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StartTraining(
              category: 1,
              nome: treino['training_name'],
              trainingId: treino['training_id'],
              clientId: widget.clientId,
            ),
          ),
        );
        setState(() {
          
        });
        }
        else{
           showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: const Color.fromARGB(255, 32, 32, 32),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        title: const Text('Treino em andamento',
                                            style: TextStyle(
                                              color: Colors.white70,
                                            )),
                                        content: const Text(
                                            'Por favor, termine seu treino atual antes de começar outro',
                                            style: TextStyle(
                                              color: Colors.white70,
                                            )),
                                        actions: <Widget>[
                                          MaterialButton(
                                              color: Colors.orange,
                                              child: const Text("OK",
                                                  style: TextStyle(
                                                    color: Colors.white70,
                                                  )),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              })
                                        ],
                                      );
                                    },
                                  );
        }
      
      },
      child: Card(
        color: const Color(0xffe0e0e0),
        shadowColor: const Color(0xff000000),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  treino['training_name'] ?? "Treino",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (String value) {
                  if (value == 'Editar') {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditTraining(
                          category: 1,
                          trainingId: treino['training_id'],
                          clientId: widget.clientId,
                          nome: treino["training_name"],
                        ),
                      ),
                    );
                  } else if (value == 'Excluir') {
                    deleteTraining(treino['training_id']);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem<String>(
                      value: 'Editar',
                      child: Text('Editar'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Excluir',
                      child: Text('Excluir'),
                    ),
                  ];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getWidgetDefault(Map<String, dynamic> treino) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
      child: Card(
        color: const Color(0xffe0e0e0),
        shadowColor: const Color(0xff000000),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  treino['training_name'] ?? "Treino",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    height: 52,
                    color: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onPressed: () async {},
                    child: const Text(
                      'Adicionar a meus treinos',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchTrainings() async {
    setState(() {
      isLoading = true;
    });
    try {
      // Fetch client-specific trainings
      final clientTrainingsList = await getTraining(widget.clientId);

      // Fetch default trainings
      final defaultTrainingsList =
          await getTraining(1); // Assuming 1 is for default trainings

      setState(() {
        // Agrupa os treinos do usuário pelo ID do cliente
        clientTrainingsWidgets = clientTrainingsList
            .map((treino) => getWidgetClient(treino))
            .toList();

        // Filtra e agrupa treinos padrão por categoria
        defaultTrainingsCategory1 = defaultTrainingsList
            .where((training) => training['training_category'] == 1)
            .map((treino) => getWidgetDefault(treino))
            .toList();

        defaultTrainingsCategory2 = defaultTrainingsList
            .where((training) => training['training_category'] == 2)
            .map((treino) => getWidgetDefault(treino))
            .toList();

        defaultTrainingsCategory3 = defaultTrainingsList
            .where((training) => training['training_category'] == 3)
            .map((treino) => getWidgetDefault(treino))
            .toList();
        listaMestra.clear();
        listaMestra.add(clientTrainingsWidgets);
        listaMestra.add(defaultTrainingsCategory1);
        listaMestra.add(defaultTrainingsCategory2);
        listaMestra.add(defaultTrainingsCategory3);

        isLoading = false;
      });
    } catch (error) {
      print('Error fetching trainings: $error');
    }
  }

  Future<int> deleteTraining(int id) async {
    try {
      final queryParameters = {
        'id': id.toString(),
      };
      final response = await http.delete(
        Uri.https('shape-factory-5.onrender.com', '/training/delete',
            queryParameters),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          fetchTrainings();
        });
        return 1;
      } else {
        throw Exception('Falha ao deletar');
      }
    } catch (erro) {
      print(erro.toString());
      return 0;
    }
  }

  Future<List<Map<String, dynamic>>> getTraining(int id) async {
    final url = Uri.parse(
        'https://shape-factory-5.onrender.com/training/getByClient?clientId=$id');

    print("GET $url");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print('Trainings obtained successfully: ${response.body}');

        final List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse
            .map((item) => item as Map<String, dynamic>)
            .toList();
      } else {
        print('Failed to obtain trainings: ${response.statusCode}');
        print('Response: ${response.body}');
        return [];
      }
    } catch (error) {
      print('Error obtaining trainings: $error');
      return [];
    }
  }
void _showTrainingBottomSheet(BuildContext context, int trainingId, int clientId, String nome) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return _AnimatedSlideBottomSheetContent(
            trainingId: trainingId,
            clientId: clientId,
            nome: nome,
          );
        },
      );
    },
  );

  // Atualiza o estado após retornar de StartTraining
  if (StartTraining.trainingTime.value == Duration.zero) {
    setState(() {
      // Isso forçará uma atualização da interface, fazendo a barra desaparecer
    });
  }
}

 Widget buildTrainingBottomBar(BuildContext context, String trainingName) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12), // Arredondamento das bordas
      child: BottomAppBar(
        color: Colors.grey[900], // Cor de fundo similar ao Spotify
        child: GestureDetector(
          onTap: () {
            _showTrainingBottomSheet(
              context,
              StartTraining.trainingIdAtivo,
              widget.clientId,
              StartTraining.trainingNameAtivo,
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Nome do treino
                Expanded(
                  child: Text(
                    trainingName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis, // Trunca se o nome for longo
                  ),
                ),
                // Temporizador de treino
                ValueListenableBuilder<Duration>(
                  valueListenable: StartTraining.trainingTime,
                  builder: (context, duration, child) {
                    final hours = duration.inHours.toString().padLeft(2, '0');
                    final minutes = duration.inMinutes
                        .remainder(60)
                        .toString()
                        .padLeft(2, '0');
                    final seconds = duration.inSeconds
                        .remainder(60)
                        .toString()
                        .padLeft(2, '0');
                    return Text(
                      '$hours:$minutes:$seconds',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

  Widget ClientListCard(List<Widget> lista) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 50), // Remove padding padrão da ListView
      controller: controllerList,
      shrinkWrap: true,
      itemCount: lista.length + 1,
      itemBuilder: (context, int i) {
        if (i < lista.length) {
          return Container(
            child: lista[i],
          );
        } else {
          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 20),
            child: MaterialButton(
              height: 50,
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditTraining(
                      category: 1,
                      trainingId: 0,
                      clientId: widget.clientId,
                      nome: "",
                    ),
                  ),
                );
                await fetchTrainings();
              },
              color: Colors.orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(Icons.add),
                  Text(
                    "Adicionar",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget DefaultListCard(List<Widget> lista) {
    return RawScrollbar(
      thumbColor: Colors.orange,
      controller: controllerList,
      interactive: true,
      radius: const Radius.circular(12),
      child: ListView.builder(
        padding: EdgeInsets.zero, // Remove padding padrão da ListView
        controller: controllerList,
        itemCount: lista.length,
        itemBuilder: (context, int i) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: lista[i],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff000000),
        body: isLoading
            ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.orange, size: 50),
              )
            : Stack(
                children: [
                  Column(
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
                      Flexible(
                        flex: 1,
                        child: PageView.builder(
                          controller: cardPageController,
                          itemBuilder: (context, index) {
                            // Calcula o índice real para o loop infinito
                            final realIndex = (index % vetorImagens.length +
                                    vetorImagens.length) %
                                vetorImagens.length;

                            // Calcula a diferença entre o índice atual e a página atual
                            final difference =
                                (index - _currentPageValue).abs();
                            // Aplica uma escala suave baseada na diferença
                            final scale =
                                1 - (difference * 0.1).clamp(0.0, 0.1);

                            return TweenAnimationBuilder(
                              duration: const Duration(milliseconds: 100),
                              tween: Tween(begin: scale, end: scale),
                              builder: (context, double value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 16),
                                    child: Card(
                                      color: Colors.white70,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      clipBehavior: Clip
                                          .antiAlias, // Adiciona clipping no Card
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Image.asset(
                                            vetorImagens[realIndex],
                                            fit: BoxFit.cover,
                                            height: 180,
                                            width: double.infinity,
                                          ),
                                          Expanded(
                                            child: (realIndex == 0)
                                                ? ClientListCard(
                                                    listaMestra[realIndex])
                                                : DefaultListCard(
                                                    listaMestra[realIndex]),
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
                  if (StartTraining.trainingIdAtivo != -1)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: buildTrainingBottomBar(
                          context,
                          StartTraining
                              .trainingNameAtivo), // Passe o nome do treino
                    ),
                ],
              ));
  }
}

class _AnimatedSlideBottomSheetContent extends StatefulWidget {
  final int trainingId;
  final int clientId;
  final String nome;

  const _AnimatedSlideBottomSheetContent({
    required this.trainingId,
    required this.clientId,
    required this.nome,
  });

  @override
  _AnimatedSlideBottomSheetContentState createState() =>
      _AnimatedSlideBottomSheetContentState();
}

class _AnimatedSlideBottomSheetContentState extends State<_AnimatedSlideBottomSheetContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500), // Duração da animação de surgimento
      vsync: this,
    );

    // Define a animação para deslizar de baixo para cima
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Começa abaixo da tela
      end: Offset(0, 0),   // Termina na posição original
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Inicia a animação ao construir o widget
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: DraggableScrollableSheet(
        initialChildSize: 1,
        minChildSize: 0.4,
        maxChildSize: 1,
        builder: (BuildContext context, ScrollController scrollController) {
          return StartTraining(
            category: 1,
            trainingId: widget.trainingId,
            clientId: widget.clientId,
            nome: widget.nome,
          );
        },
      ),
    );
  }
}