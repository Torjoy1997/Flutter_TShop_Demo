import 'package:ecommerce_demo/features/Autocomplete/repos/auto_complete.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../model/autocomplete_model.dart';

part 'auto_complete_state.dart';

class AutoCompleteCubit extends HydratedCubit<AutoCompleteState> {
  final AutoCompleteRepository autoCompleteRepository;
  AutoCompleteCubit(this.autoCompleteRepository)
      : super(AutoCompleteLoadingState());

  Future<void> fetchAutoCompleteData() async {
    try {
      final result = await autoCompleteRepository.fetchAutocompleteData();
      emit(AutoCompleteLoadedState(autoCompeleData: result));
    } catch (e) {
      emit(AutoCompleteErrorState(errorMessage: e.toString()));
    }
  }

  @override
  AutoCompleteState? fromJson(Map<String, dynamic> json) {
    return AutoCompleteLoadedState(autoCompeleData: json['searchData']);
  }

  @override
  Map<String, dynamic>? toJson(AutoCompleteState state) {
    if (state is AutoCompleteLoadedState) {
      return {'searchData': state.autoCompeleData};
    } else {
      return null;
    }
  }
}
