import 'package:get/get.dart';
import '../../../data/services/purchase_history_service.dart';
import '../../../data/models/purchase_history.dart';

class PurchaseHistoryController extends GetxController {
  final service = PurchaseHistoryService();

  var history = <PurchaseHistory>[].obs;

  String get userId => "demoUser"; // replace with FirebaseAuth

  Future<void> loadHistory() async {
    history.value = await service.getPurchaseHistory(userId);
  }
}
