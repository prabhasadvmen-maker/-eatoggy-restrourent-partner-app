import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/splash_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});
  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.90, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.85, curve: Curves.easeOutCubic),
      ),
    );

    _glowAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeInOut),
      ),
    );

    _animController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(splashProvider.notifier).initSplash();
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<SplashState>(splashProvider, (previous, next) {
      if (next.canNavigate && mounted) {
        context.go(next.data.nextRoute);
      }
    });

    final splashState = ref.watch(splashProvider);
    final data = splashState.data;

    return Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            children: [
              const Spacer(flex: 3),

              AnimatedBuilder(
                animation: _animController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _animController,
                          builder: (context, _) {
                            return Container(
                              width: 70.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    AppColors.goldFont.withValues(
                                      alpha: 0.22 * _glowAnimation.value,
                                    ),
                                    AppColors.goldGradientEnd.withValues(
                                      alpha: 0.08 * _glowAnimation.value,
                                    ),
                                    Colors.transparent,
                                  ],
                                  stops: const [0.0, 0.45, 1.0],
                                ),
                              ),
                            );
                          },
                        ),

                        Container(
                          width: 48.w,
                          height: 12.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 1.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF141412),
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusSm,
                            ),
                            border: Border.all(
                              color: AppColors.darkBorder.withValues(alpha: 0.6),
                              width: 1.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.6),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Image.asset(
                              data.logoAsset,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 5.5.h),

                    Text(
                      data.appTitle,
                      style: AppTextStyles.title.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w900,
                        color: AppColors.goldFont,
                        letterSpacing: 2.5,
                      ),
                    ),

                    SizedBox(height: 1.2.h),

                    Text(
                      data.tagline,
                      style: AppTextStyles.subhead.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.creamText,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 4),

              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      data.versionInfo,
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.textMutedDark,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.3,
                      ),
                    ),
                    SizedBox(height: 1.5.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
