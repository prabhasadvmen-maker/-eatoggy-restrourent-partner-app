class PeriodEarnings {
  const PeriodEarnings({
    required this.periodLabel,
    required this.totalEarnings,
    required this.trendText,
    required this.isTrendPositive,
    required this.foodOrdersAmount,
    required this.foodOrdersCount,
    required this.subscriptionsAmount,
    required this.subscriptionsCount,
    required this.packagingAmount,
    required this.packagingRate,
  });

  final String periodLabel;
  final String totalEarnings;
  final String trendText;
  final bool isTrendPositive;
  final String foodOrdersAmount;
  final String foodOrdersCount;
  final String subscriptionsAmount;
  final String subscriptionsCount;
  final String packagingAmount;
  final String packagingRate;
}

class DayTrendItem {
  const DayTrendItem({
    required this.dayLabel,
    required this.heightFactor,
    this.isHighlighted = false,
    required this.amount,
  });

  final String dayLabel;
  final double heightFactor;
  final bool isHighlighted;
  final String amount;
}

class TransactionItem {
  const TransactionItem({
    required this.id,
    required this.code,
    required this.type,
    required this.timeAgo,
    required this.amount,
    required this.isCredit,
  });

  final String id;
  final String code;
  final String type;
  final String timeAgo;
  final String amount;
  final bool isCredit;
}

class RevenueEarningsModel {
  const RevenueEarningsModel({
    required this.partnerName,
    required this.selectedPeriod,
    required this.periodsData,
    required this.weeklyTrend,
    required this.transactions,
  });

  final String partnerName;
  final String selectedPeriod;
  final Map<String, PeriodEarnings> periodsData;
  final List<DayTrendItem> weeklyTrend;
  final List<TransactionItem> transactions;

  PeriodEarnings get activeEarnings =>
      periodsData[selectedPeriod] ?? periodsData['This Month']!;

  RevenueEarningsModel copyWith({
    String? partnerName,
    String? selectedPeriod,
    Map<String, PeriodEarnings>? periodsData,
    List<DayTrendItem>? weeklyTrend,
    List<TransactionItem>? transactions,
  }) {
    return RevenueEarningsModel(
      partnerName: partnerName ?? this.partnerName,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      periodsData: periodsData ?? this.periodsData,
      weeklyTrend: weeklyTrend ?? this.weeklyTrend,
      transactions: transactions ?? this.transactions,
    );
  }

  static const dummy = RevenueEarningsModel(
    partnerName: "Chef Giovanni's Bistro",
    selectedPeriod: 'This Month',
    periodsData: {
      'Today': PeriodEarnings(
        periodLabel: 'TODAY',
        totalEarnings: '₹2,840',
        trendText: '+8% vs yesterday',
        isTrendPositive: true,
        foodOrdersAmount: '₹2,340',
        foodOrdersCount: '9 orders',
        subscriptionsAmount: '₹400',
        subscriptionsCount: '2 plans',
        packagingAmount: '₹100',
        packagingRate: 'Flat rate',
      ),
      'This Week': PeriodEarnings(
        periodLabel: 'THIS WEEK',
        totalEarnings: '₹14,250',
        trendText: '+15% vs last week',
        isTrendPositive: true,
        foodOrdersAmount: '₹11,900',
        foodOrdersCount: '48 orders',
        subscriptionsAmount: '₹1,800',
        subscriptionsCount: '5 plans',
        packagingAmount: '₹550',
        packagingRate: 'Flat rate',
      ),
      'This Month': PeriodEarnings(
        periodLabel: 'THIS MONTH',
        totalEarnings: '₹45,650',
        trendText: '+12% vs last month',
        isTrendPositive: true,
        foodOrdersAmount: '₹38,200',
        foodOrdersCount: '142 orders',
        subscriptionsAmount: '₹5,800',
        subscriptionsCount: '12 plans',
        packagingAmount: '₹1,650',
        packagingRate: 'Flat rate',
      ),
      'Custom': PeriodEarnings(
        periodLabel: 'CUSTOM RANGE',
        totalEarnings: '₹52,100',
        trendText: 'Selected date range',
        isTrendPositive: true,
        foodOrdersAmount: '₹43,000',
        foodOrdersCount: '160 orders',
        subscriptionsAmount: '₹7,200',
        subscriptionsCount: '15 plans',
        packagingAmount: '₹1,900',
        packagingRate: 'Flat rate',
      ),
    },
    weeklyTrend: [
      DayTrendItem(dayLabel: 'M', heightFactor: 0.45, amount: '₹3,200'),
      DayTrendItem(dayLabel: 'T', heightFactor: 0.70, amount: '₹4,900'),
      DayTrendItem(dayLabel: 'W', heightFactor: 0.55, amount: '₹3,800'),
      DayTrendItem(dayLabel: 'T', heightFactor: 0.75, amount: '₹5,200'),
      DayTrendItem(dayLabel: 'F', heightFactor: 0.65, amount: '₹4,500'),
      DayTrendItem(
        dayLabel: 'S',
        heightFactor: 0.95,
        isHighlighted: true,
        amount: '₹7,100',
      ),
      DayTrendItem(dayLabel: 'S', heightFactor: 0.60, amount: '₹4,200'),
    ],
    transactions: [
      TransactionItem(
        id: '1',
        code: 'EAT1234',
        type: 'Food Order',
        timeAgo: '10m ago',
        amount: '+₹650',
        isCredit: true,
      ),
      TransactionItem(
        id: '2',
        code: 'SUB4092',
        type: 'Tiffin Subscription',
        timeAgo: '1h ago',
        amount: '+₹1,200',
        isCredit: true,
      ),
      TransactionItem(
        id: '3',
        code: 'SETTL_04',
        type: 'Bank Settlement',
        timeAgo: 'Yesterday',
        amount: '-₹12,400',
        isCredit: false,
      ),
    ],
  );
}
