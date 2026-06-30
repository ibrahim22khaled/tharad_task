import 'package:tharad_task/core/values/app_colors.dart';
import 'package:tharad_task/core/values/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

const int appOtpFieldsLength = 4;
const Color _fieldColor = AppColors.white;
const Color _focusedFieldColor = AppColors.white;
const Color _filledBorderColor = Color(0xffDFDFDF);
const Color _errorBorderColor = AppColors.red500;
const _fieldRadius = BorderRadius.all(
  Radius.circular(8),
);
final _textStyle = AppTextStyles.bold24.copyWith(color: AppColors.black);
final _errorTextStyle = AppTextStyles.medium15.copyWith(color: AppColors.red500);
//const double _unFocusBorderWidth = 1;
const double _focusBorderWidth = 1.2;

class OtpPinCodeWidget extends StatelessWidget {
  final bool hasError;
  final String? errorMessage;
  final bool readOnly;
  final TextEditingController controller;
  final void Function(String value)? onChanged;
  final void Function(String value)? onCompleted;
  final String? Function(String? value)? validator;

  const OtpPinCodeWidget({
    super.key,
    required this.controller,
    this.hasError = false,
    this.errorMessage,
    this.readOnly = false,
    this.onChanged,
    this.validator,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final double fieldSize =
        ((MediaQuery.of(context).size.width / appOtpFieldsLength) -
            (appOtpFieldsLength + 10));
    final fieldHeight = fieldSize * .9;
    // if (fieldSize > 48) {
    //   fieldSize = 48;
    // }
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        controller: controller,
        readOnly: readOnly,
        cursor: Container(
          width: 3,
          // margin: EdgeInsets.only(top: fieldSize * .3),
          height: fieldHeight * .35,
          alignment: Alignment.center,
          color: AppColors.primary,
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        keyboardType: TextInputType.phone,
        autofocus: true,
        // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
        // preFilledWidget: Container(
        //   width: fieldSize * .3,
        //   margin: EdgeInsets.only(top: fieldHeight * .3),
        //   height: 2,
        //   alignment: Alignment.bottomCenter,
        //   color: AppColors.label,
        // ),
        defaultPinTheme: PinTheme(
          width: fieldSize,
          height: fieldHeight,
          textStyle: _textStyle,
          decoration: BoxDecoration(
            color: _fieldColor,
            borderRadius: _fieldRadius,
            border: Border.all(
              color: _filledBorderColor,
            ),
          ),
        ),
        submittedPinTheme: PinTheme(
          width: fieldSize,
          height: fieldHeight,
          textStyle: _textStyle,
          decoration: BoxDecoration(
            color: _fieldColor,
            borderRadius: _fieldRadius,
            border: Border.all(
              color: _filledBorderColor,
            ),
          ),
        ),
        followingPinTheme: PinTheme(
          width: fieldSize,
          height: fieldHeight,
          textStyle: _textStyle,
          decoration: BoxDecoration(
            color: _fieldColor,
            borderRadius: _fieldRadius,
            border: Border.all(
              color: _filledBorderColor,
            ),
          ),
        ),
        focusedPinTheme: PinTheme(
          width: fieldSize,
          height: fieldHeight,
          textStyle: _textStyle,
          decoration: BoxDecoration(
            color: _focusedFieldColor,
            borderRadius: _fieldRadius,
            border: Border.all(
              color: AppColors.primary,
            ),
          ),
        ),
        errorPinTheme: PinTheme(
          width: fieldSize,
          height: fieldHeight,
          textStyle: _textStyle,
          decoration: BoxDecoration(
            color: _fieldColor,
            borderRadius: _fieldRadius,
            border: Border.all(
              color: _errorBorderColor,
              width: _focusBorderWidth,
            ),
          ),
        ),
        forceErrorState: hasError,
        errorTextStyle: _errorTextStyle,
        onChanged: onChanged,
        onCompleted: onCompleted,
        validator: validator,
        errorText: errorMessage,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
      ),
    );
  }
}
