import 'package:get/get.dart';

mixin NavigationManager {
  void handleNavigation(Stream<String> stream, {bool clearStack = false}) {
    stream.listen((page) {
      if (page?.isNotEmpty == true) {
        if (clearStack == true) {
          Get.offAllNamed(page);
        } else {
          Get.toNamed(page);
        }
      }
    });
  }
}
