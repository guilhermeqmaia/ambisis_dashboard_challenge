import 'dashboards_strings.dart';

/// The translations for Portuguese (`pt`).
class DashboardStringsPt extends DashboardStrings {
  DashboardStringsPt([String locale = 'pt']) : super(locale);

  @override
  String get dashboardEsg => 'Dashboard ESG';

  @override
  String get filterSectionTitle => 'Filtros';

  @override
  String get filterSectionButtonYears => 'Anos';

  @override
  String get filterSectionDatePickerButton => 'Por Data';

  @override
  String get filterSectionDatePickerInitialDate => 'Selecione a Data Inicial';

  @override
  String get filterSectionDatePickerInitialConfirmation => 'Confirmar';

  @override
  String get filterSectionDatePickerInitialCancel => 'Cancelar';

  @override
  String get filterSectionDatePickerFinalDate => 'Selecione a Data Final';

  @override
  String get filterSectionDatePickerFinalConfirmation => 'Confirmar';

  @override
  String get filterSectionDatePickerFinalCancel => 'Cancelar';

  @override
  String get chartSectionNoGraphAvailableTitle => 'Ops, Tivemos um Problema';

  @override
  String get chartSectionNoGraphAvailableSubtitle => 'Não foi possível gerar um gráfico com base nos dados do período disponibilizado.';

  @override
  String get chartSectionNoGraphAvailableDescription => 'Para ter informações aqui, você pode alterar o filtro que define o período de tempo analisado ou inserir dados na base para que possamos construir o gráfico.';

  @override
  String get chartSectionTitle => 'Resumo';

  @override
  String get chartSectionRegular => 'Regular';

  @override
  String get chartSectionGrowth => 'Crescimento';

  @override
  String get chartSectionTotal => 'Total';

  @override
  String get chartSectionAverage => 'Média';

  @override
  String get chartSectionFinished => 'Concluídas';

  @override
  String get developmentSectionEnvironmental => 'Ambiental';

  @override
  String get developmentSectionSocial => 'Social';

  @override
  String get developmentSectionGovernance => 'Governança';

  @override
  String get developmentSectionOther => 'Outros';

  @override
  String get developmentSectionTotal => 'Total: ';

  @override
  String get developmentSectionFinished => 'Concluídas: ';
}
