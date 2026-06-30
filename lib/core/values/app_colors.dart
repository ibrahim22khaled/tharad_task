import 'package:flutter/material.dart';

abstract class AppColors {
  const AppColors();
  static const Color white = Colors.white;
  static const Color black = Color(0xFF000000);
  static const Color black1B = Color(0xFF18181B);
  static const Color scaffoldBackgroundColor = Color(0xFFFAFAFA);
  static const Color sidebarbackground = Color(0xFF2E3038);
  //  --------------------  Primary  --------------------  //
  static const Color primary = Color(0xFF265355);
  static const Color primary5percent = Color(0xFFFFF6F8);
  static const Color primary10percent = Color(0xFFFEECF2);
  static const Color secondary = Color(0xFF54B7BB);
  static const Color textColor = Color(0xFF0D1D1E);
  static const Color authtextColor = Color(0xFF42867B);
  static const Color appTextFormFieldFillColor = Color(0xFFF4F7F6);
  static const Color activeTab = Color(0xFF2C6062);
  static const Color nonactiveTab = Color(0xFFADADAC);
  static const Color subText = Color(0xFF998C8C);


  static const Color borderColor = Color(0xFFC3C6D6);
  static const Color borderColorF2 = Color(0xFFF2F2F2);
  static const Color borderColorEF = Color(0xFFF0E6DE);
  static const Color cardColor = Color(0xFFF9FAFC);

  static LinearGradient get primaryGradient => const LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [primary, secondary],
  );
  static LinearGradient get homeAppBarGradient => const LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.topLeft,
    colors: [primary, secondary],
  );

  //  --------------------  Netural  --------------------  //
  static const Color text1EColor = Color(0xFF1E1E1E);
  static const Color hintTextColor = Color(0xFFA5ABBF);
  //  --------------------  Netural  --------------------  //

  static const Color netural20 = Color(0xFFE2E8F0);
  static const Color netural10 = Color(0xFFFFFFFF);

  static const Color netural30 = Color(0xFFFCFCFC);
  static const Color netural40 = Color(0xFFECEDEE);
  static const Color netural50 = Color(0xFFFAFAFA);
  static const Color netural100 = Color(0xFFF5F5F5);
  static const Color netural200 = Color(0xFFEEEEEE);
  static const Color netural300 = Color(0xFFCCCCCC);
  static const Color netural400 = Color(0xFFA3A3A3);
  static const Color netural450 = Color(0xFF64748B);
  static const Color netural500 = Color(0xFF666666);
  static const Color netural600 = Color(0xFF474747);
  static const Color netural700 = Color(0xFF292929);
  static const Color netural800 = Color(0xFF151515);

  //  --------------------  RED  --------------------  //

  static const Color red50 = Color(0xFFFFFBFB);
  static const Color red100 = Color(0xFFFEF2F2);
  static const Color red200 = Color(0xFFFFEBEE);
  static const Color red250 = Color(0xFFFBEAEA);
  static const Color red300 = Color(0xFFFFCCD2);
  static const Color red350 = Color(0xFFEAC3C3);
  static const Color red400 = Color(0xFFF49898);
  static const Color red500 = Color(0xFFEB6F70);
  static const Color red600 = Color(0xFFF64C4C);
  static const Color red650 = Color(0xFFEA0020);
  static const Color red700 = Color(0xFFEC2D30);
  static const Color red800 = Color(0xFFD32F2F);
  static const Color redawa2l = Color(0xFFFD7E14);

  static const Color red900 = Color(0xFFB10909);
  static const Color redError = Color(0xFFFF3B30);
  static const Color redColor38 = Color(0xffF04438);
  static const Color redLight = Color(0xFFF9EBEB);

  //  --------------------  ERROR  --------------------  //

  static const Color error = Color.fromARGB(255, 235, 64, 67);
  static const Color error100 = Color(0xFFF53D6B);

  //  --------------------  warning  --------------------  //

  static const Color warning50 = Color(0xFFFFFDFA);
  static const Color warning100 = Color(0xFFFFF9EE);
  static const Color warning200 = Color(0xFFFFF7E1);
  static const Color warning300 = Color(0xFFFFEAB3);
  static const Color warning400 = Color(0xFFFFDD82);
  static const Color warning500 = Color(0xFFFFC62B);
  static const Color warning600 = Color(0xFFFFAD0D);
  static const Color warning700 = Color(0xFFFE9B0E);

  //  --------------------  Success  --------------------  //

  static const Color success50 = Color(0xFFFBFEFC);
  static const Color success100 = Color(0xFFF2FAF6);
  static const Color success200 = Color(0xFFE5F5EC);
  static const Color success300 = Color(0xFFC0E5D1);
  static const Color success400 = Color(0xFF97D4B4);
  static const Color success500 = Color(0xFF6BC497);
  static const Color success600 = Color(0xFF47B881);
  static const Color success700 = Color(0xFF0C9D61);
  static const Color success800 = Color(0xFF00B80C);
  static const Color success800Cover = Color(0xFFF2F7ED);

  //  --------------------  GREY  --------------------  //

  static const Color darkGrayColor = Color(0xFF9F9F9F);
  static const Color gray30 = Color(0xFFE6EAF0);
  static const Color gray50 = Color(0xFFF7F7F7);
  static const Color gray100 = Color(0xFFEBEBEF);
  static const Color gray200 = Color(0xFFE6E6E6);
  static const Color gray250 = Color(0XFFE1E1E1);
  static const Color gray270 = Color(0xFFC1C1C1);
  static const Color gray300 = Color(0xff999999);
  static const Color gray400 = Color(0xFF959595);
  static const Color gray500 = Color(0XFF595959);
  static const Color gray450 = Color(0XFF757575);
  static const Color graylabel = Color(0XFFD5D5D5);

  static const Color grayD1 = Color(0XFFD1D1D1);
  static const Color grayD9 = Color(0XFFD9D9D9);
  static const Color grayB6 = Color(0XFFB6B6B6);
  static const Color grayE7 = Color(0XFFE7E7E7);
  static const Color grayC1 = Color(0XFF1C1C1C);
  static const Color grayE0 = Color(0XFFE0E0E0);
  static const Color gray66 = Color(0XFF666666);
  static const Color gray99 = Color(0XFF999999);
  static const Color textColorA1 = Color(0XFFA1A1A1);
  static const Color gray5B = Color(0XFF52525B);

  //  --------------------  Transparent  --------------------  //

  static const Color transparent = Colors.transparent;
  static const Color transparentBlack = Color.fromARGB(255, 0, 0, 0);

  //  --------------------  Text Colors  --------------------  //
  static Color greyText = const Color(0xFF282828).withAlpha((.8 * 255).toInt());

  // ---------------- forget screen message ----------//
  static const Color userMsg = Color(0XFF8088A4);
  static const Color expansionTileBorder = Color(0XFFE9EAEF);
  static const Color textFieldFillColor = Color(0XFFFAFBFC);
  static const Color textBFColor = Color(0XFFA5ABBF);
  static const Color bgF4Color = Color(0XFFF1F2F4);
  static const Color discountColor = Color(0XFFFFF5F8);
}
