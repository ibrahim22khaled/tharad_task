import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tharad_task/core/values/app_colors.dart';
import 'package:tharad_task/core/values/app_text_style.dart';


class AppTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? inputType;
  final int? maxLength;
  final TextStyle? inputTextStyle;
  final Clip? clipBehavior;
  final List<TextInputFormatter>? inputFormatters;
  final TextDirection? textDirection;
  final String? initialValue;
  final bool readOnly;
  final bool? obscureText;
  final void Function()? onTap;
  final String? Function(String? text)? validate;
  final void Function(String text)? onChanged;
  final void Function(String text)? onFieldSubmitted;

  final String? label;
  final TextStyle? labelTextStyle;
  final String? hintText;
  final TextStyle? hintTextStyle;
  // final InputBorder? enabledBorder;
  // final InputBorder? focusedBorder;
  // final InputBorder? disabledBorder;
  // final InputBorder? errorBorder;
  // final InputBorder? focusedErrorBorder;
  final Widget Function(bool isFocused)? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final Widget? suffixIcon;
  final Widget? prefix;
  final EdgeInsetsGeometry margin;
  // final EdgeInsetsGeometry? contentPadding;
  // final bool? filled;
  final Color? fillColor;
  final double? height;
  final int? minLines;
  final int? maxLines;
  final bool isOptional;
  final bool isRequired;

  final bool isFloatingLabel;
  final AutovalidateMode? autovalidateMode;

  // final double titlePadding;

  const AppTextFormField({
    super.key,
    this.controller,
    this.margin = const EdgeInsets.only(bottom: 16),
    this.inputType,
    this.maxLength,
    this.inputTextStyle,
    this.clipBehavior = Clip.antiAliasWithSaveLayer,
    this.inputFormatters,
    this.textDirection,
    this.initialValue,
    this.readOnly = false,
    this.obscureText,
    this.onTap,
    this.validate,
    this.onChanged,
    this.onFieldSubmitted,
    // this.contentPadding,
    this.height,
    this.label,
    this.labelTextStyle,
    this.hintText,
    this.hintTextStyle,
    // this.enabledBorder,
    // this.focusedBorder,
    // this.disabledBorder,
    // this.errorBorder,
    // this.focusedErrorBorder,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.prefix,
    this.suffixIcon,
    // this.filled = true,
    this.fillColor = AppColors.appTextFormFieldFillColor,
    this.minLines,
    this.maxLines,
    this.isOptional = true,
    this.isRequired = false,
    this.isFloatingLabel = false,
    this.autovalidateMode,
    // this.titlePadding = 8,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  // bool isTextSecured = false;
  final _focusNode = FocusNode();
  // bool hasFocus = false;
  String? errorMsg;
  Color _borderColor = AppColors.borderColorEF;

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {
        _borderColor =
            _focusNode.hasFocus ? AppColors.primary : AppColors.borderColorEF;
      });
    });
    // _focusNode.addListener(() {
    //   if (_focusNode.hasFocus != hasFocus) {
    //     hasFocus = _focusNode.hasFocus;
    //     setState(() {});
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: (widget.maxLines == null && widget.maxLength == null)
                ? (widget.height ?? 56)
                : null,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(
                color: _borderColor,
              ),
              color: widget.fillColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                if (widget.prefix != null)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8),
                    child: widget.prefix!,
                  ),
                Expanded(
                  child: TextFormField(
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    focusNode: _focusNode,
                    cursorErrorColor: AppColors.red700,
                    controller: widget.controller,
                    keyboardType: widget.inputType,
                    maxLength: widget.maxLength,
                    style: widget.inputTextStyle ?? AppTextStyles.medium14,
                    cursorColor: AppColors.primary,
                    clipBehavior: widget.clipBehavior!,
                    inputFormatters: widget.inputFormatters,
                    textDirection: widget.textDirection,
                    initialValue: widget.initialValue,
                    readOnly: widget.readOnly,
                    obscureText: widget.obscureText ?? false,
                    onTap: () {
                      if (widget.onTap != null) {
                        widget.onTap!();
                        if (widget.readOnly) {
                          errorMsg = null;
                          setState(() {
                            _borderColor = _focusNode.hasFocus
                                ? AppColors.primary
                                : AppColors.borderColorEF;
                          });
                        }
                      }
                    },
                    validator: (value) {
                      if (widget.validate != null) {
                        errorMsg = widget.validate!(value);
                        setState(() {
                          _borderColor = errorMsg != null
                              ? AppColors.redError
                              : _focusNode.hasFocus
                                  ? AppColors.primary
                                  : AppColors.borderColorEF;
                        });
                      }

                      return errorMsg;
                    },
                    onChanged: (value) {
                      if (widget.onChanged != null) {
                        widget.onChanged!(value);
                      }
                      if (widget.validate != null) {
                        errorMsg = widget.validate!(value);

                        setState(() {
                          _borderColor = errorMsg != null
                              ? AppColors.redError
                              : _focusNode.hasFocus
                                  ? AppColors.primary
                                  : AppColors.borderColorEF;
                        });
                      }
                    },
                    onFieldSubmitted: widget.onFieldSubmitted,
                    minLines: widget.minLines ?? 1,
                    maxLines: widget.maxLines ?? 1,
                    decoration: InputDecoration(
                      // contentPadding: widget.contentPadding,
                      prefixIconConstraints: widget.prefixIconConstraints,
                      //  floatingLabelBehavior: FloatingLabelBehavior.auto,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelStyle: widget.labelTextStyle ??
                          AppTextStyles.regular14.copyWith(
                            color: AppColors.hintTextColor,
                          ),
                      floatingLabelStyle: AppTextStyles.medium16
                          .copyWith(color: AppColors.hintTextColor),
                      hintText: widget.hintText,
                      labelText: widget.label,
                      hintMaxLines: 10,
                      errorMaxLines: 10,
                      hintStyle: widget.hintTextStyle,
                      counter: const SizedBox.shrink(),
                      border: InputBorder.none,
                      errorStyle: const TextStyle(
                        height: 0.001,
                        color: Colors.transparent,
                      ),
                      // enabledBorder: widget.enabledBorder,
                      // focusedBorder: widget.focusedBorder,
                      // disabledBorder: widget.disabledBorder,

                      // errorBorder: widget.errorBorder,
                      // focusedErrorBorder: widget.focusedErrorBorder,
                      prefixIcon: _getPrefixWidget,
                      // prefixIconConstraints: widget.prefixIconConstraints,
                      // suffixIcon: widget.suffixIcon,
                      // filled: widget.filled,
                      // fillColor: widget.fillColor,
                    ),
                  ),
                ),
                if (widget.suffixIcon != null) widget.suffixIcon!,
              ],
            ),
          ),
          if (errorMsg != null)
            Container(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                errorMsg!,
                style: AppTextStyles.regular14.copyWith(color: AppColors.redError),
              ),
            ),
        ],
      ),
    );
  }

  // Widget? get _obsecureSuffix {
  //   if (widget.isTextSecured) {
  //     return InkWell(
  //       borderRadius: BorderRadius.circular(50),
  //       child: UnconstrainedBox(
  //         child: GradiantWidget(
  //           child: Icon(
  //             isTextSecured
  //                 ? Icons.visibility_off_outlined
  //                 : Icons.visibility_outlined,
  //             size: 18,
  //             weight: 50,
  //             opticalSize: 20,
  //             grade: -20,
  //             color: AppColors.netural500,
  //           ),
  //         ),
  //       ),
  //       onTap: () {
  //         setState(() {
  //           isTextSecured = !isTextSecured;
  //         });
  //       },
  //     );
  //   }
  //   return null;
  // }

  Widget? get _getPrefixWidget {
    if (widget.prefixIcon != null) {
      return UnconstrainedBox(
        child: widget.prefixIcon!(_focusNode.hasFocus),
      );
    }
    return null;
  }
}
