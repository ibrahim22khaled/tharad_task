import 'package:flutter/material.dart';

class CompleteCheckerNotifier extends ValueNotifier<bool> {
  final bool Function() _check;

  CompleteCheckerNotifier(this._check) : super(false);

  void recheck() {
    value = _check();
  }
}