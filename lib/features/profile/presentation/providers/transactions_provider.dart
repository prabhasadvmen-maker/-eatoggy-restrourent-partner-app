import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/transactions_model.dart';

class TransactionsState {
  final TransactionsModel model;
  final String selectedType;
  final String dateRangeLabel;
  final DateTime? startDate;
  final DateTime? endDate;
  final int visibleCount;

  const TransactionsState({
    required this.model,
    this.selectedType = 'All Types',
    this.dateRangeLabel = '01 Oct - 31 Oct',
    this.startDate,
    this.endDate,
    this.visibleCount = 6,
  });

  List<TransactionItemModel> get filteredTransactions {
    return model.allTransactions.where((item) {
      if (selectedType != 'All Types' && item.tag != selectedType) {
        return false;
      }
      if (startDate != null && endDate != null) {
        if (item.date.isBefore(startDate!) || item.date.isAfter(endDate!.add(const Duration(days: 1)))) {
          return false;
        }
      }
      return true;
    }).take(visibleCount).toList();
  }

  int get totalMatchingCount {
    return model.allTransactions.where((item) {
      if (selectedType != 'All Types' && item.tag != selectedType) {
        return false;
      }
      if (startDate != null && endDate != null) {
        if (item.date.isBefore(startDate!) || item.date.isAfter(endDate!.add(const Duration(days: 1)))) {
          return false;
        }
      }
      return true;
    }).length;
  }

  bool get canLoadMore => visibleCount < totalMatchingCount;

  TransactionsState copyWith({
    TransactionsModel? model,
    String? selectedType,
    String? dateRangeLabel,
    DateTime? startDate,
    DateTime? endDate,
    int? visibleCount,
  }) {
    return TransactionsState(
      model: model ?? this.model,
      selectedType: selectedType ?? this.selectedType,
      dateRangeLabel: dateRangeLabel ?? this.dateRangeLabel,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      visibleCount: visibleCount ?? this.visibleCount,
    );
  }
}

class TransactionsNotifier extends Notifier<TransactionsState> {
  @override
  TransactionsState build() {
    return TransactionsState(
      model: TransactionsModel.dummy,
    );
  }

  void filterByType(String type) {
    state = state.copyWith(
      selectedType: type,
      visibleCount: 6,
    );
  }

  Future<void> selectDateRange(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
      initialDateRange: state.startDate != null && state.endDate != null
          ? DateTimeRange(start: state.startDate!, end: state.endDate!)
          : DateTimeRange(
              start: DateTime(now.year, 10, 1),
              end: DateTime(now.year, 10, 31),
            ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFD9A24F),
              onPrimary: Color(0xFF11110F),
              surface: Color(0xFF1C1C1A),
              onSurface: Color(0xFFFFF1D2),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final label = '${_formatDate(picked.start)} - ${_formatDate(picked.end)}';
      state = state.copyWith(
        startDate: picked.start,
        endDate: picked.end,
        dateRangeLabel: label,
        visibleCount: 6,
      );
    }
  }

  String _formatDate(DateTime dt) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final day = dt.day.toString().padLeft(2, '0');
    final month = months[dt.month - 1];
    return '$day $month';
  }

  bool loadMore() {
    if (state.canLoadMore) {
      state = state.copyWith(visibleCount: state.visibleCount + 4);
      return true;
    }
    return false;
  }
}

final transactionsProvider =
    NotifierProvider<TransactionsNotifier, TransactionsState>(
  TransactionsNotifier.new,
);
