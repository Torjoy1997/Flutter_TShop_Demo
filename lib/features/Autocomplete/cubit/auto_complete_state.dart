part of 'auto_complete_cubit.dart';

sealed class AutoCompleteState extends Equatable {
  const AutoCompleteState();

  @override
  List<Object> get props => [];
}

final class AutoCompleteLoadingState extends AutoCompleteState {}

final class AutoCompleteLoadedState extends AutoCompleteState {
  final List<AutoCompleteModel> autoCompeleData;

  const AutoCompleteLoadedState({required this.autoCompeleData});

  @override
  List<Object> get props => [autoCompeleData];
}

final class AutoCompleteErrorState extends AutoCompleteState {
  final String errorMessage;

  const AutoCompleteErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
