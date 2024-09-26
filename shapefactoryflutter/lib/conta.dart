import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class Conta extends StatefulWidget {
  @override
  _ContaState createState() => _ContaState();
}

class _ContaState extends State<Conta> {
  bool isDarkMode = true; // Padrão para modo escuro

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mudar Objetivo
            _buildActionRow("Mudar objetivo"),
            SizedBox(height: 16),

            // Alterar Senha
            _buildActionRow("Alterar senha"),
            SizedBox(height: 16),

            // Configurações do Aplicativo
            _buildActionRow("Configurações do aplicativo"),
            SizedBox(height: 32),

            // Radio Button para Modo Claro/Escuro
            Center(
              child: Column(
                children: [
                  Text(
                    "Modo claro/escuro",
                    style: TextStyle(
                      fontSize: 16,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: false,
                        groupValue: isDarkMode,
                        onChanged: (value) {
                          setState(() {
                            isDarkMode = false; // Modo Claro
                          });
                        },
                      ),
                      Text(
                        "Claro",
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      Radio(
                        value: true,
                        groupValue: isDarkMode,
                        onChanged: (value) {
                          setState(() {
                            isDarkMode = true; // Modo Escuro
                          });
                        },
                      ),
                      Text(
                        "Escuro",
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionRow(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        AnimatedButton(
          width: 100,
          height: 40,
          text: title.contains("Alterar") ? "Alterar" : "Mudar",
          textStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          isReverse: true,
          selectedTextColor: Colors.black,
          transitionType: TransitionType.LEFT_TO_RIGHT,
          backgroundColor: isDarkMode ? Colors.black : Colors.white,
          borderColor: Colors.orange,
          borderRadius: 12,
          borderWidth: 2,
          onPress: () {
            // Ação ao pressionar
          },
        ),
      ],
    );
  }
}