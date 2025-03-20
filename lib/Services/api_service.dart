import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:workshop/Models/Request/electricity_estimate_request.dart';

import '../Models/Request/transportation_request.dart';
import '../Models/Response/carbon_emission_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://carbonsutra1.p.rapidapi.com")
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @POST("/vehicle_estimate_by_type")
  Future<CarbonEmissionResponse> estimateVehicleEmission(
    @Body() TransportationRequest request,
    @Header("Authorization") String bearerToken,
    @Header("x-rapidapi-host") String apiHost,
    @Header("x-rapidapi-key") String apiKey,
  );

  @POST("/electricity_estimate")
  Future<CarbonEmissionResponse> estimateElectricityEmission(
    @Body() ElectricityEstimateRequest request,
    @Header("Authorization") String bearerToken,
    @Header("x-rapidapi-host") String apiHost,
    @Header("x-rapidapi-key") String apiKey,
  );
}
