import 'package:flutter/material.dart';
import 'package:puzzle_3_3_app/src/inject_dependencies.dart';
import 'package:puzzle_3_3_app/src/ui/global/controllers/theme_controller.dart';
import 'package:puzzle_3_3_app/src/ui/global/widgets/max_text_scale_factor.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:puzzle_3_3_app/generated/l10n.dart';
import 'package:puzzle_3_3_app/src/ui/pages/game/game_view.dart';
import 'package:puzzle_3_3_app/src/ui/routes/routes.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await injectDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeController(),
      child: Consumer<ThemeController>(
        builder: (_, controller, __) => MaterialApp(
          builder: (_, page) => MaxTextScaleFactor(child: page!),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          themeMode: controller.themeMode,
          theme: controller.lightTheme,
          darkTheme: controller.darkTheme,
          initialRoute: Routes.splash,
          home: const GameView(),
        ),
      ),
    );
  }
}
