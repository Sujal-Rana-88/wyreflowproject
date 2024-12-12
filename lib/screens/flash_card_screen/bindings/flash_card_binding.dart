import 'package:get/get.dart';
import 'package:wreflowproject/screens/flash_card_screen/controllers/flash_card_controller.dart';

class FlashCardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<FlashCardController>(() => FlashCardController());
  }
}