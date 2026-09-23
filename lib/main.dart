import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

const _background = Color(0xFF090D18);
const _accent = Color(0xFFBCFF7A);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Orbit',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _accent,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    ),
    home: const OrbitScreen(),
  );
}

enum _Stage { start, splash, ready }

class OrbitScreen extends StatefulWidget {
  const OrbitScreen({super.key});

  @override
  State<OrbitScreen> createState() => _OrbitScreenState();
}

class _OrbitScreenState extends State<OrbitScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  _Stage _stage = _Stage.start;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 2800),
        )..addStatusListener((status) {
          if (status == AnimationStatus.completed && mounted) {
            setState(() => _stage = _Stage.ready);
          }
        });
  }

  void _launch() {
    if (_stage == _Stage.splash) return;
    setState(() => _stage = _Stage.splash);
    _controller.duration = MediaQuery.disableAnimationsOf(context)
        ? const Duration(milliseconds: 300)
        : const Duration(milliseconds: 2800);
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final splash = _stage == _Stage.splash;
    final ready = _stage == _Stage.ready;
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.6, -0.4),
            radius: 1.3,
            colors: [Color(0xFF182438), _background],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 520),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 26,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              spacing: 9,
                              runSpacing: 12,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const Icon(
                                  Icons.blur_on_rounded,
                                  color: _accent,
                                  size: 30,
                                ),
                                const SizedBox(width: 9),
                                const Text(
                                  'orbit',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -1,
                                  ),
                                ),

                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white12),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Text(
                                    'A NEW PERSPECTIVE',
                                    style: TextStyle(
                                      fontSize: 9,
                                      letterSpacing: 1.5,
                                      color: Colors.white60,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            AnimatedBuilder(
                              animation: _controller,
                              builder: (context, child) => SizedBox(
                                height: math.min(
                                  340,
                                  constraints.maxHeight * 0.43,
                                ),
                                width: double.infinity,
                                child: CustomPaint(
                                  painter: _OrbitPainter(
                                    splash ? _controller.value : 0,
                                    ready,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 350),
                              child: Column(
                                key: ValueKey(_stage),
                                children: [
                                  Text(
                                    ready
                                        ? 'YOU HAVE ARRIVED'
                                        : splash
                                        ? 'MAKING THE CONNECTION'
                                        : 'YOUR NEXT CHAPTER',
                                    style: const TextStyle(
                                      color: _accent,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 2.8,
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  Text(
                                    ready
                                        ? 'Welcome to\nyour orbit.'
                                        : splash
                                        ? 'A little wonder.\nComing your way.'
                                        : 'Small steps.\nInfinite possibilities.',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 42,
                                      height: 1.08,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -1.8,
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  Text(
                                    ready
                                        ? 'You’re all set. Make this space your own.'
                                        : splash
                                        ? 'Getting everything ready for a fresh start.'
                                        : 'A fresh start. A new direction.\nSomething extraordinary is just a tap away.',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFF929CAF),
                                      fontSize: 14,
                                      height: 1.65,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 38),
                            SizedBox(
                              height: 58,
                              width: double.infinity,
                              child: splash
                                  ? Semantics(
                                      label: 'Opening Orbit',
                                      liveRegion: true,
                                      child: AnimatedBuilder(
                                        animation: _controller,
                                        builder: (context, child) => Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: LinearProgressIndicator(
                                                value: _controller.value,
                                                minHeight: 3,
                                                color: _accent,
                                                backgroundColor: Colors.white10,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              '${(_controller.value * 100).round()}%',
                                              style: const TextStyle(
                                                fontSize: 11,
                                                color: Colors.white54,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : FilledButton(
                                      onPressed: _launch,
                                      style: FilledButton.styleFrom(
                                        backgroundColor: _accent,
                                        foregroundColor: _background,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            18,
                                          ),
                                        ),
                                      ),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              ready
                                                  ? 'Experience it again'
                                                  : 'Let’s begin',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(width: 14),
                                            Icon(
                                              ready
                                                  ? Icons.replay_rounded
                                                  : Icons.arrow_forward_rounded,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 26),
                            const Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,

                              children: [
                                Icon(
                                  Icons.auto_awesome,
                                  size: 12,
                                  color: Colors.white38,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'A little curiosity goes a long way',
                                  style: TextStyle(
                                    color: Colors.white38,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _OrbitPainter extends CustomPainter {
  _OrbitPainter(this.progress, this.ready);
  final double progress;
  final bool ready;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = math.min(size.width, size.height) * 0.31;
    final turn = progress * math.pi * 4;
    final pulse = 1 + math.sin(progress * math.pi) * 0.12;
    canvas.drawCircle(
      center,
      radius * 1.65,
      Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFF97C985).withValues(alpha: 0.16),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(center: center, radius: radius * 1.65)),
    );
    for (var i = 0; i < 34; i++) {
      final angle = i * 2.399;
      final distance = radius * (1.25 + (i % 5) * 0.14);
      final point =
          center +
          Offset(math.cos(angle) * distance, math.sin(angle) * distance * 0.85);
      canvas.drawCircle(
        point,
        i % 4 == 0 ? 1.5 : 0.8,
        Paint()..color = Colors.white.withValues(alpha: 0.15 + (i % 3) * 0.12),
      );
    }
    for (var i = 0; i < 3; i++) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(-0.55 + i * 0.9 + turn * 0.12);
      final orbit = Rect.fromCenter(
        center: Offset.zero,
        width: radius * 3,
        height: radius * (1.15 + i * 0.26),
      );
      canvas.drawOval(
        orbit,
        Paint()
          ..color = const Color(0xFFB3CBDF).withValues(alpha: 0.18)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
      final angle = turn + i * 2.1;
      final dot = Offset(
        math.cos(angle) * orbit.width / 2,
        math.sin(angle) * orbit.height / 2,
      );
      canvas.drawCircle(
        dot,
        i == 0 ? 5 : 3,
        Paint()..color = i == 0 ? _accent : const Color(0xFFABC9FA),
      );
      canvas.restore();
    }
    final globe = Rect.fromCircle(
      center: center,
      radius: radius * 0.73 * pulse,
    );
    canvas.drawCircle(
      center,
      globe.width / 2,
      Paint()
        ..shader = const RadialGradient(
          center: Alignment(-0.5, -0.6),
          radius: 1.1,
          colors: [
            Color(0xFFE2FFC8),
            Color(0xFF9DC978),
            Color(0xFF36534A),
            Color(0xFF131F2D),
          ],
          stops: [0, 0.28, 0.7, 1],
        ).createShader(globe),
    );
    final icon = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(
          ready ? Icons.check_rounded.codePoint : Icons.auto_awesome.codePoint,
        ),
        style: TextStyle(
          fontFamily: 'MaterialIcons',
          fontSize: radius * 0.60,
          color: const Color(0xFFF0FFE1),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    icon.paint(canvas, center - Offset(icon.width / 2, icon.height / 2));
  }

  @override
  bool shouldRepaint(covariant _OrbitPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.ready != ready;
}
