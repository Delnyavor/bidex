part of 'barter_bloc.dart';

class BarterState extends Equatable {
  final BarterPageStatus barterPageStatus;
  final CreateBarterStatus createBarterStatus;
  final List<BarterItem> items;
  final String errorMessage;
  final bool hasReachedMax;

  const BarterState({
    this.barterPageStatus = BarterPageStatus.loading,
    this.createBarterStatus = CreateBarterStatus.initial,
    this.items = const [],
    this.errorMessage = '',
    this.hasReachedMax = false,
  });

  BarterState copyWith(
      {BarterPageStatus? barterPageStatus,
      CreateBarterStatus? createBarterStatus,
      List<BarterItem>? items,
      String? errorMessage,
      bool? hasReachedMax}) {
    return BarterState(
      barterPageStatus: barterPageStatus ?? this.barterPageStatus,
      createBarterStatus: createBarterStatus ?? this.createBarterStatus,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [
        barterPageStatus,
        items,
        errorMessage,
        hasReachedMax,
        createBarterStatus
      ];
}

enum BarterPageStatus {
  loading,
  loaded,
  empty,
  error,
  initialError,
}

enum CreateBarterStatus {
  initial,
  creationSuccess,
  creationError,
}
