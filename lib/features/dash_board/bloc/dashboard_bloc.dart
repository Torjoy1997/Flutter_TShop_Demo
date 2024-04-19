import 'package:ecommerce_demo/features/dash_board/model/banner.dart';
import 'package:ecommerce_demo/features/dash_board/repos/banner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final BannerRepository _bannerRepository;
  DashboardBloc(this._bannerRepository) : super(DashboardInitial()) {
    on<BannerSetEvent>(_onSetBanners);
  }
  void _onSetBanners(BannerSetEvent event, Emitter<DashboardState> emit) async {
    try {
      emit(BannerLoading());
      final banners = await _bannerRepository.fetchBanners();
      emit(BannerFetchSuccess(bannerModels: banners));
    } catch (e) {
      emit(BannerLoadFailure(errorMessage: e.toString()));
    }
  }
}
