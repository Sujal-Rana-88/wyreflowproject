import 'package:get/get.dart';
import 'package:wreflowproject/screens/flash_card_screen/bindings/flash_card_binding.dart';
import 'package:wreflowproject/screens/flash_card_screen/views/flash_card_screen.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => FlashcardScreen(),
      binding: FlashCardBinding(),
    ),
  ];
}
