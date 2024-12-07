import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/palette.dart';
import 'features/auth/screens/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: FightMatchApp()));
}

class FightMatchApp extends StatelessWidget {
  const FightMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fight Match App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SFPro',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Palette.black,
          selectionColor: Palette.black.withOpacity(0.3),
          selectionHandleColor: Palette.black,
        ),
        scaffoldBackgroundColor: Palette.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Palette.white,
          surfaceTintColor: Palette.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Palette.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Palette.black,
            foregroundColor: Palette.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            minimumSize: const Size.fromHeight(48),
            textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontFamily: 'Aileron',
                ),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
