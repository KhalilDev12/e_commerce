import 'package:e_commerce/data/models/models.dart';
import 'package:e_commerce/data/services/firebase_service.dart';

class ProductRepository {
  late FirebaseService service;

  ProductRepository() {
    service = FirebaseService();
  }

  // Get All Products from firebase Service
  Stream<List<ProductModel>> getAllProducts() {
    final products = service.getAllProducts();
    if (products != null) {
      return products.map((snapshot) {
        return snapshot.docs
            .map((doc) => ProductModel.fromSnapshot(doc))
            .toList();
      });
    } else {
      return const Stream.empty();
    }
  }
}
