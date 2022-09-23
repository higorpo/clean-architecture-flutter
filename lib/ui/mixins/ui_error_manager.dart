import 'package:flutter/material.dart';

import '../helpers/helpers.dart';
import '../components/components.dart';

mixin UiErrorManager {
  void handleMainError(BuildContext context, Stream<UIError?> stream) {
    stream.listen((error) {
      if (error != null) {
        showErrorMessage(context, error.description);
      }
    });
  }
}
