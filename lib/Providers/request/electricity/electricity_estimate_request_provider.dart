import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workshop/Data/electricity/country_name.dart';
import 'package:workshop/Data/electricity/electricity_unit.dart';
import 'package:workshop/Models/Request/electricity_estimate_request.dart';

part 'electricity_estimate_request_provider.g.dart';

@riverpod
class ElectricityRequestState extends _$ElectricityRequestState {
  @override
  ElectricityEstimateRequest build() {
    return ElectricityEstimateRequest(
      countryName: CountryName.malaysia,
      electricityValue: 0,
      electricityUnit: ElectricityUnit.kWh,
    );
  }

  void updateCountryName(CountryName countryName) {
    state = state.copyWith(countryName: countryName);
  }

  void updateElectricityUnit(ElectricityUnit unit) {
    state = state.copyWith(electricityUnit: unit);
  }

  void updateElectricityValue(double value) {
    state = state.copyWith(electricValue: value);
  }
}
