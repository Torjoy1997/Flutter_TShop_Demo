part of 'dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

final class DashboardInitial extends DashboardState {}

final class BannerLoading extends DashboardState {}

final class BannerFetchSuccess extends DashboardState {
  final List<BannerModel> bannerModels;

  const BannerFetchSuccess({required this.bannerModels});
}

final class BannerLoadFailure extends DashboardState {
  final String errorMessage;
  final String? errorCode;

  const BannerLoadFailure({required this.errorMessage, this.errorCode});
}
