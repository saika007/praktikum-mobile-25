import 'package:hive/hive.dart';
import '../models/purchase_history.dart';

class HistoryRepository {
  final Box<PurchaseHistory> box = Hive.box<PurchaseHistory>('purchase_history');

  Future<void> addHistory(PurchaseHistory history) async {
    await box.add(history);
  }

  List<PurchaseHistory> getHistory() {
    return box.values.toList().reversed.toList();
  }

  void clearHistory() {
    box.clear();
  }
}
