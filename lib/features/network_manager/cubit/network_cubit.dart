import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_demo/utils/constants/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final Connectivity connectivity;
  late StreamSubscription connectivitySubscription;
  NetworkCubit({required this.connectivity}) : super(NetworkLoading()) {
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionType.wifi);
      } else if (connectivityResult == ConnectivityResult.none) {
        emitDisConnected();
      }
    });
  }

  void emitInternetConnected(ConnectionType connectedType) =>
      emit(NetworkConnected(connectionType: connectedType));

  void emitDisConnected() => emit(NetworkDisConnected());

  @override
  Future<void> close() {
    connectivitySubscription.cancel();
    return super.close();
  }
}
