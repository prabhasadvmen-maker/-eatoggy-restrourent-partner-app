import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

/// Centered circular progress loader.
class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.color, this.size = 24.0});

  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? AppColors.primary,
          ),
        ),
      ),
    );
  }
}

/// Full screen loader with optional overlay.
class AppFullLoader extends StatelessWidget {
  const AppFullLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: AppLoader(),
    );
  }
}

/// Inline shimmer-style skeleton box for loading placeholders.
class AppSkeletonBox extends StatefulWidget {
  const AppSkeletonBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8.0,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  State<AppSkeletonBox> createState() => _AppSkeletonBoxState();
}

class _AppSkeletonBoxState extends State<AppSkeletonBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
          ),
        );
      },
    );
  }
}
