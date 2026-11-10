import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';

void main() => runApp(const ConectaDoaApp());

class ConectaDoaApp extends StatelessWidget {
  const ConectaDoaApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'ConectaDoa',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00796B)),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      );
}
