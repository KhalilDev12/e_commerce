import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/data/models/checkout_model.dart';

class CheckoutRepository {
  final FirebaseFirestore _firebaseFirestore;

  CheckoutRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> addCheckout(CheckoutModel checkoutModel) {
    return _firebaseFirestore
        .collection("Checkout")
        .add(checkoutModel.toDocument());
  }
}
