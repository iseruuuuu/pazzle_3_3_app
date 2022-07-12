import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:puzzle_3_3_app/src/domain/models/move_to.dart';
import 'package:puzzle_3_3_app/src/ui/pages/game/widgets/game_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_3_3_app/src/ui/pages/game/widgets/game_buttons.dart';
import 'package:puzzle_3_3_app/src/ui/pages/game/widgets/puzzle_interactor.dart';
import 'package:puzzle_3_3_app/src/ui/pages/game/widgets/time_and_moves.dart';
import 'package:puzzle_3_3_app/src/ui/pages/game/widgets/winner_dialog.dart';
import 'controller/game_controller.dart';

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

  void _onKeyBoardEvent(BuildContext context, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      final moveTo = event.logicalKey.keyLabel.moveTo;
      if (moveTo != null) {
        context.read<GameController>().onMoveByKeyboard(moveTo);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final controller = GameController();
        controller.onFinish.listen(
          (_) {
            Timer(
              const Duration(milliseconds: 200),
              () {
                showWinnerDialog(
                  context,
                  moves: controller.state.moves,
                  time: controller.time.value,
                );
              },
            );
          },
        );
        return controller;
      },
      builder: (context, child) => RawKeyboardListener(
        autofocus: true,
        includeSemantics: false,
        focusNode: FocusNode(),
        onKey: (event) => _onKeyBoardEvent(context, event),
        child: child!,
      ),
      child: Scaffold(
        backgroundColor: CupertinoColors.white,
        body: SafeArea(
          child: OrientationBuilder(
            builder: (_, orientation) {
              final isPortrait = orientation == Orientation.portrait;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const GameAppBar(),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (_, constraints) {
                        final height = constraints.maxHeight;
                        final puzzleHeight = (isPortrait ? height * 0.45 : height * 0.5).clamp(250, 700).toDouble();
                        return SizedBox(
                          height: height,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: height * 0.1),
                                const TimeAndMoves(),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: SizedBox(
                                    height: puzzleHeight,
                                    child: const AspectRatio(
                                      aspectRatio: 1,
                                      child: PuzzleInteractor(),
                                    ),
                                  ),
                                ),
                                const GameButtons(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
