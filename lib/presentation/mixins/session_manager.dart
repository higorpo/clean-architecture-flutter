import 'package:get/get.dart';

mixin SessionManager on GetxController {
  final _isSessionExpired = Rx<bool?>(null);
  Stream<bool?> get isSessionExpiredStream => _isSessionExpired.stream;

  set isSessionExpired(bool value) => _isSessionExpired.value = value;
}
