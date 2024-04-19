import 'package:ecommerce_demo/features/Autocomplete/model/autocomplete_model.dart';
import 'package:ecommerce_demo/features/product/repos/product.dart';
import 'package:ecommerce_demo/features/store/repos/store.dart';
import 'package:ecommerce_demo/utils/constants/enums.dart';

class AutoCompleteRepository {
  final ProductRepository _productRepository = ProductRepository();
  final StoreRepository _storeRepository = StoreRepository();

  Future<List<AutoCompleteModel>> fetchAutocompleteData() async {
    try {
      final List<AutoCompleteModel> autoCompleteData = [];
      final productsData = await _productRepository.getAllProducts();
      final brandsData = await _storeRepository.getAllBrands();

      for (var product in productsData) {
        autoCompleteData.add(AutoCompleteModel(
            title: product.title,
            itemId: product.id,
            image: product.thumbnail));
      }

      for (var brand in brandsData) {
        autoCompleteData.add(AutoCompleteModel(
            title: brand.name,
            itemId: brand.id,
            image: brand.image,
            type: AutoCompleteType.brand));
      }

      return autoCompleteData;
    } catch (e) {
      throw e.toString();
    }
  }
}
