import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../home/pages/home_screen.dart';
import '../../../orders/presentation/pages/orders_screen.dart';
import '../../../kitchen/presentation/pages/kitchen_screen.dart';
import '../../../menu/presentation/pages/menu_screen.dart';
import '../../../profile/presentation/pages/profile_screen.dart';
import '../providers/main_shell_provider.dart';

class MainShellScreen extends ConsumerWidget {
  const MainShellScreen({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    OrdersScreen(),
    KitchenScreen(),
    MenuScreen(),
    ProfileScreen(),
  ];

  Widget _buildTabIcon(String id, bool isSelected, Color color, double size) {
    switch (id) {
      case 'home':
        return Icon(
          isSelected ? Icons.home_rounded : Icons.home_outlined,
          size: size,
          color: color,
        );
      case 'orders':
        return CustomPaint(
          size: Size(size, size),
          painter: _OrdersIconPainter(color: color),
        );
      case 'kitchen':
        return CustomPaint(
          size: Size(size, size),
          painter: _KitchenIconPainter(color: color),
        );
      case 'menu':
        return CustomPaint(
          size: Size(size, size),
          painter: _MenuIconPainter(color: color),
        );
      case 'more':
        return Icon(
          Icons.menu_rounded,
          size: size,
          color: color,
        );
      default:
        return Icon(Icons.square_outlined, size: size, color: color);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mainShellProvider);
    final notifier = ref.read(mainShellProvider.notifier);
    final tabs = state.data.tabs;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: IndexedStack(
        index: state.currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF141412),
          border: Border(
            top: BorderSide(color: Color(0xFF22221F), width: 1),
          ),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 7.2.h,
            child: Row(
              children: List.generate(tabs.length, (index) {
                final tab = tabs[index];
                final isSelected = index == state.currentIndex;
                final itemColor = isSelected
                    ? AppColors.primary
                    : const Color(0xFF8A8A85);

                return Expanded(
                  child: GestureDetector(
                    onTap: () => notifier.changeTab(index),
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTabIcon(tab.id, isSelected, itemColor, 20.sp),
                        SizedBox(height: 0.4.h),
                        Text(
                          tab.label,
                          style: AppTextStyles.label.copyWith(
                            fontSize: 12.sp,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: itemColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _OrdersIconPainter extends CustomPainter {
  _OrdersIconPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    final path = Path();
    path.moveTo(w * 0.18, h * 0.28);
    path.lineTo(w * 0.72, h * 0.28);

    path.moveTo(w * 0.18, h * 0.52);
    path.lineTo(w * 0.72, h * 0.52);

    path.moveTo(w * 0.18, h * 0.76);
    path.lineTo(w * 0.48, h * 0.76);

    path.moveTo(w * 0.54, h * 0.72);
    path.lineTo(w * 0.64, h * 0.82);
    path.lineTo(w * 0.84, h * 0.58);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _OrdersIconPainter oldDelegate) =>
      oldDelegate.color != color;
}

class _KitchenIconPainter extends CustomPainter {
  _KitchenIconPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    final bandPath = Path();
    bandPath.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.20, h * 0.66, w * 0.60, h * 0.20),
        const Radius.circular(3),
      ),
    );

    final hatPath = Path();
    hatPath.moveTo(w * 0.22, h * 0.66);
    hatPath.cubicTo(w * 0.08, h * 0.50, w * 0.12, h * 0.26, w * 0.32, h * 0.22);
    hatPath.cubicTo(w * 0.38, h * 0.06, w * 0.62, h * 0.06, w * 0.68, h * 0.22);
    hatPath.cubicTo(w * 0.88, h * 0.26, w * 0.92, h * 0.50, w * 0.78, h * 0.66);

    canvas.drawPath(bandPath, paint);
    canvas.drawPath(hatPath, paint);
  }

  @override
  bool shouldRepaint(covariant _KitchenIconPainter oldDelegate) =>
      oldDelegate.color != color;
}

class _MenuIconPainter extends CustomPainter {
  _MenuIconPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    final knifePath = Path();
    knifePath.moveTo(w * 0.25, h * 0.75);
    knifePath.lineTo(w * 0.75, h * 0.25);
    knifePath.moveTo(w * 0.75, h * 0.25);
    knifePath.cubicTo(w * 0.65, h * 0.15, w * 0.50, h * 0.20, w * 0.40, h * 0.35);

    final forkPath = Path();
    forkPath.moveTo(w * 0.75, h * 0.75);
    forkPath.lineTo(w * 0.38, h * 0.38);

    final tinesPath = Path();
    tinesPath.moveTo(w * 0.20, h * 0.45);
    tinesPath.lineTo(w * 0.38, h * 0.27);
    tinesPath.moveTo(w * 0.27, h * 0.38);
    tinesPath.lineTo(w * 0.45, h * 0.20);
    tinesPath.moveTo(w * 0.34, h * 0.31);
    tinesPath.lineTo(w * 0.52, h * 0.13);

    canvas.drawPath(knifePath, paint);
    canvas.drawPath(forkPath, paint);
    canvas.drawPath(tinesPath, paint);
  }

  @override
  bool shouldRepaint(covariant _MenuIconPainter oldDelegate) =>
      oldDelegate.color != color;
}
