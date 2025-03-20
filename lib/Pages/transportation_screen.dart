import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workshop/Pages/Widget/emission_card.dart';

import '../Constant/theme.dart';
import '../Data/transportation/distance_unit.dart';
import '../Data/transportation/fuel_type.dart';
import '../Data/transportation/vehicle_type.dart';
import '../Providers/request/transportation_request_provider.dart';
import '../Providers/response/transportation_response_provider.dart';
import 'Widget/calculate_button.dart';
import 'Widget/custom_drop_down.dart';
import 'Widget/skeleton_loading.dart';
import 'Widget/text_field.dart';

class TransportationScreen extends ConsumerStatefulWidget {
  const TransportationScreen({super.key});

  @override
  ConsumerState<TransportationScreen> createState() =>
      _TransportationScreenState();
}

class _TransportationScreenState extends ConsumerState<TransportationScreen> {
  late TextEditingController distanceValueController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    distanceValueController = TextEditingController(text: "0");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    distanceValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // listen to API
    final reqState = ref.watch(transportationRequestStateProvider);
    final resState = ref.watch(transportationResponseStateProvider);
    final reqNotifier = ref.read(transportationRequestStateProvider.notifier);
    final resNotifier = ref.read(transportationResponseStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transportations Emissions"),
        backgroundColor: primaryBlue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: height * 0.5 - kToolbarHeight),
            child: IntrinsicHeight(
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  resState.when(
                    data: (response) => emissionCard(
                      height: height,
                      width: width,
                      co2eGm: response?.co2eGm ?? 0,
                      co2eLb: response?.co2eLb ?? 0,
                      co2eKg: response?.co2eKg ?? 0,
                      co2eMt: response?.co2eMt ?? 0,
                      icon: CupertinoIcons.car,
                      iconColor: secondaryBlue,
                    ),
                    error: (errorText, stackTrace) => Text(
                      "Error: ${errorText.toString()}",
                      style: normal(color: error),
                    ),
                    loading: () =>
                        emissionCardSkeleton(height: height, width: width),
                  ),
                  Text(
                    "Please enter your data:",
                    style: normal(bold: true),
                  ),
                  Row(
                    spacing: 16,
                    children: [
                      expandedTextField(
                        height: height,
                        labelText: "Distance Traveled",
                        textController: distanceValueController,
                        onChanged: (value) {
                          reqNotifier.updateDistanceValue(double.parse(value));
                        },
                      ),
                      customDropdown(
                        labelText: "Distance Unit",
                        items: DistanceUnit.values,
                        value: reqState.distanceUnit,
                        onChanged: (value) {
                          reqNotifier.updateDistanceUnit(value as DistanceUnit);
                        },
                        width: width,
                        height: height,
                      ),
                    ],
                  ), // Row
                  customDropdown(
                    labelText: "Vehicle Type",
                    items: VehicleType.values,
                    value: reqState.vehicleType,
                    onChanged: (value) {
                      reqNotifier.updateVehicleType(value as VehicleType);
                    },
                    width: width,
                    height: height,
                  ),

                  customDropdown(
                    labelText: "Fuel Type",
                    items: FuelType.values,
                    value: reqState.fuelType,
                    onChanged: (value) {
                      reqNotifier.updateFuelType(value as FuelType);
                    },
                    width: width,
                    height: height,
                  ),
                  calculateButton(
                    width: width,
                    height: height,
                    btnColor: secondaryBlue,
                    onTap: () {
                      resNotifier.calculateTransportationEmission(reqState);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
