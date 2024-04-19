part of 'store_bloc.dart';

sealed class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

final class StoreInitial extends StoreState {}

final class BrandLoadingState extends StoreState {}

final class BrandLoadedState extends StoreState {
  final List<BrandModel> brands;

  const BrandLoadedState({required this.brands});

  @override
  List<Object> get props => [brands];
}

final class SelectedBrandLoading extends StoreState {}

final class SelectedBrandLoaded extends StoreState {
  final List<ProductModel> brandProducts;

  const SelectedBrandLoaded({required this.brandProducts});

  @override
  List<Object> get props => [brandProducts];
}

final class CategoryProductsLoading extends StoreState {}

final class CategoryProductsLoaded extends StoreState {
  final List<CategoryModel> categoryData;

  const CategoryProductsLoaded({required this.categoryData});

  @override
  List<Object> get props => [categoryData];
}

final class StoreErrorState extends StoreState {
  final String errorMessage;
  final String? errorCode;

  const StoreErrorState({required this.errorMessage, this.errorCode});
  @override
  List<Object> get props => [errorMessage];
}
