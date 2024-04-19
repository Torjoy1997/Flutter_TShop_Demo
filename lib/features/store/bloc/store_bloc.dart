import 'package:ecommerce_demo/features/store/model/category.dart';
import 'package:ecommerce_demo/features/store/repos/store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../product/model/product.dart';
import '../model/brand.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoreRepository _storeRepository;
  StoreBloc(this._storeRepository) : super(StoreInitial()) {
    on<BrandEvent>(_onFetchBrands);
    on<SelectedBrandEvent>(_onSelectedBrandProducts);
    on<CategoryProductsEvent>(_onCategoryProducts);
  }

  void _onFetchBrands(BrandEvent event, Emitter<StoreState> emit) async {
    try {
      emit(BrandLoadingState());
      final brands = await _storeRepository.getAllBrands();
      emit(BrandLoadedState(brands: brands));
    } catch (e) {
      emit(StoreErrorState(errorMessage: e.toString()));
    }
  }

  void _onSelectedBrandProducts(
      SelectedBrandEvent event, Emitter<StoreState> emit) async {
    try {
      emit(SelectedBrandLoading());
      final brandProducts =
          await _storeRepository.fetchBrandProducts(event.brandName);
      emit(SelectedBrandLoaded(brandProducts: brandProducts));
    } catch (e) {
      emit(StoreErrorState(errorMessage: e.toString()));
    }
  }

  void _onCategoryProducts(
      CategoryProductsEvent event, Emitter<StoreState> emit) async {
    try {
      emit(CategoryProductsLoading());
      final categoryData = await _storeRepository.getCategoryProducts();
      emit(CategoryProductsLoaded(categoryData: categoryData));
    } catch (e) {
      emit(StoreErrorState(errorMessage: e.toString()));
    }
  }
}
