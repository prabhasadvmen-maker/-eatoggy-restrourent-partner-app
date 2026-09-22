import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/business_tools_provider.dart';

class ThermalPrinterScreen extends ConsumerWidget {
  const ThermalPrinterScreen({super.key});

  void _showTestReceiptModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF171715),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide(color: Color(0xFF262622), width: 1),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.5.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 10.w,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF333330),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBEA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '*** TEST RECEIPT ***',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 0.8.h),
                      Text(
                        'TANDOORI TALES KITCHEN\nPlot 42, HSR Layout, Bangalore\nGSTIN: 29AAAAA0000A1Z5',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 9.5.sp,
                          color: Colors.black87,
                        ),
                      ),
                      const Divider(color: Colors.black45, height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('1x Butter Chicken', style: TextStyle(fontFamily: 'monospace', fontSize: 10.sp, color: Colors.black)),
                          Text('₹320', style: TextStyle(fontFamily: 'monospace', fontSize: 10.sp, color: Colors.black)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('2x Garlic Naan', style: TextStyle(fontFamily: 'monospace', fontSize: 10.sp, color: Colors.black)),
                          Text('₹120', style: TextStyle(fontFamily: 'monospace', fontSize: 10.sp, color: Colors.black)),
                        ],
                      ),
                      const Divider(color: Colors.black45, height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('TOTAL PAID', style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 11.sp, color: Colors.black)),
                          Text('₹440', style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 11.sp, color: Colors.black)),
                        ],
                      ),
                      SizedBox(height: 0.8.h),
                      Text(
                        'Thermal Print: OK • 80mm',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 9.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: Size(double.infinity, 5.5.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Test print sent to printer!'),
                        backgroundColor: AppColors.success,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Text(
                    'Send to Printer',
                    style: AppTextStyles.buttonMedium.copyWith(
                      color: const Color(0xFF11110F),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildToggleRow({
    required String title,
    required bool value,
    required VoidCallback onToggle,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.creamText,
            ),
          ),
          Switch(
            value: value,
            onChanged: (_) => onToggle(),
            activeTrackColor: const Color(0xFF22C55E),
            activeThumbColor: const Color(0xFFFFF1D2),
            inactiveTrackColor: const Color(0xFF2E2E2A),
            inactiveThumbColor: const Color(0xFFFFF1D2),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(thermalPrinterProvider);
    final notifier = ref.read(thermalPrinterProvider.notifier);
    final model = state.model;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.5.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF171715),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFF262622),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: AppColors.primary,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 3.5.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thermal Printer Setup',
                          style: AppTextStyles.headingWhite.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.creamText,
                          ),
                        ),
                        Text(
                          'Receipts and kitchen order tickets (KOT)',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondaryDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.5.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(4.5.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF171715),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.print_rounded,
                              color: AppColors.primary,
                              size: 20.sp,
                            ),
                            SizedBox(width: 2.5.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.selectedPrinter.name,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.creamText,
                                  ),
                                ),
                                Text(
                                  '${model.selectedPrinter.type} • ${model.selectedPrinter.address}',
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textSecondaryDark,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.5.w,
                            vertical: 0.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B3820),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFF22C55E),
                              width: 0.8,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF22C55E),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 1.5.w),
                              Text(
                                'Connected',
                                style: AppTextStyles.caption.copyWith(
                                  color: const Color(0xFF22C55E),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.5.h),
              Text(
                'Available Devices',
                style: AppTextStyles.headingWhite.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.creamText,
                ),
              ),
              SizedBox(height: 1.2.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF171715),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF262622),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: model.availablePrinters.map((device) {
                    final isSelected =
                        device.name == model.selectedPrinter.name;
                    return InkWell(
                      onTap: () => notifier.selectPrinter(device),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 1.6.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  device.type.contains('WiFi')
                                      ? Icons.wifi_rounded
                                      : Icons.bluetooth_rounded,
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.textSecondaryDark,
                                  size: 18.sp,
                                ),
                                SizedBox(width: 3.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      device.name,
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        fontWeight: isSelected
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        color: isSelected
                                            ? AppColors.primary
                                            : AppColors.creamText,
                                      ),
                                    ),
                                    Text(
                                      '${device.type} • ${device.address}',
                                      style: AppTextStyles.caption.copyWith(
                                        fontSize: 10.sp,
                                        color: AppColors.textSecondaryDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle_rounded,
                                color: AppColors.primary,
                                size: 16.sp,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 2.5.h),
              Text(
                'Paper Width',
                style: AppTextStyles.headingWhite.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.creamText,
                ),
              ),
              SizedBox(height: 1.2.h),
              Row(
                children: ['58mm', '80mm'].map((size) {
                  final isSelected = model.paperSize == size;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => notifier.setPaperSize(size),
                      child: Container(
                        margin: EdgeInsets.only(
                          right: size == '58mm' ? 2.w : 0,
                          left: size == '80mm' ? 2.w : 0,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 1.4.h),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withValues(alpha: 0.15)
                              : const Color(0xFF171715),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : const Color(0xFF262622),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '$size Standard',
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.creamText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 2.5.h),
              Text(
                'Printing Preferences',
                style: AppTextStyles.headingWhite.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.creamText,
                ),
              ),
              SizedBox(height: 1.2.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF171715),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF262622),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    _buildToggleRow(
                      title: 'Auto-print New Orders',
                      value: model.autoPrintOrder,
                      onToggle: () => notifier.toggleAutoPrintOrder(),
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildToggleRow(
                      title: 'Auto-print KOT on Accept',
                      value: model.autoPrintKot,
                      onToggle: () => notifier.toggleAutoPrintKot(),
                    ),
                    const Divider(color: Color(0xFF242420), height: 1),
                    _buildToggleRow(
                      title: 'Print Customer Phone & Address',
                      value: model.printCustomerDetails,
                      onToggle: () => notifier.togglePrintCustomerDetails(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.5.h),
              GestureDetector(
                onTap: () async {
                  await notifier.testPrint();
                  if (context.mounted) {
                    _showTestReceiptModal(context);
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long_rounded,
                          color: const Color(0xFF11110F),
                          size: 18.sp,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          state.isTesting
                              ? 'Sending Test Print...'
                              : 'Test Print Receipt',
                          style: AppTextStyles.buttonMedium.copyWith(
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF11110F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }
}
