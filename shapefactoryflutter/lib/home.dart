import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shapefactory/ActiveTrainingBar.dart';
import 'package:shapefactory/EditTraining.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shapefactory/StartTraining.dart';

class Home extends StatefulWidget {
  final clientId;
  Home({required this.clientId, super.key});
  static List listaCompleta = List.empty(growable: true);
  static List<Map<String, dynamic>> clientTrainingsList = [];
  static List<Map<String, dynamic>> defaultTrainingsList = [];
  static int clientIdAtivo = 0;
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final pageController = PageController();

  double _currentPageValue = 1000.0;

  var listaMestra = List.empty(growable: true);
  final List<String> vetorImagens = [
    "assets/images/MeusTreinos.png",
    "assets/images/Superiores.png",
    "assets/images/Inferiores.png",
    "assets/images/Full-body.png"
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
    Home.clientIdAtivo = widget.clientId;
    cardPageController.addListener(() {
      setState(() {
        _currentPageValue = cardPageController.page ?? 1000;
      });
    });
    if (Home.listaCompleta.isEmpty) {
      fetchTrainings();
    } else {
      setState(() {
        fetchTrainings();
      });
    }
  }

  void _showTrainingBottomSheet(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return AnimatedTrainingSheet(
            trainingId: StartTraining.trainingIdAtivo,
            clientId: widget.clientId,
            nome: StartTraining.trainingNameAtivo,
          );
        },
      );
    },
  );

  if (StartTraining.trainingTime.value == Duration.zero) {
    setState(() {
      fetchTrainings();
    });
  }
}

  Widget getWidgetClient(Map<String, dynamic> treino) {
    return GestureDetector(
        onTap: () async {
          if (StartTraining.trainingIdAtivo == -1 ||
              StartTraining.trainingIdAtivo == treino['training_id']) {
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
            setState(() {});
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 32, 32, 32),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
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
          setState(() {
            fetchTrainings();
          });
        },
        child: Card(
          color: Colors.black45,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
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
                      color: Colors.white,
                    ),
                  ),
                ),
                treinoAtivo(treino)
              ],
            ),
          ),
        ));
  }

  Widget treinoAtivo(treino) {
    if (StartTraining.trainingIdAtivo != treino['training_id']) {
      // Condição para mostrar o ícone apenas se não for o treino ativo
      return PopupMenuButton<String>(
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        onSelected: (String value) async {
          if (value == 'Editar') {
            bool result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditTraining(
                  category: 1,
                  trainingId: treino['training_id'],
                  clientId: widget.clientId,
                  nome: treino["training_name"],
                ),
              ),
            );
            if (result == true) {
              Home.listaCompleta.clear();
              Home.clientTrainingsList.clear();
              Home.defaultTrainingsList.clear();
              fetchTrainings();
            }
          } else if (value == 'Excluir') {
            setState(() {
              deleteTraining(treino['training_id']);
            });
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
      );
    } else {
      // Placeholder para ocupar o espaço do PopupMenuButton
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
        child: SizedBox(
          height: 45,
          child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.orange, size: 24),
        ),
      );
    }
  }

  Widget getWidgetDefault(Map<String, dynamic> treino) {
  return GestureDetector(
    onTap: () async {
      if (StartTraining.trainingIdAtivo == -1 ||
          StartTraining.trainingIdAtivo == treino['training_id']) {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StartTraining(
              category: 1,
              nome: treino['training_name'],
              trainingId: treino['training_id'],
              clientId: 1,
            ),
          ),
        );
        setState(() {});
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color.fromARGB(255, 32, 32, 32),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: const Text(
                'Treino em andamento',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              content: const Text(
                'Por favor, termine seu treino atual antes de começar outro',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                  color: Colors.orange,
                  child: const Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      }
      setState(() {
        fetchTrainings();
      });
    },
    child: Card(
      color: Colors.black45,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
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
                  color: Colors.white,
                ),
              ),
            ),
            if (StartTraining.trainingIdAtivo == treino['training_id'])
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: SizedBox(
                  height: 45,
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.orange,
                    size: 24,
                  ),
                ),
              )
            else
              const SizedBox(height: 45),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () async{
                await copyTraining(widget.clientId, treino);
              },
            ),
          ],
        ),
      ),
    ),
  );
}


  Future<void> fetchTrainings() async {
    try {
      if (Home.listaCompleta.isEmpty) {
        setState(() {
          isLoading = true;
        });
        // Fetch client-specific trainings
        Home.clientTrainingsList = await getTraining(widget.clientId);

        // Fetch default trainings
        Home.defaultTrainingsList =
            await getTraining(1); // Assuming 1 is for default trainings
      }

      setState(() {
        // Agrupa os treinos do usuário pelo ID do cliente
        clientTrainingsWidgets = Home.clientTrainingsList
            .map((treino) => getWidgetClient(treino))
            .toList();

        // Filtra e agrupa treinos padrão por categoria
        defaultTrainingsCategory1 = Home.defaultTrainingsList
            .where((training) => training['training_category'] == 1)
            .map((treino) => getWidgetDefault(treino))
            .toList();

        defaultTrainingsCategory2 = Home.defaultTrainingsList
            .where((training) => training['training_category'] == 2)
            .map((treino) => getWidgetDefault(treino))
            .toList();

        defaultTrainingsCategory3 = Home.defaultTrainingsList
            .where((training) => training['training_category'] == 3)
            .map((treino) => getWidgetDefault(treino))
            .toList();
        Home.listaCompleta.clear();
        Home.listaCompleta.add(clientTrainingsWidgets);
        Home.listaCompleta.add(defaultTrainingsCategory1);
        Home.listaCompleta.add(defaultTrainingsCategory2);
        Home.listaCompleta.add(defaultTrainingsCategory3);

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
          Home.listaCompleta.clear();
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
                bool result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditTraining(
                      category: 1,
                      trainingId: 0,
                      clientId: widget.clientId,
                      nome: "",
                    ),
                  ),
                );
                if (result == true) {
                  Home.listaCompleta.clear();
                  Home.clientTrainingsList.clear();
                  Home.defaultTrainingsList.clear();
                  fetchTrainings();
                }
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
            child: lista[i],
          );
        },
      ),
    );
  }

Future<void> copyTraining(int clientId, dynamic treino) async {
  final url = Uri.parse('https://shape-factory-5.onrender.com/recipe/copy'); // Coloque sua URL completa aqui
  try {
    final response = await http.post(
      url,
      body: {
        'clientId': clientId.toString(),
        'trainingId': treino['training_id'].toString(),
      },
    );
    if (response.statusCode == 200) {
      print('Training copied successfully');
      setState(() {
        Home.clientTrainingsList.add(treino);
        fetchTrainings();
      });
    } else {
      print('Failed to copy training: ${response.body}');
    }
  } catch (e) {
    print('Error copying training: $e');
  }
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
                        padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
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
                              duration: const Duration(milliseconds: 50),
                              tween: Tween(begin: scale, end: scale),
                              builder: (context, double value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 16),
                                    child: Card(
                                      color: Colors.white24,
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
                                                ? ClientListCard(Home
                                                    .listaCompleta[realIndex])
                                                : DefaultListCard(Home
                                                    .listaCompleta[realIndex]),
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
                  ActiveTrainingBar(
                        clientId: widget.clientId, onTap: _showTrainingBottomSheet,)
                    
                ],
              ));
  }

  
}
