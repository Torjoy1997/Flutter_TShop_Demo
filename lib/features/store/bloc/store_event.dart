part of 'store_bloc.dart';

sealed class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object> get props => [];
}

class BrandEvent extends StoreEvent {}

class SelectedBrandEvent extends StoreEvent {
  final String brandName;

  const SelectedBrandEvent({required this.brandName});
}

class CategoryProductsEvent extends StoreEvent {}
