enum TransactionCategory {
  all,
  settlement,
  foodOrder,
  subscription,
  deduction,
}

class TransactionItemModel {
  final String id;
  final String title;
  final String tag;
  final String subtitle;
  final String timestamp;
  final String amount;
  final bool isCredit;
  final TransactionCategory category;
  final DateTime date;

  const TransactionItemModel({
    required this.id,
    required this.title,
    required this.tag,
    required this.subtitle,
    required this.timestamp,
    required this.amount,
    required this.isCredit,
    required this.category,
    required this.date,
  });
}

class TransactionsModel {
  final String withdrawableBalance;
  final String dateRangeLabel;
  final List<TransactionItemModel> allTransactions;

  const TransactionsModel({
    required this.withdrawableBalance,
    required this.dateRangeLabel,
    required this.allTransactions,
  });

  static TransactionsModel get dummy => TransactionsModel(
        withdrawableBalance: '₹18,250',
        dateRangeLabel: '01 Oct - 31 Oct',
        allTransactions: [
          TransactionItemModel(
            id: 'TX_01',
            title: 'Settlement Credited',
            tag: 'Settlement',
            subtitle: 'HDFC Bank xxxx1234',
            timestamp: '25 Oct, 06:00 AM',
            amount: '₹12,400',
            isCredit: true,
            category: TransactionCategory.settlement,
            date: DateTime(2026, 10, 25, 6, 0),
          ),
          TransactionItemModel(
            id: 'TX_02',
            title: 'Order #EAT1234',
            tag: 'Food Order',
            subtitle: 'Rahul Sharma • Online',
            timestamp: '24 Oct, 08:30 PM',
            amount: '+₹650',
            isCredit: true,
            category: TransactionCategory.foodOrder,
            date: DateTime(2026, 10, 24, 20, 30),
          ),
          TransactionItemModel(
            id: 'TX_03',
            title: 'Order #EAT1235',
            tag: 'Food Order',
            subtitle: 'Priya Patel • COD',
            timestamp: '24 Oct, 07:15 PM',
            amount: '+₹420',
            isCredit: true,
            category: TransactionCategory.foodOrder,
            date: DateTime(2026, 10, 24, 19, 15),
          ),
          TransactionItemModel(
            id: 'TX_04',
            title: 'Subscription Payment',
            tag: 'Subscription',
            subtitle: 'Tiffin Plan 14 Days',
            timestamp: '23 Oct, 11:00 AM',
            amount: '+₹999',
            isCredit: true,
            category: TransactionCategory.subscription,
            date: DateTime(2026, 10, 23, 11, 0),
          ),
          TransactionItemModel(
            id: 'TX_05',
            title: 'Platform Fee',
            tag: 'Deduction',
            subtitle: 'Eatoggy Commission (2%)',
            timestamp: '23 Oct, 09:00 AM',
            amount: '-₹120',
            isCredit: false,
            category: TransactionCategory.deduction,
            date: DateTime(2026, 10, 23, 9, 0),
          ),
          TransactionItemModel(
            id: 'TX_06',
            title: 'GST Deduction',
            tag: 'Deduction',
            subtitle: 'Government Tax 5%',
            timestamp: '23 Oct, 09:00 AM',
            amount: '-₹85',
            isCredit: false,
            category: TransactionCategory.deduction,
            date: DateTime(2026, 10, 23, 9, 0),
          ),
          TransactionItemModel(
            id: 'TX_07',
            title: 'Order #EAT1230',
            tag: 'Food Order',
            subtitle: 'Aman Verma • Online',
            timestamp: '22 Oct, 09:45 PM',
            amount: '+₹780',
            isCredit: true,
            category: TransactionCategory.foodOrder,
            date: DateTime(2026, 10, 22, 21, 45),
          ),
          TransactionItemModel(
            id: 'TX_08',
            title: 'Subscription Payment',
            tag: 'Subscription',
            subtitle: 'Monthly Standard Tiffin',
            timestamp: '22 Oct, 12:30 PM',
            amount: '+₹2,400',
            isCredit: true,
            category: TransactionCategory.subscription,
            date: DateTime(2026, 10, 22, 12, 30),
          ),
          TransactionItemModel(
            id: 'TX_09',
            title: 'Settlement Credited',
            tag: 'Settlement',
            subtitle: 'HDFC Bank xxxx1234',
            timestamp: '21 Oct, 06:00 AM',
            amount: '₹15,200',
            isCredit: true,
            category: TransactionCategory.settlement,
            date: DateTime(2026, 10, 21, 6, 0),
          ),
          TransactionItemModel(
            id: 'TX_10',
            title: 'Platform Fee',
            tag: 'Deduction',
            subtitle: 'Eatoggy Commission (2%)',
            timestamp: '21 Oct, 09:00 AM',
            amount: '-₹310',
            isCredit: false,
            category: TransactionCategory.deduction,
            date: DateTime(2026, 10, 21, 9, 0),
          ),
        ],
      );
}
