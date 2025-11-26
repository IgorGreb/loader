import 'dart:async';

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
                  const LoaderPresentation(),
                  const SizedBox(height: 32),
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

class LoaderPresentation extends StatefulWidget {
  const LoaderPresentation({super.key});

  @override
  State<LoaderPresentation> createState() => _LoaderPresentationState();
}

class _LoaderPresentationState extends State<LoaderPresentation> {
  static const _stories = [
    _LoaderStory(
      title: 'Neon Portal',
      description:
          'Просто додайте віджет у Hero або Splash-перехід і отримаєте футуристичний ефект під час запуску.',
      highlights: ['Full-screen splash', 'Hero-ready', 'Гнучкі кольори'],
      colors: [
        Color(0xFF00C6FF),
        Color(0xFF0072FF),
        Color(0xFF7F00FF),
      ],
      gradientRotation: 0.3,
      loaderDuration: Duration(milliseconds: 3200),
      size: 170,
    ),
    _LoaderStory(
      title: 'Aurora Card',
      description:
          'Компонент поводиться як невеликий віджет для карток або станів завантаження модулів.',
      highlights: ['Card loaders', 'Без сяйва', 'UI preview'],
      colors: [
        Color(0xFF12C2E9),
        Color(0xFFC471ED),
        Color(0xFFF64F59),
      ],
      gradientRotation: 0.55,
      loaderDuration: Duration(milliseconds: 2800),
      showGlow: false,
      backgroundColor: Color(0xFF111526),
      size: 150,
    ),
    _LoaderStory(
      title: 'Mint Status',
      description:
          'Легка пульсація з зеленими відтінками чудово підходить для фінтеху або UI зі статусом.',
      highlights: ['Status badge', 'Pulse focus', 'Контрастний фон'],
      colors: [
        Color(0xFF0cebeb),
        Color(0xFF20e3b2),
        Color(0xFF29ffc6),
      ],
      gradientRotation: 0.15,
      loaderDuration: Duration(milliseconds: 2500),
      size: 160,
    ),
  ];

  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _scheduleNext();
  }

  void _scheduleNext() {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 5), () {
      if (!mounted) return;
      setState(() {
        _index = (_index + 1) % _stories.length;
      });
      _scheduleNext();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final story = _stories[_index];
    final titleStyle = theme.textTheme.headlineSmall?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.4,
    );
    final body = theme.textTheme.bodyLarge?.copyWith(
      color: Colors.white.withValues(alpha: 0.85),
      height: 1.5,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0x6631375C),
            Color(0x6633486B),
            Color(0x66396F86),
          ],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Wrap(
            spacing: 32,
            runSpacing: 32,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: constraints.maxWidth > 640
                ? WrapAlignment.spaceBetween
                : WrapAlignment.start,
            children: [
              SizedBox(
                width: constraints.maxWidth > 640
                    ? constraints.maxWidth * 0.45
                    : double.infinity,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.1),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: _StoryText(
                    key: ValueKey(story.title),
                    story: story,
                    titleStyle: titleStyle,
                    bodyStyle: body,
                    total: _stories.length,
                    index: _index,
                  ),
                ),
              ),
              SizedBox(
                width: constraints.maxWidth > 640
                    ? constraints.maxWidth * 0.35
                    : double.infinity,
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 800),
                    transitionBuilder: (child, animation) =>
                        FadeTransition(opacity: animation, child: child),
                    child: AuroraLoader(
                      key: ValueKey(story.title),
                      size: story.size,
                      colors: story.colors,
                      duration: story.loaderDuration,
                      gradientRotation: story.gradientRotation,
                      showGlow: story.showGlow,
                      backgroundColor: story.backgroundColor,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StoryText extends StatelessWidget {
  const _StoryText({
    super.key,
    required this.story,
    required this.titleStyle,
    required this.bodyStyle,
    required this.total,
    required this.index,
  });

  final _LoaderStory story;
  final TextStyle? titleStyle;
  final TextStyle? bodyStyle;
  final int total;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(total, (dotIndex) {
            final isActive = dotIndex == index;
            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                margin: EdgeInsets.only(right: dotIndex == total - 1 ? 0 : 8),
                height: 3,
                decoration: BoxDecoration(
                  color: isActive
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        Text(story.title, style: titleStyle),
        const SizedBox(height: 12),
        Text(story.description, style: bodyStyle),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: story.highlights
              .map(
                (chip) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Text(
                    chip,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _LoaderStory {
  const _LoaderStory({
    required this.title,
    required this.description,
    required this.highlights,
    required this.colors,
    required this.gradientRotation,
    required this.loaderDuration,
    this.showGlow = true,
    this.backgroundColor = const Color(0xFF0C0F1F),
    this.size = 170,
  });

  final String title;
  final String description;
  final List<String> highlights;
  final List<Color> colors;
  final double gradientRotation;
  final Duration loaderDuration;
  final bool showGlow;
  final Color backgroundColor;
  final double size;
}
