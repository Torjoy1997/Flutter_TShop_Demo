part of 'network_cubit.dart';

sealed class NetworkState extends Equatable {
  const NetworkState();

  @override
  List<Object> get props => [];
}

final class NetworkLoading extends NetworkState {}

final class NetworkConnected extends NetworkState {
  final ConnectionType connectionType;

  const NetworkConnected({required this.connectionType});

  @override
  List<Object> get props => [connectionType];
}

final class NetworkDisConnected extends NetworkState {}
