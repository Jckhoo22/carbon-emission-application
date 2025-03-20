import 'package:workshop/Data/electricity/country_name.dart';
import 'package:workshop/Data/electricity/electricity_unit.dart';

class ElectricityEstimateRequest {
  final CountryName countryName;
  final ElectricityUnit electricityUnit;
  final double electricityValue;

  ElectricityEstimateRequest({
    required this.countryName,
    required this.electricityUnit,
    required this.electricityValue,
  });

  ElectricityEstimateRequest copyWith({
    CountryName? countryName,
    ElectricityUnit? electricityUnit,
    double? electricValue,
  }) {
    return ElectricityEstimateRequest(
        countryName: countryName ?? this.countryName,
        electricityUnit: electricityUnit ?? this.electricityUnit,
        electricityValue: electricValue ?? electricityValue);
  }

  Map<String, dynamic> toJson() {
    return {
      "country_name": countryName.value,
      "electricity_unit": electricityUnit.value,
      "electricity_value": electricityValue,
    };
  }
}
