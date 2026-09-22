import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/login_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final currentPhone = ref.read(loginProvider).phoneNumber;
    if (currentPhone.isNotEmpty) {
      _phoneController.text = currentPhone;
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onLoginSubmitted() {
    final notifier = ref.read(loginProvider.notifier);
    notifier.loginWithOtp(
      onSuccess: () {
        if (!mounted) return;
        final cleanNumber = ref.read(loginProvider).sanitizedPhoneNumber;
        context.push(AppRoutes.otp, extra: cleanNumber);
      },
      onError: (errorMessage) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              style: AppTextStyles.captionWhite,
            ),
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

  void _onRegisterTap() {
    context.push(AppRoutes.register);
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    final data = loginState.data;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.h),

                      Row(
                        children: [
                          Container(
                            width: 7.w,
                            height: 7.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.goldFont.withValues(alpha: 0.5),
                                width: 1,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                data.brandLogo,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Icon(
                                  Icons.restaurant,
                                  size: 4.w,
                                  color: AppColors.goldFont,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 2.5.w),
                          Text(
                            data.brandName,
                            style: AppTextStyles.heading.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w900,
                              color: AppColors.goldFont,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 4.5.h),

                      Text(
                        data.title,
                        style: AppTextStyles.title,
                      ),
                      SizedBox(height: 1.2.h),
                      Text(
                        data.subtitle,
                        style: AppTextStyles.bodySecondary.copyWith(
                          fontSize: 15.sp,
                        ),
                      ),

                      SizedBox(height: 4.h),

                      Text(
                        data.phoneInputLabel,
                        style: AppTextStyles.label.copyWith(
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(height: 1.2.h),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: loginState.errorMessage != null
                                ? AppColors.error
                                : AppColors.darkBorder,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 4.w),
                            Text(
                              data.countryCode,
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontSize: 14.5.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: TextFormField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.done,
                                cursorColor: AppColors.primary,
                                style: AppTextStyles.bodySecondary,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                onChanged: (value) {
                                  ref
                                      .read(loginProvider.notifier)
                                      .updatePhoneNumber(value);
                                },
                                onFieldSubmitted: (_) => _onLoginSubmitted(),
                                decoration: InputDecoration(
                                  filled: false,
                                  fillColor: Colors.transparent,
                                  hintText: data.dummyPhoneNumber,
                                  hintStyle: AppTextStyles.hint,
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 1.8.h,
                                  ),
                                ),
                              ),
                            ),
                            if (loginState.phoneNumber.isNotEmpty)
                              IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  size: 18,
                                  color: AppColors.textMuted,
                                ),
                                onPressed: () {
                                  _phoneController.clear();
                                  ref
                                      .read(loginProvider.notifier)
                                      .updatePhoneNumber('');
                                },
                              ),
                          ],
                        ),
                      ),

                      if (loginState.errorMessage != null) ...[
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.only(left: 1.w),
                          child: Text(
                            loginState.errorMessage!,
                            style: AppTextStyles.captionError.copyWith(
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],

                      SizedBox(height: 3.h),

                      SizedBox(
                        width: double.infinity,
                        height: 6.2.h,
                        child: ElevatedButton(
                          onPressed: loginState.isLoading
                              ? null
                              : _onLoginSubmitted,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: loginState.isLoading
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
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      data.buttonText,
                                      style:
                                          AppTextStyles.buttonLarge.copyWith(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFF11110F),
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 18.sp,
                                      color: const Color(0xFF11110F),
                                    ),
                                  ],
                                ),
                        ),
                      ),

                      const Spacer(),

                      Padding(
                        padding: EdgeInsets.only(bottom: 3.h, top: 2.h),
                        child: Center(
                          child: GestureDetector(
                            onTap: _onRegisterTap,
                            child: Text.rich(
                              TextSpan(
                                text: '${data.newRestaurantText} ',
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: 14.sp,
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w700,
                                ),
                                children: [
                                  TextSpan(
                                    text: data.registerText,
                                    style:
                                        AppTextStyles.captionPrimary.copyWith(
                                      fontSize: 15.sp,
                                      color: AppColors.goldFont,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
