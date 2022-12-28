part of 'barter_bloc.dart';

class BarterState extends Equatable {
  final BarterPageStatus barterPageStatus;
  final List<BarterItem> items;
  final String errorMessage;

  const BarterState({
    this.barterPageStatus = BarterPageStatus.loading,
    this.items = const [],
    this.errorMessage = '',
  });

  BarterState copyWith({
    BarterPageStatus? barterPageStatus,
    List<BarterItem>? items,
    String? errorMessage,
  }) {
    return BarterState(
      barterPageStatus: barterPageStatus ?? this.barterPageStatus,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [barterPageStatus, items];
}

enum BarterPageStatus { loading, loaded, empty, initial, error, initialError }
