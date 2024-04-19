import 'package:ecommerce_demo/features/Autocomplete/repos/auto_complete.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/autocomplete_model.dart';

part 'auto_complete_state.dart';

class AutoCompleteCubit extends Cubit<AutoCompleteState> {
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
}
