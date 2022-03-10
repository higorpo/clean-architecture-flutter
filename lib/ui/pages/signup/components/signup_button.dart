import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(R.strings.enter.toUpperCase()),
      onPressed: null,
    );
  }
}
