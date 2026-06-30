import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Tharad Task'**
  String get appName;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @validationRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get validationRequired;

  /// No description provided for @validationInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get validationInvalidEmail;

  /// No description provided for @validationNameValidation.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 3 characters long'**
  String get validationNameValidation;

  /// No description provided for @validationInvalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number format'**
  String get validationInvalidPhone;

  /// No description provided for @validationPasswordCriteria.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one uppercase letter, one lowercase letter, one digit, and one special character.'**
  String get validationPasswordCriteria;

  /// No description provided for @validationPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get validationPasswordMismatch;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @didForgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Did you forget password?'**
  String get didForgetPassword;

  /// No description provided for @haventAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t you have an account?'**
  String get haventAccount;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create new account'**
  String get createAccount;

  /// No description provided for @profilePic.
  ///
  /// In en, this message translates to:
  /// **'Profile picture'**
  String get profilePic;

  /// No description provided for @allowedFiles.
  ///
  /// In en, this message translates to:
  /// **'Allowed files are in JPEG, PNG.'**
  String get allowedFiles;

  /// No description provided for @maxSize.
  ///
  /// In en, this message translates to:
  /// **'Max size'**
  String get maxSize;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User name'**
  String get userName;

  /// No description provided for @passwordConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get passwordConfirmation;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Do you have account?'**
  String get haveAccount;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verificationCode;

  /// No description provided for @otpMsg.
  ///
  /// In en, this message translates to:
  /// **'To complete the account setup, enter the verification code sent via email.'**
  String get otpMsg;

  /// No description provided for @didntReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t you receive a code?'**
  String get didntReceiveCode;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get next;

  /// No description provided for @oldPassword.
  ///
  /// In en, this message translates to:
  /// **'Old password'**
  String get oldPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @newPasswordConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get newPasswordConfirmation;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @changesSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Changes Saved Successfully'**
  String get changesSavedSuccessfully;

  /// No description provided for @changesSavedFailure.
  ///
  /// In en, this message translates to:
  /// **'Failed to save changes'**
  String get changesSavedFailure;

  /// No description provided for @homeImage.
  ///
  /// In en, this message translates to:
  /// **'Flutter intern to build real mobile apps'**
  String get homeImage;

  /// No description provided for @aboutInternship.
  ///
  /// In en, this message translates to:
  /// **'About Internship'**
  String get aboutInternship;

  /// No description provided for @aboutInternship1.
  ///
  /// In en, this message translates to:
  /// **'This Flutter training program isn\'t a traditional course; it\'s a practical program designed to prepare trainees to work on real-world projects within the company. During the training, trainees will be part of the team, working with real code, real requirements, and problems solved daily in existing projects—not just experimental applications or learning examples. The training focuses on ensuring trainees:'**
  String get aboutInternship1;

  /// No description provided for @aboutInternship2.
  ///
  /// In en, this message translates to:
  /// **'. Understand the company\'s workflow'**
  String get aboutInternship2;

  /// No description provided for @aboutInternship3.
  ///
  /// In en, this message translates to:
  /// **'. Adhere to professional coding standards'**
  String get aboutInternship3;

  /// No description provided for @aboutInternship4.
  ///
  /// In en, this message translates to:
  /// **'. Work with Git and version control'**
  String get aboutInternship4;

  /// No description provided for @aboutInternship5.
  ///
  /// In en, this message translates to:
  /// **'. Work effectively as part of a team and receive continuous feedbackThe. primary goal of the training is to transform trainees from learners into confident Flutter developers capable of confidently working on any project.'**
  String get aboutInternship5;

  /// No description provided for @workNature.
  ///
  /// In en, this message translates to:
  /// **'Nature of work during training'**
  String get workNature;

  /// No description provided for @homeBullet1.
  ///
  /// In en, this message translates to:
  /// **'Participating in the development of real mobile applications'**
  String get homeBullet1;

  /// No description provided for @homeBullet2.
  ///
  /// In en, this message translates to:
  /// **'Implementing required features in existing projects'**
  String get homeBullet2;

  /// No description provided for @homeBullet3.
  ///
  /// In en, this message translates to:
  /// **'Working with actual APIs and backends'**
  String get homeBullet3;

  /// No description provided for @homeBullet4.
  ///
  /// In en, this message translates to:
  /// **'Bug fixes and performance improvements'**
  String get homeBullet4;

  /// No description provided for @homeBullet5.
  ///
  /// In en, this message translates to:
  /// **'Adherence to Clean Code and Clear Architecture'**
  String get homeBullet5;

  /// No description provided for @main.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get main;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get myProfile;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Hello Tharad teck!'**
  String get homeTitle;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @imageSize.
  ///
  /// In en, this message translates to:
  /// **'The image size must not exceed 5 MB'**
  String get imageSize;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Pick from gallery'**
  String get gallery;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @imageReguired.
  ///
  /// In en, this message translates to:
  /// **'The image is required'**
  String get imageReguired;

  /// No description provided for @otpError.
  ///
  /// In en, this message translates to:
  /// **'Wrong OTP'**
  String get otpError;

  /// No description provided for @loginSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Login Successfully'**
  String get loginSuccessfully;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
