import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/local_store/local_storage.dart';

part 'on_board_state.dart';

class OnBoardCubit extends Cubit<OnBoardState> {
  final pageController = PageController();
  int currentPageIndex = 0;

  OnBoardCubit() : super(OnBoardInitial());

  void updatePageIndicator(index) => currentPageIndex = index;

  void dotNavigationClick(index) {
    currentPageIndex = index;
    pageController.jumpTo(index);
  }

  void skipPage() async {
    currentPageIndex = 2;
    pageController.jumpToPage(2);
    await LocalStorageService.setBool('onBoardFinish', true);
    emit(OnBoardFinished());
  }

  void nextPage() async {
    if (currentPageIndex == 2) {
      await LocalStorageService.setBool('onBoardFinish', true);
      emit(OnBoardFinished());
    } else {
      int page = currentPageIndex + 1;
      pageController.jumpToPage(page);
    }
  }
}
