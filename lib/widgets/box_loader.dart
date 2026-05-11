import 'dart:math' as math;

import 'package:flutter/material.dart';

class BoxesLoader extends StatefulWidget {
  const BoxesLoader({super.key});

  @override
  State<BoxesLoader> createState() => _BoxesLoaderState();
}

class _BoxesLoaderState extends State<BoxesLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  static const double size = 32;
  static const duration = Duration(milliseconds: 800);

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: duration,
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Offset box1(double t) {
    if (t < 0.5) {
      return const Offset(1, 0);
    }
    return Offset(1 + ((t - 0.5) * 2), 0);
  }

  Offset box2(double t) {
    if (t < 0.5) {
      return Offset(0, 1 - (t * 2));
    }
    return Offset((t - 0.5) * 2, 0);
  }

  Offset box3(double t) {
    if (t < 0.5) {
      return const Offset(1, 1);
    }
    return Offset(1 - ((t - 0.5) * 2), 1);
  }

  Offset box4(double t) {
    if (t < 0.5) {
      return Offset(2, t * 2);
    }
    return Offset(2 - ((t - 0.5) * 2), 1);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        final t = controller.value;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..rotateX(math.pi / 3) // 60deg
            ..rotateZ(math.pi / 4), // 45deg
          child: SizedBox(
            width: size * 3,
            height: size * 2,
            child: Stack(
              children: [
                buildCube(box1(t)),
                buildCube(box2(t)),
                buildCube(box3(t)),
                buildCube(box4(t)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCube(Offset gridPos) {
    return Positioned(
      left: gridPos.dx * size,
      top: gridPos.dy * size,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          children: [
            // Front
            Container(
              width: size,
              height: size,
              color: const Color(0xFF5C8DF6),
            ),

            // Right side
            Transform(
              alignment: Alignment.centerRight,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(-math.pi / 2),
              child: Container(
                width: size,
                height: size,
                color: const Color(0xFF145AF2),
              ),
            ),

            // Top side
            Transform(
              alignment: Alignment.topCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(math.pi / 2),
              child: Container(
                width: size,
                height: size,
                color: const Color(0xFF447CF5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}