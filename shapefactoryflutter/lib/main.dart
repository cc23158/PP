import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shapefactory/login.dart';
import 'package:shapefactory/centralpage.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Obtém o ID do cliente salvo, se houver
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final int? clientId = prefs.getInt('clientId');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: clientId != null ? CentralPage(clientId: clientId) : Login(),
  ));
}