import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_shell.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _decideRoute();
  }

  Future<void> _decideRoute() async {
    final preferences = await SharedPreferences.getInstance();
    final hasSeenOnboarding =
        preferences.getBool('has_seen_onboarding') ?? false;
    await Future<void>.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) =>
            hasSeenOnboarding ? const HomeShell() : const OnboardingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 54,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: const Icon(Icons.volunteer_activism, size: 58),
              ),
              const SizedBox(height: 18),
              Text('ConectaDoa',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              const Text('Material escolar ganha um novo caminho.'),
            ],
          ),
        ),
      );
}
