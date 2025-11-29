import 'package:get/get.dart';
import '../controllers/menupage_controller.dart';

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuPageController>(() => MenuPageController());
  }
}
