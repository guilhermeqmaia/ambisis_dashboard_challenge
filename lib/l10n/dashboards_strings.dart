import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'dashboards_strings_pt.dart';

/// Callers can lookup localized strings with an instance of DashboardStrings
/// returned by `DashboardStrings.of(context)`.
///
/// Applications need to include `DashboardStrings.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/dashboards_strings.dart';
///
/// return MaterialApp(
///   localizationsDelegates: DashboardStrings.localizationsDelegates,
///   supportedLocales: DashboardStrings.supportedLocales,
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
/// be consistent with the languages listed in the DashboardStrings.supportedLocales
/// property.
abstract class DashboardStrings {
  DashboardStrings(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static DashboardStrings? of(BuildContext context) {
    return Localizations.of<DashboardStrings>(context, DashboardStrings);
  }

  static const LocalizationsDelegate<DashboardStrings> delegate = _DashboardStringsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('pt')
  ];

  /// No description provided for @dashboardEsg.
  ///
  /// In pt, this message translates to:
  /// **'Dashboard ESG'**
  String get dashboardEsg;

  /// No description provided for @filterSectionTitle.
  ///
  /// In pt, this message translates to:
  /// **'Filtros'**
  String get filterSectionTitle;

  /// No description provided for @filterSectionButtonYears.
  ///
  /// In pt, this message translates to:
  /// **'Anos'**
  String get filterSectionButtonYears;

  /// No description provided for @filterSectionDatePickerButton.
  ///
  /// In pt, this message translates to:
  /// **'Por Data'**
  String get filterSectionDatePickerButton;

  /// No description provided for @filterSectionDatePickerInitialDate.
  ///
  /// In pt, this message translates to:
  /// **'Selecione a Data Inicial'**
  String get filterSectionDatePickerInitialDate;

  /// No description provided for @filterSectionDatePickerInitialConfirmation.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar'**
  String get filterSectionDatePickerInitialConfirmation;

  /// No description provided for @filterSectionDatePickerInitialCancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get filterSectionDatePickerInitialCancel;

  /// No description provided for @filterSectionDatePickerFinalDate.
  ///
  /// In pt, this message translates to:
  /// **'Selecione a Data Final'**
  String get filterSectionDatePickerFinalDate;

  /// No description provided for @filterSectionDatePickerFinalConfirmation.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar'**
  String get filterSectionDatePickerFinalConfirmation;

  /// No description provided for @filterSectionDatePickerFinalCancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get filterSectionDatePickerFinalCancel;

  /// No description provided for @noDataAvailableTitle.
  ///
  /// In pt, this message translates to:
  /// **'Ops, Tivemos um Problema'**
  String get noDataAvailableTitle;

  /// No description provided for @noDataAvailableSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível gerar um gráfico com base nos dados do período disponibilizado.'**
  String get noDataAvailableSubtitle;

  /// No description provided for @noDataAvailableDescription.
  ///
  /// In pt, this message translates to:
  /// **'Para ter informações aqui, você pode alterar o filtro que define o período de tempo analisado ou inserir dados na base para que possamos construir o gráfico.'**
  String get noDataAvailableDescription;

  /// No description provided for @chartSectionTitle.
  ///
  /// In pt, this message translates to:
  /// **'Resumo'**
  String get chartSectionTitle;

  /// No description provided for @chartSectionRegular.
  ///
  /// In pt, this message translates to:
  /// **'Regular'**
  String get chartSectionRegular;

  /// No description provided for @chartSectionGrowth.
  ///
  /// In pt, this message translates to:
  /// **'Crescimento'**
  String get chartSectionGrowth;

  /// No description provided for @chartSectionTotal.
  ///
  /// In pt, this message translates to:
  /// **'Total'**
  String get chartSectionTotal;

  /// No description provided for @chartSectionAverage.
  ///
  /// In pt, this message translates to:
  /// **'Média'**
  String get chartSectionAverage;

  /// No description provided for @chartSectionFinished.
  ///
  /// In pt, this message translates to:
  /// **'Concluídas'**
  String get chartSectionFinished;

  /// No description provided for @developmentSectionEnvironmental.
  ///
  /// In pt, this message translates to:
  /// **'Ambiental'**
  String get developmentSectionEnvironmental;

  /// No description provided for @developmentSectionSocial.
  ///
  /// In pt, this message translates to:
  /// **'Social'**
  String get developmentSectionSocial;

  /// No description provided for @developmentSectionGovernance.
  ///
  /// In pt, this message translates to:
  /// **'Governança'**
  String get developmentSectionGovernance;

  /// No description provided for @developmentSectionOther.
  ///
  /// In pt, this message translates to:
  /// **'Outros'**
  String get developmentSectionOther;

  /// No description provided for @developmentSectionTotal.
  ///
  /// In pt, this message translates to:
  /// **'Total: '**
  String get developmentSectionTotal;

  /// No description provided for @developmentSectionFinished.
  ///
  /// In pt, this message translates to:
  /// **'Concluídas: '**
  String get developmentSectionFinished;
}

class _DashboardStringsDelegate extends LocalizationsDelegate<DashboardStrings> {
  const _DashboardStringsDelegate();

  @override
  Future<DashboardStrings> load(Locale locale) {
    return SynchronousFuture<DashboardStrings>(lookupDashboardStrings(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_DashboardStringsDelegate old) => false;
}

DashboardStrings lookupDashboardStrings(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'pt': return DashboardStringsPt();
  }

  throw FlutterError(
    'DashboardStrings.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
