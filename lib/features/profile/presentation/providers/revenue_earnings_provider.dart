import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/revenue_earnings_model.dart';

class RevenueEarningsState {
  const RevenueEarningsState({
    required this.model,
    this.selectedPeriod = 'This Month',
  });

  final RevenueEarningsModel model;
  final String selectedPeriod;

  PeriodEarnings get activeEarnings =>
      model.periodsData[selectedPeriod] ??
      model.periodsData['This Month']!;

  RevenueEarningsState copyWith({
    RevenueEarningsModel? model,
    String? selectedPeriod,
  }) {
    return RevenueEarningsState(
      model: model ?? this.model,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
    );
  }
}

class RevenueEarningsNotifier extends Notifier<RevenueEarningsState> {
  @override
  RevenueEarningsState build() {
    return const RevenueEarningsState(
      model: RevenueEarningsModel.dummy,
      selectedPeriod: 'This Month',
    );
  }

  void selectPeriod(String period) {
    state = state.copyWith(
      selectedPeriod: period,
      model: state.model.copyWith(selectedPeriod: period),
    );
  }

  Future<void> selectCustomDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2025),
      lastDate: DateTime(2027),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFD9A24F),
              surface: Color(0xFF1C1C1A),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectPeriod('Custom');
    }
  }
}

final revenueEarningsProvider =
    NotifierProvider<RevenueEarningsNotifier, RevenueEarningsState>(
  RevenueEarningsNotifier.new,
);
