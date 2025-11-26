import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A ready-to-drop modern loading indicator with animated orbits and glow.
class AuroraLoader extends StatefulWidget {
  const AuroraLoader({
    super.key,
    this.size = 170,
    this.colors = const [
      Color(0xFF00C6FF),
      Color(0xFF0072FF),
      Color(0xFF7F00FF),
    ],
    this.duration = const Duration(milliseconds: 3600),
    this.label,
    this.labelStyle,
    this.backgroundColor = const Color(0xFF0C0F1F),
    this.showGlow = true,
    this.gradientRotation = 0.25,
  });

  /// Overall width/height of the loader container.
  final double size;

  /// Colors used for the blob gradients and orbits.
  final List<Color> colors;

  /// Speed of the looping orbit animation.
  final Duration duration;

  /// Optional caption shown under the loader.
  final String? label;

  /// Allows customizing typography of the optional caption.
  final TextStyle? labelStyle;

  /// Color of the frosted-glass like card.
  final Color backgroundColor;

  /// Adds subtle bloom when enabled.
  final bool showGlow;

  /// Rotates the gradient to add motion even when idle.
  final double gradientRotation;

  @override
  State<AuroraLoader> createState() => _AuroraLoaderState();
}

class _AuroraLoaderState extends State<AuroraLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void didUpdateWidget(covariant AuroraLoader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller
        ..duration = widget.duration
        ..repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final baseTextStyle = widget.labelStyle ??
        textTheme.titleMedium?.copyWith(color: Colors.white70);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _GlassCard(
          size: widget.size,
          colors: widget.colors,
          showGlow: widget.showGlow,
          gradientRotation: widget.gradientRotation,
          animation: _controller,
          backgroundColor: widget.backgroundColor,
        ),
        if (widget.label != null) ...[
          const SizedBox(height: 20),
          Text(widget.label!, style: baseTextStyle),
        ],
      ],
    );
  }
}

List<Color> _normalizeColors(List<Color> colors) {
  if (colors.isEmpty) {
    return const [Colors.white, Colors.white70, Colors.white54];
  }
  if (colors.length == 1) {
    final base = colors.first;
    return [base, base.withValues(alpha: 0.8), base.withValues(alpha: 0.6)];
  }
  if (colors.length == 2) {
    return [...colors, colors.last.withValues(alpha: 0.8)];
  }
  return colors.take(3).toList();
}

class _GlassCard extends StatelessWidget {
  const _GlassCard({
    required this.size,
    required this.colors,
    required this.animation,
    required this.backgroundColor,
    required this.showGlow,
    required this.gradientRotation,
  });

  final double size;
  final List<Color> colors;
  final Animation<double> animation;
  final Color backgroundColor;
  final bool showGlow;
  final double gradientRotation;

  @override
  Widget build(BuildContext context) {
    final colorStops = _normalizeColors(colors);
    final rotationAngle = gradientRotation * math.pi * 2;
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size),
        color: backgroundColor.withValues(alpha: 0.85),
        boxShadow: showGlow
            ? [
                BoxShadow(
                  color: colorStops.first.withValues(alpha: 0.35),
                  blurRadius: size * 0.45,
                  spreadRadius: size * 0.04,
                  offset: const Offset(0, 20),
                ),
              ]
            : null,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1.5,
        ),
      ),
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final progress = animation.value;
          return Stack(
            alignment: Alignment.center,
            children: [
              _GradientBlob(
                size: size * 0.9,
                colors: colorStops,
                rotation: rotationAngle * progress,
              ),
              _OrbitingDot(
                progress: progress,
                radius: size * 0.35,
                dotSize: size * 0.24,
                phase: 0,
                colors: colorStops,
              ),
              _OrbitingDot(
                progress: progress,
                radius: size * 0.38,
                dotSize: size * 0.14,
                phase: 0.33,
                colors: colorStops.reversed.toList(),
              ),
              _OrbitingDot(
                progress: progress,
                radius: size * 0.28,
                dotSize: size * 0.12,
                phase: 0.66,
                colors: [
                  Colors.white,
                  colorStops.first.withValues(alpha: 0.7),
                ],
              ),
              _Pulse(progress: progress, radius: size * 0.38),
            ],
          );
        },
      ),
    );
  }
}

class _GradientBlob extends StatelessWidget {
  const _GradientBlob({
    required this.size,
    required this.colors,
    required this.rotation,
  });

  final double size;
  final List<Color> colors;
  final double rotation;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: SweepGradient(
            colors: colors,
            stops: const [0, 0.55, 1],
          ),
        ),
      ),
    );
  }
}

class _OrbitingDot extends StatelessWidget {
  const _OrbitingDot({
    required this.progress,
    required this.radius,
    required this.dotSize,
    required this.phase,
    required this.colors,
  });

  final double progress;
  final double radius;
  final double dotSize;
  final double phase;
  final List<Color> colors;

  static const double _tau = math.pi * 2;

  @override
  Widget build(BuildContext context) {
    final angle = (progress + phase) * _tau;
    final offset = Offset(math.cos(angle), math.sin(angle)) * radius;
    return Transform.translate(
      offset: offset,
      child: Container(
        width: dotSize,
        height: dotSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: colors.last.withValues(alpha: 0.35),
              blurRadius: dotSize * 0.8,
              spreadRadius: dotSize * 0.2,
            ),
          ],
        ),
      ),
    );
  }
}

class _Pulse extends StatelessWidget {
  const _Pulse({required this.progress, required this.radius});

  final double progress;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final current = (progress % 1.0);
    final scale = 0.7 + current * 0.6;
    final opacity = 1 - current;
    return Transform.scale(
      scale: scale,
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.05 + opacity * 0.15),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.12 * opacity),
          ),
        ),
      ),
    );
  }
}
