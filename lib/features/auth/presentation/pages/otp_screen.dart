import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/otp_provider.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();

    final otpState = ref.read(otpProvider);
    final count = otpState.data.otpLength;

    _controllers = List.generate(
      count,
      (_) => TextEditingController(),
    );

    _focusNodes = List.generate(count, (_) => FocusNode());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(otpProvider.notifier).init(widget.phoneNumber);
      for (final c in _controllers) {
        c.clear();
      }
      if (_focusNodes.isNotEmpty) {
        _focusNodes[0].requestFocus();
      }
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(int index, String value) {
    final notifier = ref.read(otpProvider.notifier);
    if (value.isNotEmpty) {
      final lastChar = value.characters.last;
      _controllers[index].value = TextEditingValue(
        text: lastChar,
        selection: TextSelection.collapsed(offset: lastChar.length),
      );
      notifier.updateDigit(index, lastChar);

      if (index < _controllers.length - 1) {
        _focusNodes[index + 1].requestFocus();
      }
    } else {
      notifier.clearDigit(index);
    }
  }

  void _onBackspace(int index) {
    if (_controllers[index].text.isEmpty && index > 0) {
      _controllers[index - 1].clear();
      ref.read(otpProvider.notifier).clearDigit(index - 1);
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _onVerifySubmitted() {
    final notifier = ref.read(otpProvider.notifier);
    notifier.verifyOtp(
      onSuccess: () {
        if (!mounted) return;
        context.go(AppRoutes.dashboard);
      },
      onError: (msg) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg, style: AppTextStyles.captionWhite),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final otpState = ref.watch(otpProvider);
    final data = otpState.data;

    final displayPhone = otpState.phoneNumber;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),

              GestureDetector(
                onTap: () => context.pop(),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.chevron_left,
                      color: AppColors.goldFont,
                      size: 20.sp,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      data.headerTitle,
                      style: AppTextStyles.subheadMedium.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.goldFont,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 4.h),

              Text(
                data.title,
                style: AppTextStyles.title,
              ),

              SizedBox(height: 1.h),

              GestureDetector(
                onTap: () => context.pop(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${data.subtitlePrefix}${data.defaultCountryCode}$displayPhone',
                      style: AppTextStyles.bodySecondary.copyWith(
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Icon(
                      Icons.mode_edit_outline_rounded,
                      color: AppColors.goldFont,
                      size: 16.sp,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 4.5.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  data.otpLength,
                  (index) => _OtpBoxItem(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    onChanged: (val) => _onDigitChanged(index, val),
                    onBackspace: () => _onBackspace(index),
                  ),
                ),
              ),

              if (otpState.errorMessage != null) ...[
                SizedBox(height: 1.5.h),
                Padding(
                  padding: EdgeInsets.only(left: 1.w),
                  child: Text(
                    otpState.errorMessage!,
                    style: AppTextStyles.captionError.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],

              SizedBox(height: 3.5.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.resendPrefix,
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 15.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: otpState.canResend
                        ? () {
                            ref.read(otpProvider.notifier).resendOtp();
                            for (var c in _controllers) {
                              c.clear();
                            }
                            _focusNodes[0].requestFocus();
                          }
                        : null,
                    child: Text(
                      otpState.canResend
                          ? data.resendActionText
                          : '${data.resendTimerText}00:${otpState.timerSeconds.toString().padLeft(2, '0')}',
                      style: AppTextStyles.captionPrimary.copyWith(
                        fontSize: 15.sp,
                        color: AppColors.goldFont,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 4.h),

              SizedBox(
                width: double.infinity,
                height: 6.2.h,
                child: ElevatedButton(
                  onPressed: otpState.isLoading ? null : _onVerifySubmitted,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor:
                        AppColors.primary.withValues(alpha: 0.5),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: otpState.isLoading
                      ? SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              const Color(0xFF11110F),
                            ),
                          ),
                        )
                      : Text(
                          data.buttonText,
                          style: AppTextStyles.buttonLarge.copyWith(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF11110F),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OtpBoxItem extends StatelessWidget {
  const _OtpBoxItem({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onBackspace,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onBackspace;

  @override
  Widget build(BuildContext context) {
    final hasValue = controller.text.isNotEmpty;

    return Container(
      width: 18.w,
      height: 8.h,
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: hasValue ? AppColors.goldFont : AppColors.darkBorder,
          width: hasValue ? 1.5 : 1.0,
        ),
      ),
      child: Center(
        child: KeyboardListener(
          focusNode: FocusNode(),
          onKeyEvent: (event) {
            if (event is KeyDownEvent &&
                event.logicalKey == LogicalKeyboardKey.backspace) {
              onBackspace();
            }
          },
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            cursorColor: AppColors.primary,
            style: AppTextStyles.bodySecondary.copyWith(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: onChanged,
            decoration: const InputDecoration(
              filled: false,
              fillColor: Colors.transparent,
              counterText: '',
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ),
    );
  }
}
