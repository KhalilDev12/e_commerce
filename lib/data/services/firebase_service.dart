import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  late FirebaseFirestore firestore;

  FirebaseService() {
    firestore = FirebaseFirestore.instance;
  }

  // Get All Categories from firebase
  Stream<QuerySnapshot<Object>>? getAllCategories() {
    try {
      final response = firestore.collection("Categories");
      return response.snapshots();
    } catch (e) {
      print(e);
      return const Stream.empty();
    }
  }

  // Get All Products from firebase
  Stream<QuerySnapshot<Object>>? getAllProducts() {
    try {
      final response = firestore.collection("Products");
      return response.snapshots();
    } catch (e) {
      print(e);
      return const Stream.empty();
    }
  }
}
