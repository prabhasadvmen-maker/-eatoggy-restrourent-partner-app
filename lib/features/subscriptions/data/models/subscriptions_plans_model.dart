class TiffinProgramItem {
  const TiffinProgramItem({
    required this.id,
    required this.title,
    required this.price,
    required this.mealDetails,
    required this.activeSubscribersCount,
  });

  final String id;
  final String title;
  final String price;
  final String mealDetails;
  final int activeSubscribersCount;
}

class DispatchLoadItem {
  const DispatchLoadItem({
    required this.header,
    required this.countText,
    required this.subtitle,
  });

  final String header;
  final String countText;
  final String subtitle;
}

class SubscriptionsPlansModel {
  const SubscriptionsPlansModel({
    required this.title,
    required this.subtitle,
    required this.monthlyEarningsTitle,
    required this.monthlyEarningsAmount,
    required this.activeUsersText,
    required this.programsSectionTitle,
    required this.programs,
    required this.dispatchSectionTitle,
    required this.dispatchLoads,
  });

  final String title;
  final String subtitle;
  final String monthlyEarningsTitle;
  final String monthlyEarningsAmount;
  final String activeUsersText;
  final String programsSectionTitle;
  final List<TiffinProgramItem> programs;
  final String dispatchSectionTitle;
  final List<DispatchLoadItem> dispatchLoads;

  static const dummy = SubscriptionsPlansModel(
    title: 'Subscription Plans',
    subtitle: 'Active custom meal programs',
    monthlyEarningsTitle: 'MONTHLY EARNINGS ESTIMATE',
    monthlyEarningsAmount: '₹52,000',
    activeUsersText: '57 active users',
    programsSectionTitle: 'Active Tiffin Programs',
    programs: [
      TiffinProgramItem(
        id: '1',
        title: 'Monthly Tiffin - Lunch',
        price: '₹999/mo',
        mealDetails: '2 Meals/day • Daily rotation menu',
        activeSubscribersCount: 45,
      ),
      TiffinProgramItem(
        id: '2',
        title: 'Weekly Tiffin - Dinner',
        price: '₹350/wk',
        mealDetails: '1 Meal/day • Lite home meals',
        activeSubscribersCount: 12,
      ),
    ],
    dispatchSectionTitle: 'Dispatch Load',
    dispatchLoads: [
      DispatchLoadItem(
        header: 'TODAY DELIVERIES',
        countText: '57 Packs',
        subtitle: '45 Lunch + 12 Dinner',
      ),
      DispatchLoadItem(
        header: 'TOMORROW PLAN',
        countText: '57 Packs',
        subtitle: 'Standard load expected',
      ),
    ],
  );
}
