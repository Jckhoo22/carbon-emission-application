import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workshop/Models/Request/electricity_estimate_request.dart';

import '../../../Models/Response/carbon_emission_response.dart';
import '../../../Services/api_service.dart';

part 'electricity_response_provider.g.dart';

@riverpod
class ElectricityResponseState extends _$ElectricityResponseState {
  late final ApiService _apiService;

  @override
  Future<CarbonEmissionResponse?> build() {
    final dio = Dio();
    _apiService = ApiService(dio);
    return Future.value(null);
  }

  Future<void> calculateElectricityEmission(
      ElectricityEstimateRequest request) async {
    try {
      state = const AsyncLoading();
      final response = await _apiService.estimateElectricityEmission(
        request,
        dotenv.env["AUTH_BEARER_TOKEN"]!,
        dotenv.env["RAPIDAPI_HOST"]!,
        dotenv.env["RAPIDAPI_KEY"]!,
      );
      state = AsyncData(response);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
