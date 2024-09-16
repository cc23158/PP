import 'package:flutter/material.dart';

class AddExercice extends StatefulWidget {
  const AddExercice({super.key});
  @override
  AddExerciceState createState() => AddExerciceState();
}

class AddExerciceState extends State<AddExercice> {
  final controllerEmail = TextEditingController();
  final controllerSenha = TextEditingController();
  final controllerList = ScrollController();
  var mensagemErro = "";
  var corBorda;
  var listElement = List.filled(
      1,
      const Row(
        children: [
          Text(
            "teste",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      growable: true);

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height) {
      setState(() {
        corBorda = const BorderSide(color: Colors.grey, width: 2);
      });
    } else {
      setState(() {
        corBorda = const BorderSide(color: Colors.black);
      });
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Align(
          alignment: Alignment.center,
          child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.5,
              constraints: const BoxConstraints(minHeight: 700, minWidth: 400),
              child: Card(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    
                      side: corBorda,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  child: SingleChildScrollView(
                    controller: controllerList,
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(children: [
                            Column(
                              children: listElement,
                            ),
                            MaterialButton(
                              onPressed: () {
                                setState(() {
                                  listElement.add(
                                    const Row(
                                      children: [
                                        Text(
                                          "teste",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  );
                                }
                                );
                                controllerList.jumpTo(controllerList.position.maxScrollExtent + 20);
                              },
                              color: Colors.orange,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              minWidth: MediaQuery.of(context).size.width * 0.5,
                              padding: const EdgeInsets.all(20),
                              child: const Row(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.add), Text("Adicionar a lista", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),],),
                            )
                          ]))))),
        ),
      ),
    );
  }
}
