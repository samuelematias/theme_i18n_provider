import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:theme_i18n_provider/src/theme/app_theme.dart';
import 'package:theme_provider/theme_provider.dart';

import 'src/pages/home_page.dart';

void main() {
  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en'),
        Locale('es'),
        Locale('pt'),
      ],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      saveThemesOnChange: true, // Auto save any theme change we do
      loadThemeOnInit:
          false, // Do not load the saved theme(use onInitCallback callback)
      onInitCallback: (controller, previouslySavedThemeFuture) async {
        String savedTheme = await previouslySavedThemeFuture;

        if (savedTheme != null) {
          // If previous theme saved, use saved theme
          controller.setTheme(savedTheme);
        } else {
          // If previous theme not found, use platform default
          Brightness platformBrightness =
              SchedulerBinding.instance.window.platformBrightness;
          if (platformBrightness == Brightness.dark) {
            controller.setTheme('dark');
          } else {
            controller.setTheme('light');
          }
          // Forget the saved theme(which were saved just now by previous lines)
          controller.forgetSavedTheme();
        }
      },
      themes: <AppTheme>[
        AppTheme.light().copyWith(
          id: 'light',
          data: AppThemeData.lightTheme,
          description: 'custom light theme',
        ),
        AppTheme.dark().copyWith(
          id: 'dark',
          data: AppThemeData.darkTheme,
          description: 'custom dark theme',
        ),
      ],
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeProvider.themeOf(themeContext).data,
            title: 'Material App',
            home: HomePage(),
          ),
        ),
      ),
    );
  }
}
