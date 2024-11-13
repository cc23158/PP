import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shapefactory/StartTraining.dart';

class ActiveTrainingBar extends StatelessWidget {
  final int clientId;
  final Function(BuildContext) onTap;

  const ActiveTrainingBar({
    Key? key,
    required this.clientId,
    required this.onTap,
  }) : super(key: key);

  Widget buildTrainingBottomBar(BuildContext context, String trainingName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: Colors.grey[900],
          height: 70,
          child: GestureDetector(
            onTap: () => onTap(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      trainingName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ValueListenableBuilder<Duration>(
                    valueListenable: StartTraining.trainingTime,
                    builder: (context, duration, child) {
                      final hours = duration.inHours.toString().padLeft(2, '0');
                      final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
                      final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
                      return Text(
                        '$hours:$minutes:$seconds',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
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

  @override
  Widget build(BuildContext context) {
    if (StartTraining.trainingIdAtivo != -1) {
      return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: buildTrainingBottomBar(context, StartTraining.trainingNameAtivo),
      );
    }
    return const SizedBox.shrink();
  }
}

class AnimatedTrainingSheet extends StatefulWidget {
  final int trainingId;
  final int clientId;
  final String nome;

  const AnimatedTrainingSheet({
    Key? key,
    required this.trainingId,
    required this.clientId,
    required this.nome,
  }) : super(key: key);

  @override
  AnimatedTrainingSheetState createState() => AnimatedTrainingSheetState();
}

class AnimatedTrainingSheetState extends State<AnimatedTrainingSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

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