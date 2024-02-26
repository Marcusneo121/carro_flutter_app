import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/core/widget/carro_text_form_field.dart';
import 'package:carro_flutter_app/core/widget/rounded_button.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/widgets/register_top_bar_widget.dart';
import 'package:carro_flutter_app/modules/cars/add_car/view_model/add_car_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({super.key});

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  TextEditingController carBrandAndNameController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController engineCapacityController = TextEditingController();
  TextEditingController yearMadeController = TextEditingController();
  TextEditingController seatController = TextEditingController();
  TextEditingController carPlateController = TextEditingController();
  bool isElectricCar = false;
  String? engineCapacityErrorMessage;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: Consumer<AddCarProvider>(
          builder: (context, registerModel, child) {
            return Container(
              // padding: const EdgeInsets.symmetric(
              //     vertical: Dimensions.dp_15, horizontal: Dimensions.dp_30),
              margin: const EdgeInsets.only(
                left: Dimensions.dp_30,
                right: Dimensions.dp_30,
                bottom: Dimensions.dp_40,
              ),
              child: RoundedButton(
                  buttonText: 'Next',
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    await nextButtonFunction(registerModel, context);
                    setState(() {});
                  }),
            );
          },
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              Consumer<AddCarProvider>(
                builder: (context, addCarModel, child) {
                  return SliverAppBar(
                    pinned: true,
                    scrolledUnderElevation: 0.0,
                    leadingWidth: Dimensions.dp_290,
                    leading: RegisterTopBarWidget(
                      titleAppBar: 'Share your car',
                      icon: Icons.close_rounded,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        showCupertinoDialog(
                            context: context,
                            builder: (_) => CupertinoAlertDialog(
                                  title: const Text("Are you sure?"),
                                  content: Container(
                                    margin: const EdgeInsets.only(
                                        top: Dimensions.dp_10),
                                    child: const Text(
                                        "Information filled will not be save if quit."),
                                  ),
                                  actions: [
                                    // Close the dialog
                                    // You can use the CupertinoDialogAction widget instead
                                    CupertinoButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          locator<CarroRouter>().pop();
                                        }),
                                    CupertinoButton(
                                      child: const Text('Quit'),
                                      onPressed: () {
                                        addCarModel.clearCar();
                                        locator<CarroRouter>().pop();
                                        locator<CarroRouter>().pop();
                                      },
                                    )
                                  ],
                                ));
                      },
                    ),
                  );
                },
              ),
              Consumer<AddCarProvider>(
                builder: (context, addCarModel, child) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: Dimensions.dp_10,
                        bottom: Dimensions.dp_10,
                        left: Dimensions.dp_36,
                        right: Dimensions.dp_36,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: Dimensions.dp_10),
                          Text(
                            'Car Brand & Name',
                            style:
                                CarroTextStyles.large_normal_text_bold.copyWith(
                              color: CarroColors.getColor(
                                context,
                                CarroColors.registerHeadlineColor,
                              ),
                            ),
                          ),
                          CarroTextFormField(
                            textInputType: TextInputType.text,
                            topGapHeight: Dimensions.dp_10,
                            bottomGapHeight: Dimensions.dp_10,
                            controller: carBrandAndNameController,
                            hintText: 'e.g. Perodua Myvi',
                            onChanged: (value) {},
                          ),
                          const SizedBox(height: Dimensions.dp_10),
                          Text(
                            'Color',
                            style:
                                CarroTextStyles.large_normal_text_bold.copyWith(
                              color: CarroColors.getColor(
                                context,
                                CarroColors.registerHeadlineColor,
                              ),
                            ),
                          ),
                          CarroTextFormField(
                            textInputType: TextInputType.text,
                            topGapHeight: Dimensions.dp_10,
                            bottomGapHeight: Dimensions.dp_10,
                            controller: colorController,
                            hintText: 'e.g. Yellow',
                            onChanged: (value) {},
                          ),
                          Row(
                            children: [
                              SizedBox(
                                child: Checkbox(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  fillColor: MaterialStateProperty.all<Color>(
                                    CarroColors.getColor(
                                        context, CarroColors.primayColor),
                                  ),
                                  checkColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  value: isElectricCar,
                                  onChanged: (value) {
                                    setState(() {
                                      isElectricCar = !isElectricCar;
                                    });
                                  },
                                ),
                              ),
                              Text(
                                'Is Electric Car ?', //Power Outputs
                                style: CarroTextStyles.large_normal_text_bold
                                    .copyWith(
                                  color: CarroColors.getColor(
                                    context,
                                    CarroColors.registerHeadlineColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimensions.dp_10),
                          Text(
                            isElectricCar
                                ? "Power Output (kW)"
                                : 'Engine Capacity (cc)',
                            style:
                                CarroTextStyles.large_normal_text_bold.copyWith(
                              color: CarroColors.getColor(
                                context,
                                CarroColors.registerHeadlineColor,
                              ),
                            ),
                          ),
                          CarroTextFormField(
                            errorMessage: engineCapacityErrorMessage,
                            topGapHeight: Dimensions.dp_10,
                            bottomGapHeight: Dimensions.dp_10,
                            controller: engineCapacityController,
                            textInputType:
                                const TextInputType.numberWithOptions(
                                    signed: true, decimal: true),
                            textInputFormatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9.]")),
                            ],
                            hintText: isElectricCar ? 'e.g. 500' : 'e.g. 1.5',
                            onChanged: (value) {
                              // if (isElectricCar) {
                              //   if (engineCapacityController.text.contains("cc") ||
                              //       engineCapacityController.text.contains("CC") ||
                              //       engineCapacityController.text.contains("cC") ||
                              //       engineCapacityController.text.contains("Cc")) {
                              //     engineCapacityErrorMessage =
                              //         "Electric Car cannot have engine capacity.";
                              //   } else {
                              //     engineCapacityErrorMessage = null;
                              //   }
                              // } else {
                              //   if (engineCapacityController.text.contains("kw") ||
                              //       engineCapacityController.text.contains("Kw") ||
                              //       engineCapacityController.text.contains("kW") ||
                              //       engineCapacityController.text.contains("KW")) {
                              //     engineCapacityErrorMessage =
                              //         "Engine Capacity cannot have power output";
                              //   } else {
                              //     engineCapacityErrorMessage = null;
                              //   }
                              // }
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: Dimensions.dp_10),
                          Text(
                            'Year Made',
                            style:
                                CarroTextStyles.large_normal_text_bold.copyWith(
                              color: CarroColors.getColor(
                                context,
                                CarroColors.registerHeadlineColor,
                              ),
                            ),
                          ),
                          CarroTextFormField(
                            topGapHeight: Dimensions.dp_10,
                            bottomGapHeight: Dimensions.dp_10,
                            controller: yearMadeController,
                            textInputType:
                                const TextInputType.numberWithOptions(
                                    signed: true),
                            textInputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            hintText: 'e.g. 2024',
                            onChanged: (value) {},
                          ),
                          const SizedBox(height: Dimensions.dp_10),
                          Text(
                            'Car Plate',
                            style:
                                CarroTextStyles.large_normal_text_bold.copyWith(
                              color: CarroColors.getColor(
                                context,
                                CarroColors.registerHeadlineColor,
                              ),
                            ),
                          ),
                          CarroTextFormField(
                            topGapHeight: Dimensions.dp_10,
                            bottomGapHeight: Dimensions.dp_10,
                            controller: carPlateController,
                            textInputType: TextInputType.text,
                            hintText: 'e.g. ABC 1234',
                            onChanged: (value) {},
                          ),
                          const SizedBox(height: Dimensions.dp_10),
                          Text(
                            'Seat',
                            style:
                                CarroTextStyles.large_normal_text_bold.copyWith(
                              color: CarroColors.getColor(
                                context,
                                CarroColors.registerHeadlineColor,
                              ),
                            ),
                          ),
                          CarroTextFormField(
                            topGapHeight: Dimensions.dp_10,
                            bottomGapHeight: Dimensions.dp_10,
                            controller: seatController,
                            textInputType:
                                const TextInputType.numberWithOptions(
                                    signed: true),
                            textInputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            hintText: 'e.g. 4',
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  nextButtonFunction(AddCarProvider addCarModel, BuildContext context) async {
    if (carBrandAndNameController.text.isEmpty ||
        colorController.text.isEmpty ||
        engineCapacityController.text.isEmpty ||
        yearMadeController.text.isEmpty ||
        carPlateController.text.isEmpty ||
        seatController.text.isEmpty) {
      EasyLoading.showError(
          "Please ensure all information about your car is fill.");
    } else {
      await addCarModel.addCarPage1Updater(
        carBrandAndName: carBrandAndNameController.text.toString(),
        carColor: colorController.text.toString(),
        isElectricCar: isElectricCar,
        engineCapacity: engineCapacityController.text.toString(),
        yearMade: yearMadeController.text.toString(),
        seatNumber: seatController.text.toString(),
        carPlate: carPlateController.text.toString(),
      );
      //Go to next add car page
      locator<CarroRouter>().navigateTo(CarRoute.addCar2);
    }
  }
}
