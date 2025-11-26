import 'package:flutter/material.dart';

import 'aurora_loader.dart';

void main() {
  runApp(const ModernLoaderApp());
}

class ModernLoaderApp extends StatelessWidget {
  const ModernLoaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTextTheme = ThemeData().textTheme;
    return MaterialApp(
      title: 'Aurora Loader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00C6FF)),
        useMaterial3: true,
        textTheme: baseTextTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      home: const LoaderShowcasePage(),
    );
  }
}

class LoaderShowcasePage extends StatelessWidget {
  const LoaderShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final headline = Theme.of(context).textTheme.displaySmall?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        );
    final body = Theme.of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(color: Colors.white70, height: 1.4);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF050509),
              Color(0xFF0F2027),
              Color(0xFF203A43),
              Color(0xFF2C5364),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Aurora Loader',
                      style: headline, textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  Text(
                    'Готовий флаттер-елемент з неоновим ефектом та плавною анімацією. '
                    'Використовуйте його як повноекранний лоадер, заставку або частину картки/модуля.',
                    style: body,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Wrap(
                    spacing: 24,
                    runSpacing: 32,
                    alignment: WrapAlignment.center,
                    children: const [
                      AuroraLoader(label: 'Aurora'),
                      AuroraLoader(
                        size: 150,
                        gradientRotation: 0.45,
                        colors: [
                          Color(0xFFFF512F),
                          Color(0xFFF09819),
                          Color(0xFFFFC371),
                        ],
                        label: 'Sunset',
                      ),
                      AuroraLoader(
                        size: 140,
                        showGlow: false,
                        colors: [
                          Color(0xFF12C2E9),
                          Color(0xFFC471ED),
                        ],
                        label: 'Glass',
                      ),
                      AuroraLoader(
                        size: 180,
                        duration: Duration(milliseconds: 2800),
                        colors: [
                          Color(0xFF11998E),
                          Color(0xFF38EF7D),
                          Color(0xFFA8FF78),
                        ],
                        label: 'Mint Pulse',
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.08)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Поради з інтеграції',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            letterSpacing: -0.2,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '• AuroraLoader найкраще працює на темних або контрастних фонах.\n'
                          '• Обгорніть його в Hero/FadeTransition, якщо хочете плавно показувати екрани завантаження.\n'
                          '• Використовуйте параметри size, colors, duration та showGlow, щоб адаптувати під бренд.',
                          style: TextStyle(color: Colors.white70, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
