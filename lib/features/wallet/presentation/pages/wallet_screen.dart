import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_empty_widget.dart';
import '../../../../widgets/app_text_field.dart';
import '../providers/wallet_provider.dart';
import '../widgets/transaction_tile.dart';
import '../widgets/wallet_balance_card.dart';

/// Restaurant earnings and payouts screen with balance card, stats, and transaction history.
class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({super.key});

  @override
  ConsumerState<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> {
  String _selectedFilter = 'All';

  final List<String> _filters = const ['All', 'Payouts', 'Withdrawals', 'Deductions'];

  List<WalletTransaction> _filterList(List<WalletTransaction> transactions) {
    if (_selectedFilter == 'All') return transactions;
    if (_selectedFilter == 'Payouts') {
      return transactions
          .where((t) => t.type == TransactionType.payout)
          .toList();
    }
    if (_selectedFilter == 'Withdrawals') {
      return transactions
          .where((t) => t.type == TransactionType.withdrawal)
          .toList();
    }
    if (_selectedFilter == 'Deductions') {
      return transactions
          .where((t) =>
              t.type == TransactionType.deduction ||
              t.type == TransactionType.refund)
          .toList();
    }
    return transactions;
  }

  void _showWithdrawModal(double currentBalance, String bankAccount) {
    final amountController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: EdgeInsets.fromLTRB(
            5.w,
            3.h,
            5.w,
            MediaQuery.of(ctx).viewInsets.bottom + 3.h,
          ),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppDimensions.radiusXl),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 10.w,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Text('Withdraw Funds', style: AppTextStyles.title),
              SizedBox(height: 0.5.h),
              Text(
                'Funds will be transferred to your registered bank account within 2-4 hours.',
                style: AppTextStyles.caption,
              ),
              SizedBox(height: 2.5.h),

              // Bank account preview
              Container(
                padding: EdgeInsets.all(3.5.w),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.account_balance, color: AppColors.primary),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('HDFC Bank Ltd', style: AppTextStyles.bodyMedium),
                          SizedBox(height: 0.2.h),
                          Text(
                            'A/C: ••••••••• 8492 • IFSC: HDFC0001234',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.check_circle, color: AppColors.success, size: 18),
                  ],
                ),
              ),
              SizedBox(height: 2.h),

              // Amount input
              AppTextField(
                controller: amountController,
                label: 'Withdrawal Amount (₹)',
                hint: 'e.g. 5000',
                keyboardType: TextInputType.number,
                prefixIcon: Icons.currency_rupee,
              ),
              SizedBox(height: 1.h),
              Text(
                'Available to withdraw: ₹${currentBalance.toStringAsFixed(2)}',
                style: AppTextStyles.captionPrimary,
              ),
              SizedBox(height: 3.h),

              AppButton(
                text: 'Confirm Withdrawal',
                icon: Icons.check,
                onPressed: () {
                  final amount = double.tryParse(amountController.text.trim()) ?? 0;
                  if (amount <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a valid amount'),
                        backgroundColor: AppColors.error,
                      ),
                    );
                    return;
                  }

                  final success =
                      ref.read(walletProvider.notifier).requestWithdrawal(amount);
                  Navigator.of(ctx).pop();

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Withdrawal request for ₹${amount.toStringAsFixed(2)} submitted!',
                        ),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Insufficient balance for withdrawal!'),
                        backgroundColor: AppColors.error,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final walletState = ref.watch(walletProvider);
    final list = _filterList(walletState.transactions);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Wallet & Payouts', style: AppTextStyles.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_rounded),
            tooltip: 'Download Statement',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Downloading payout statement for this month...'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance card
            WalletBalanceCard(
              availableBalance: '₹${walletState.availableBalance.toStringAsFixed(2)}',
              pendingSettlement: '₹${walletState.pendingSettlement.toStringAsFixed(2)}',
              bankAccount: walletState.bankAccountMasked,
              onWithdraw: () => _showWithdrawModal(
                walletState.availableBalance,
                walletState.bankAccountMasked,
              ),
            ),
            SizedBox(height: 2.5.h),

            // Quick Stats Row
            Row(
              children: [
                Expanded(
                  child: _buildMiniStat(
                    title: 'This Week',
                    value: '₹34,820',
                    color: AppColors.primary,
                    icon: Icons.trending_up,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: _buildMiniStat(
                    title: 'Orders Settled',
                    value: '94 Orders',
                    color: AppColors.success,
                    icon: Icons.task_alt,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),

            // Filter Chips Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Transactions', style: AppTextStyles.heading),
                Text(
                  '${list.length} records',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
            SizedBox(height: 1.5.h),

            // Filter buttons
            SizedBox(
              height: 4.5.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (context, index) => SizedBox(width: 2.w),
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final isSelected = _selectedFilter == filter;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = filter),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.5.w,
                        vertical: 0.8.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.surface,
                        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.border,
                        ),
                      ),
                      child: Text(
                        filter,
                        style: AppTextStyles.captionMedium.copyWith(
                          color: isSelected
                              ? AppColors.textOnPrimary
                              : AppColors.textSecondary,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 2.h),

            // Transactions list
            if (list.isEmpty)
              Center(
                child: AppEmptyWidget(
                  title: 'No Transactions',
                  message: 'No transactions found for this filter.',
                  icon: Icons.receipt_long_outlined,
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list.length,
                separatorBuilder: (context, index) => SizedBox(height: 1.2.h),
                itemBuilder: (context, index) {
                  final item = list[index];
                  return TransactionTile(
                    title: item.title,
                    subtitle: item.subtitle,
                    amount: item.amount,
                    isCredit: item.isCredit,
                    date: item.date,
                    status: item.status,
                    type: item.type,
                  );
                },
              ),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniStat({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(3.5.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: 2.5.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.caption),
                SizedBox(height: 0.2.h),
                Text(
                  value,
                  style: AppTextStyles.bodySemiBold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
