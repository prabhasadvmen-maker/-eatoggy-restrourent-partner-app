class CreateTiffinPlanModel {
  const CreateTiffinPlanModel({
    required this.title,
    required this.subtitle,
    required this.planName,
    required this.selectedCycleType,
    required this.pricingPerCycle,
    required this.mealsPerDay,
    required this.rotatingWeeklyMenu,
    required this.serviceablePincodes,
    required this.maxSubscriberCap,
    required this.planDescription,
    required this.cycleOptions,
    required this.mealOptions,
  });

  final String title;
  final String subtitle;
  final String planName;
  final String selectedCycleType;
  final String pricingPerCycle;
  final int mealsPerDay;
  final bool rotatingWeeklyMenu;
  final String serviceablePincodes;
  final String maxSubscriberCap;
  final String planDescription;
  final List<String> cycleOptions;
  final List<int> mealOptions;

  static const dummy = CreateTiffinPlanModel(
    title: 'Create Tiffin Plan',
    subtitle: 'Define meal subscription parameters',
    planName: 'Office Special Lunch Plan',
    selectedCycleType: 'Monthly Plan',
    pricingPerCycle: '1499',
    mealsPerDay: 1,
    rotatingWeeklyMenu: true,
    serviceablePincodes: '380015, 380054',
    maxSubscriberCap: '50',
    planDescription:
        'Daily wholesome office lunch delivered hot before 1:00 PM. Balanced nutritional mix of carbs, proteins, salads and fresh home-style rotis.',
    cycleOptions: [
      'Monthly Plan',
      'Weekly Plan',
      '15 Days Trial Plan',
    ],
    mealOptions: [1, 2, 3],
  );

  CreateTiffinPlanModel copyWith({
    String? title,
    String? subtitle,
    String? planName,
    String? selectedCycleType,
    String? pricingPerCycle,
    int? mealsPerDay,
    bool? rotatingWeeklyMenu,
    String? serviceablePincodes,
    String? maxSubscriberCap,
    String? planDescription,
    List<String>? cycleOptions,
    List<int>? mealOptions,
  }) {
    return CreateTiffinPlanModel(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      planName: planName ?? this.planName,
      selectedCycleType: selectedCycleType ?? this.selectedCycleType,
      pricingPerCycle: pricingPerCycle ?? this.pricingPerCycle,
      mealsPerDay: mealsPerDay ?? this.mealsPerDay,
      rotatingWeeklyMenu: rotatingWeeklyMenu ?? this.rotatingWeeklyMenu,
      serviceablePincodes: serviceablePincodes ?? this.serviceablePincodes,
      maxSubscriberCap: maxSubscriberCap ?? this.maxSubscriberCap,
      planDescription: planDescription ?? this.planDescription,
      cycleOptions: cycleOptions ?? this.cycleOptions,
      mealOptions: mealOptions ?? this.mealOptions,
    );
  }
}
