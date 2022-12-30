part of 'barter_bloc.dart';

class BarterState extends Equatable {
  final BarterPageStatus barterPageStatus;
  final List<BarterItem> items;
  final String errorMessage;
  final bool hasReachedMax;

  const BarterState({
    this.barterPageStatus = BarterPageStatus.loading,
    this.items = const [],
    this.errorMessage = '',
    this.hasReachedMax = false,
  });

  BarterState copyWith(
      {BarterPageStatus? barterPageStatus,
      List<BarterItem>? items,
      String? errorMessage,
      bool? hasReachedMax}) {
    return BarterState(
      barterPageStatus: barterPageStatus ?? this.barterPageStatus,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props =>
      [barterPageStatus, items, errorMessage, hasReachedMax];
}

enum BarterPageStatus { loading, loaded, empty, error, initialError }
