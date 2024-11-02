import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shapefactory/EditTraining.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Home extends StatefulWidget {
  final clientId;
  const Home({required this.clientId, super.key});
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
return Card(
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
                    onPressed: () {
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
                    },
                    child: const Text(
                      'Editar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 5),
                  MaterialButton(
                    color: Colors.red,
                    minWidth: 52,
                    height: 52,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.red),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Icon(Icons.delete, color: Colors.white),
                    onPressed: () async {
                      await deleteTraining(treino['training_id']);
                    },
                  ),
                ],
              ),
            ],
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
                    onPressed: () async{
                      
                    },
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
        clientTrainingsWidgets =
            clientTrainingsList.map((treino) => getWidgetClient(treino)).toList();

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

      isLoading = false;});

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

Widget ClientListCard(List<Widget> lista) {
  return 
    ListView.builder(
      padding: EdgeInsets.only(bottom: 50), // Remove padding padrão da ListView
      controller: controllerList,
      shrinkWrap: true,
      itemCount: lista.length + 1,
      itemBuilder: (context, int i) {
        if (i < lista.length) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8 ),
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
  );}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: isLoading ? Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.orange, size: 50),) : Column(
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
                                   final realIndex =
                        (index % vetorImagens.length + vetorImagens.length) %
                            vetorImagens.length;

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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 16),
                        child: Card(
  color: Colors.grey[300],
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
  ),
  clipBehavior: Clip.antiAlias, // Adiciona clipping no Card
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
            ? ClientListCard(listaMestra[realIndex])
            : DefaultListCard(listaMestra[realIndex]),
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
  }
}
