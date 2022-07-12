import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../global/controllers/theme_controller.dart';
import '../../../global/widgets/my_icon_button.dart';
import '../../../icons/puzzle_icons.dart';
import '../controller/game_controller.dart';

class GameAppBar extends StatelessWidget {
  const GameAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            const Spacer(),
            Consumer<GameController>(
              builder: (_, controller, __) => Row(
                children: [
                  MyIconButton(
                    onPressed: controller.toggleVibration,
                    iconData: controller.state.vibration
                        ? PuzzleIcons.vibration
                        : PuzzleIcons.vibration_off,
                  ),
                  const SizedBox(width: 10),
                  MyIconButton(
                    onPressed: controller.toggleSound,
                    iconData: controller.state.sound
                        ? PuzzleIcons.sound
                        : PuzzleIcons.mute,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Consumer<ThemeController>(
              builder: (_, controller, __) => MyIconButton(
                onPressed: controller.toggle,
                iconData: controller.isDarkMode
                    ? PuzzleIcons.dark_mode
                    : PuzzleIcons.brightness,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
