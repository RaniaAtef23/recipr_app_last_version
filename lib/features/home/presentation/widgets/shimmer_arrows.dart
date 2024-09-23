import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerArrows extends StatefulWidget {
  const ShimmerArrows({super.key});

  @override
  State<ShimmerArrows> createState() => _ShimmerArrowsState();
}

class _ShimmerArrowsState extends State<ShimmerArrows> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: Duration(seconds: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, context) {
        return ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.centerLeft, // Start from the left
            end: Alignment.centerRight, // End on the right
            transform: GradientTransformWithPercent(_animationController.value),
            colors: [
              Colors.white10,
              Colors.white,
              Colors.white10,
            ],
          ).createShader(bounds),
          child: Row(
            children: [
              Align(
                widthFactor: .4,
                child: Icon(
                  Icons.keyboard_arrow_right,
                  size: 40.sp,
                ),
              ),
              Align(
                widthFactor: .4,
                child: Icon(
                  Icons.keyboard_arrow_right,
                  size: 40.sp,
                ),
              ),
              Align(
                widthFactor: .4,
                child: Icon(
                  Icons.keyboard_arrow_right,
                  size: 40.sp,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class GradientTransformWithPercent extends GradientTransform {
  final double percent;

  GradientTransformWithPercent(this.percent);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * percent, 0, 0); // Horizontal translation
  }
}
