import 'package:tharad_task/l10n/app_localizations.dart';

class Validator {
  final String? inputText;
  final AppLocalizations l10n;

  Validator(this.inputText, this.l10n);

  String? get defaultValidator {
    final text = inputText?.replaceAll(RegExp(r'\s+'), '');
    if (text == null || text.trim().isEmpty) {
      return l10n.validationRequired;
    }
    return null;
  }

  String? get name {
    if (inputText != null) {
      final value = inputText?.trim() ?? '';
      if (defaultValidator != null) return defaultValidator;
      if (value.length < 3) return l10n.validationNameValidation;
    }
    return null;
  }

  final emailRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+.[a-zA-Z]+$",
  );

  String? email({bool isOptional = false}) {
    if (isOptional && (inputText == null || inputText == '')) return null;
    if (defaultValidator != null) return defaultValidator;
    if (!emailRegExp.hasMatch(inputText ?? '')) {
      return l10n.validationInvalidEmail;
    }
    return null;
  }

  String? get password {
    final RegExp regex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()])',
    );
    if (defaultValidator != null) return defaultValidator;
    if ((inputText ?? '').length < 8 || !regex.hasMatch(inputText ?? '')) {
      return l10n.validationPasswordCriteria;
    }
    return null;
  }

  String? confirmPasswordValidator(String? password) {
    if (password != inputText) return l10n.validationPasswordMismatch;
    return null;
  }
}
