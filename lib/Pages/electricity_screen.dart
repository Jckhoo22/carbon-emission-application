import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Constant/theme.dart';

class ElectricityScreen extends StatefulWidget {
  const ElectricityScreen({super.key});

  @override
  State<ElectricityScreen> createState() => _ElectricityScreenState();
}

class _ElectricityScreenState extends State<ElectricityScreen> {
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
    final reqState = ref.watch(elec);
    final resState = ref.watch(transportationResponseStateProvider);
    final reqNotifier = ref.read(transportationRequestStateProvider.notifier);
    final resNotifier = ref.read(transportationResponseStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Electricity Emissions"),
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
                  ),
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
