import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workshop/Data/electricity/country_name.dart';
import 'package:workshop/Data/electricity/electricity_unit.dart';
import 'package:workshop/Providers/request/electricity/electricity_estimate_request_provider.dart';
import 'package:workshop/Providers/response/electricity/electricity_response_provider.dart';

import '../Constant/theme.dart';
import 'Widget/calculate_button.dart';
import 'Widget/custom_drop_down.dart';
import 'Widget/emission_card.dart';
import 'Widget/skeleton_loading.dart';
import 'Widget/text_field.dart';

class ElectricityScreen extends ConsumerStatefulWidget {
  const ElectricityScreen({super.key});

  @override
  ConsumerState<ElectricityScreen> createState() => _ElectricityScreenState();
}

class _ElectricityScreenState extends ConsumerState<ElectricityScreen> {
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
    final reqState = ref.watch(electricityRequestStateProvider);
    final resState = ref.watch(electricityResponseStateProvider);
    final reqNotifier = ref.read(electricityRequestStateProvider.notifier);
    final resNotifier = ref.read(electricityResponseStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transportations Emissions"),
        backgroundColor: primaryYellow,
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
                      icon: CupertinoIcons.bolt,
                      iconColor: secondaryYellow,
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
                        labelText: "Electricity Used",
                        textController: distanceValueController,
                        onChanged: (value) {
                          reqNotifier
                              .updateElectricityValue(double.parse(value));
                        },
                      ),
                      customDropdown(
                        labelText: "Electric Measurement Unit",
                        items: ElectricityUnit.values,
                        value: reqState.electricityUnit,
                        onChanged: (value) {
                          reqNotifier
                              .updateElectricityUnit(value as ElectricityUnit);
                        },
                        width: width,
                        height: height,
                      ),
                    ],
                  ),
                  customDropdown(
                    labelText: "Country",
                    items: CountryName.values,
                    value: reqState.countryName,
                    onChanged: (value) {
                      reqNotifier.updateCountryName(value as CountryName);
                    },
                    width: width,
                    height: height,
                  ),
                  calculateButton(
                    width: width,
                    height: height,
                    btnColor: primaryYellow,
                    onTap: () {
                      resNotifier.calculateElectricityEmission(reqState);
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
