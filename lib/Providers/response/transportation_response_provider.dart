import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../Models/Request/transportation_request.dart';
import '../../Models/Response/carbon_emission_response.dart';
import '../../Services/api_service.dart';

part 'transportation_response_provider.g.dart';

@riverpod
class TransportationResponseState extends _$TransportationResponseState {
  late final ApiService _apiService;

  @override
  Future<CarbonEmissionResponse?> build() {
    final dio = Dio();
    _apiService = ApiService(dio);
    return Future.value(null);
  }

  Future<void> calculateTransportationEmission(
      TransportationRequest request) async {
    try {
      state = const AsyncLoading();
      final response = await _apiService.estimateVehicleEmission(
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
