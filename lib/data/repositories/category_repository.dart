import 'package:e_commerce/data/services/firebase_service.dart';

import '../models/models.dart';

class CategoryRepository {
  late FirebaseService service;

  CategoryRepository() {
    service = FirebaseService();
  }

  // Get All Categories from firebase Service
  Stream<List<CategoryModel>> getAllCategories() {
    final categories = service.getAllCategories();
    if (categories != null) {
      return categories.map((snapshot) {
        return snapshot.docs
            .map((doc) => CategoryModel.fromSnapshot(doc))
            .toList();
      });
    } else {
      return const Stream.empty();
    }
  }
}
