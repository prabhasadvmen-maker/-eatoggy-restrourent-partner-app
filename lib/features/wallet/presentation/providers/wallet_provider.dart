import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/transaction_tile.dart';

class WalletTransaction {
  const WalletTransaction({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isCredit,
    required this.date,
    required this.status,
    required this.type,
  });

  final String id;
  final String title;
  final String subtitle;
  final String amount;
  final bool isCredit;
  final String date;
  final String status;
  final TransactionType type;
}

class WalletState {
  const WalletState({
    required this.availableBalance,
    required this.pendingSettlement,
    required this.bankName,
    required this.bankAccountMasked,
    required this.transactions,
  });

  final double availableBalance;
  final double pendingSettlement;
  final String bankName;
  final String bankAccountMasked;
  final List<WalletTransaction> transactions;

  WalletState copyWith({
    double? availableBalance,
    double? pendingSettlement,
    String? bankName,
    String? bankAccountMasked,
    List<WalletTransaction>? transactions,
  }) {
    return WalletState(
      availableBalance: availableBalance ?? this.availableBalance,
      pendingSettlement: pendingSettlement ?? this.pendingSettlement,
      bankName: bankName ?? this.bankName,
      bankAccountMasked: bankAccountMasked ?? this.bankAccountMasked,
      transactions: transactions ?? this.transactions,
    );
  }
}

class WalletNotifier extends Notifier<WalletState> {
  @override
  WalletState build() {
    return const WalletState(
      availableBalance: 18420.50,
      pendingSettlement: 3250.00,
      bankName: 'HDFC Bank Ltd',
      bankAccountMasked: 'HDFC •••• 8492',
      transactions: [
        WalletTransaction(
          id: 'tx1',
          title: 'Order #1048 Payout',
          subtitle: 'Order completed',
          amount: '₹525.50',
          isCredit: true,
          date: 'Today, 2:30 PM',
          status: 'Settled',
          type: TransactionType.payout,
        ),
        WalletTransaction(
          id: 'tx2',
          title: 'Order #1047 Payout',
          subtitle: 'Order completed',
          amount: '₹340.00',
          isCredit: true,
          date: 'Today, 1:15 PM',
          status: 'Settled',
          type: TransactionType.payout,
        ),
        WalletTransaction(
          id: 'tx3',
          title: 'Bank Transfer Withdrawal',
          subtitle: 'HDFC Bank •••• 8492',
          amount: '₹12,000.00',
          isCredit: false,
          date: 'Yesterday',
          status: 'Completed',
          type: TransactionType.withdrawal,
        ),
        WalletTransaction(
          id: 'tx4',
          title: 'Order #1045 Payout',
          subtitle: 'Order completed',
          amount: '₹395.00',
          isCredit: true,
          date: '15 Sep, 8:10 PM',
          status: 'Settled',
          type: TransactionType.payout,
        ),
        WalletTransaction(
          id: 'tx5',
          title: 'Weekly Platform Service Fee',
          subtitle: 'GST invoice #INV-9281',
          amount: '₹850.00',
          isCredit: false,
          date: '14 Sep, 11:59 PM',
          status: 'Deducted',
          type: TransactionType.deduction,
        ),
        WalletTransaction(
          id: 'tx6',
          title: 'Order #1039 Refund Adjustment',
          subtitle: 'Customer cancelled',
          amount: '₹210.00',
          isCredit: false,
          date: '13 Sep, 4:20 PM',
          status: 'Adjusted',
          type: TransactionType.refund,
        ),
        WalletTransaction(
          id: 'tx7',
          title: 'Bank Transfer Withdrawal',
          subtitle: 'HDFC Bank •••• 8492',
          amount: '₹15,000.00',
          isCredit: false,
          date: '10 Sep, 10:00 AM',
          status: 'Completed',
          type: TransactionType.withdrawal,
        ),
      ],
    );
  }

  bool requestWithdrawal(double amount) {
    if (amount <= 0 || amount > state.availableBalance) {
      return false;
    }

    final newTx = WalletTransaction(
      id: 'tx_${DateTime.now().millisecondsSinceEpoch}',
      title: 'Bank Transfer Withdrawal',
      subtitle: state.bankAccountMasked,
      amount: '₹${amount.toStringAsFixed(2)}',
      isCredit: false,
      date: 'Just now',
      status: 'Processing',
      type: TransactionType.withdrawal,
    );

    state = state.copyWith(
      availableBalance: state.availableBalance - amount,
      transactions: [newTx, ...state.transactions],
    );

    return true;
  }
}

final walletProvider = NotifierProvider<WalletNotifier, WalletState>(
  WalletNotifier.new,
);
