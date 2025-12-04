import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../models/purchase_history.dart';
import '../models/cart_item.dart';

class PurchaseHistoryService {
  final historyBox = Hive.box<PurchaseHistory>('purchase_history');
  final firestore = FirebaseFirestore.instance;

  // SAVE BOTH ONLINE + OFFLINE
  Future<void> savePurchase(
    List<CartItem> items,
    double total,
    String userId,
  ) async {
    final purchase = PurchaseHistory(
      items: items,
      total: total,
      date: DateTime.now(),
    );

    // Save locally (Hive)
    historyBox.add(purchase);

    // Save online (Firestore)
    await firestore.collection("orders").add({
      "userId": userId,
      ...purchase.toJson(),
    });
  }

  // READ ONLINE → FALLBACK TO OFFLINE
  Future<List<PurchaseHistory>> getPurchaseHistory(String userId) async {
    try {
      final snap = await firestore
          .collection("orders")
          .where("userId", isEqualTo: userId)
          .orderBy("date", descending: true)
          .get();

      if (snap.docs.isNotEmpty) {
        return snap.docs
            .map((doc) => PurchaseHistory.fromJson(doc.data()))
            .toList();
      }
    } catch (_) {}

    // Fallback offline
    return historyBox.values.toList().reversed.toList();
  }
}
