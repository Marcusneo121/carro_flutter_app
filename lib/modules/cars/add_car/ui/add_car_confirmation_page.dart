import 'dart:io';

import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/core/widget/rounded_button.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/widgets/register_top_bar_widget.dart';
import 'package:carro_flutter_app/modules/cars/add_car/view_model/add_car_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddCarConfirmationPage extends StatefulWidget {
  const AddCarConfirmationPage({super.key});

  @override
  State<AddCarConfirmationPage> createState() => _AddCarConfirmationPageState();
}

class _AddCarConfirmationPageState extends State<AddCarConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: Consumer<AddCarProvider>(
          builder: (context, addCarModel, child) {
            return Container(
              // padding: const EdgeInsets.symmetric(
              //     vertical: Dimensions.dp_15, horizontal: Dimensions.dp_30),
              margin: const EdgeInsets.only(
                left: Dimensions.dp_36,
                right: Dimensions.dp_36,
                bottom: Dimensions.dp_40,
              ),
              child: RoundedButton(
                buttonText: 'Host now',
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  await addCarModel.addCar();
                  setState(() {});
                },
              ),
            );
          },
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                scrolledUnderElevation: 0.0,
                leadingWidth: Dimensions.dp_290,
                leading: RegisterTopBarWidget(
                  titleAppBar: 'Host your car',
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    locator<CarroRouter>().pop();
                  },
                ),
              ),
              Consumer<AddCarProvider>(
                builder: (context, addCarModel, child) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            top: Dimensions.dp_10,
                            bottom: Dimensions.dp_10,
                            left: Dimensions.dp_36,
                            right: Dimensions.dp_36,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: Dimensions.dp_10),
                              Text(
                                "Ensure all details about your car are correct. But do not worry you can edit later.",
                                style: CarroTextStyles.large_item_text.copyWith(
                                  color: CarroColors.getColor(
                                    context,
                                    CarroColors.textInputColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: Dimensions.dp_30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Car Brand and Model',
                                    style: CarroTextStyles.small_label.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: CarroColors.getColor(
                                        context,
                                        CarroColors.textInputColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: Dimensions.dp_5,
                                        top: Dimensions.dp_3),
                                    child: Text(
                                      "${addCarModel.carToAdd.carName}",
                                      style: CarroTextStyles.normal_text,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: Dimensions.dp_25),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Color',
                                        style: CarroTextStyles.small_label
                                            .copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: CarroColors.getColor(
                                            context,
                                            CarroColors.textInputColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: Dimensions.dp_5,
                                            top: Dimensions.dp_3),
                                        child: Text(
                                          "${addCarModel.carToAdd.color}",
                                          style: CarroTextStyles.normal_text,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: Dimensions.dp_20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Year made',
                                        style: CarroTextStyles.small_label
                                            .copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: CarroColors.getColor(
                                            context,
                                            CarroColors.textInputColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: Dimensions.dp_5,
                                            top: Dimensions.dp_3),
                                        child: Text(
                                          "${addCarModel.carToAdd.yearMade}",
                                          style: CarroTextStyles.normal_text,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: Dimensions.dp_25),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Seat',
                                        style: CarroTextStyles.small_label
                                            .copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: CarroColors.getColor(
                                            context,
                                            CarroColors.textInputColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: Dimensions.dp_5,
                                            top: Dimensions.dp_3),
                                        child: Text(
                                          "${addCarModel.carToAdd.seat} seats",
                                          style: CarroTextStyles.normal_text,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: Dimensions.dp_20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (addCarModel.carToAdd.isElectric ??
                                                false)
                                            ? "Power Output(kW)"
                                            : "Engine Capacity(cc)",
                                        style: CarroTextStyles.small_label
                                            .copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: CarroColors.getColor(
                                            context,
                                            CarroColors.textInputColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: Dimensions.dp_5,
                                            top: Dimensions.dp_3),
                                        child: Text(
                                          "${addCarModel.carToAdd.engineCapacity}",
                                          style: CarroTextStyles.normal_text,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: Dimensions.dp_25),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Car Plate',
                                        style: CarroTextStyles.small_label
                                            .copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: CarroColors.getColor(
                                            context,
                                            CarroColors.textInputColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: Dimensions.dp_5,
                                            top: Dimensions.dp_3),
                                        child: Text(
                                          "${addCarModel.carToAdd.carPlate}",
                                          style: CarroTextStyles.normal_text,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(
                                height: Dimensions.dp_60,
                                thickness: 0.5,
                                // indent: Dimensions.dp_20,
                                // endIndent: Dimensions.dp_20,
                                color: CarroColors.getColor(
                                    context, CarroColors.textInputColor),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Location',
                                    style: CarroTextStyles.small_label.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: CarroColors.getColor(
                                        context,
                                        CarroColors.textInputColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: Dimensions.dp_5,
                                        top: Dimensions.dp_3),
                                    child: Text(
                                      "${addCarModel.carToAdd.location}",
                                      style: CarroTextStyles.normal_text,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: Dimensions.dp_25),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Price',
                                    style: CarroTextStyles.small_label.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: CarroColors.getColor(
                                        context,
                                        CarroColors.textInputColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: Dimensions.dp_5,
                                        top: Dimensions.dp_3),
                                    child: Text(
                                      "RM ${addCarModel.carToAdd.price} /day",
                                      style: CarroTextStyles.normal_text,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                height: Dimensions.dp_60,
                                thickness: 0.5,
                                // indent: Dimensions.dp_20,
                                // endIndent: Dimensions.dp_20,
                                color: CarroColors.getColor(
                                    context, CarroColors.textInputColor),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                bottom: Dimensions.dp_20,
                                left: Dimensions.dp_36,
                                right: Dimensions.dp_36,
                              ),
                              child: Text(
                                'Exterior',
                                style: CarroTextStyles.small_label.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: CarroColors.getColor(
                                    context,
                                    CarroColors.textInputColor,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: Dimensions.dp_130,
                              child: ListView(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.dp_36),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  ClipRRect(
                                    borderRadius: CarroBorderRadius.circular_10,
                                    child: Image.file(
                                      File(addCarModel
                                              .carToAdd.carMainPic?.path ??
                                          ""),
                                      fit: BoxFit.fill,
                                      width: Dimensions.dp_200,
                                      height: Dimensions.dp_130,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: Dimensions.dp_20,
                                  ),
                                  ClipRRect(
                                    borderRadius: CarroBorderRadius.circular_10,
                                    child: Image.file(
                                      File(addCarModel
                                              .carToAdd.carImageOne?.path ??
                                          ""),
                                      fit: BoxFit.fill,
                                      width: Dimensions.dp_200,
                                      height: Dimensions.dp_130,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: Dimensions.dp_20,
                                  ),
                                  ClipRRect(
                                    borderRadius: CarroBorderRadius.circular_10,
                                    child: Image.file(
                                      File(addCarModel
                                              .carToAdd.carImageTwo?.path ??
                                          ""),
                                      fit: BoxFit.fill,
                                      width: Dimensions.dp_200,
                                      height: Dimensions.dp_130,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: Dimensions.dp_25),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                bottom: Dimensions.dp_20,
                                left: Dimensions.dp_36,
                                right: Dimensions.dp_36,
                              ),
                              child: Text(
                                'Interior',
                                style: CarroTextStyles.small_label.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: CarroColors.getColor(
                                    context,
                                    CarroColors.textInputColor,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: Dimensions.dp_130,
                              child: ListView(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.dp_36),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  ClipRRect(
                                    borderRadius: CarroBorderRadius.circular_10,
                                    child: Image.file(
                                      File(addCarModel
                                              .carToAdd.carImageThree?.path ??
                                          ""),
                                      fit: BoxFit.fill,
                                      width: Dimensions.dp_200,
                                      height: Dimensions.dp_130,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: Dimensions.dp_20,
                                  ),
                                  ClipRRect(
                                    borderRadius: CarroBorderRadius.circular_10,
                                    child: Image.file(
                                      File(addCarModel
                                              .carToAdd.carImageFour?.path ??
                                          ""),
                                      fit: BoxFit.fill,
                                      width: Dimensions.dp_200,
                                      height: Dimensions.dp_130,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: Dimensions.dp_20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: Dimensions.dp_10,
                            bottom: Dimensions.dp_10,
                            left: Dimensions.dp_36,
                            right: Dimensions.dp_36,
                          ),
                          child: Divider(
                            height: Dimensions.dp_60,
                            thickness: 0.5,
                            // indent: Dimensions.dp_20,
                            // endIndent: Dimensions.dp_20,
                            color: CarroColors.getColor(
                                context, CarroColors.textInputColor),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: Dimensions.dp_10,
                            bottom: Dimensions.dp_70,
                            left: Dimensions.dp_36,
                            right: Dimensions.dp_36,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Available From',
                                    style: CarroTextStyles.small_label.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: CarroColors.getColor(
                                        context,
                                        CarroColors.textInputColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: Dimensions.dp_5,
                                        top: Dimensions.dp_3),
                                    child: Text(
                                      addCarModel.carToAdd.availableFromDate !=
                                              null
                                          ? DateFormat('MM-dd-yyyy  hh:mm a')
                                              .format(addCarModel
                                                  .carToAdd.availableFromDate!)
                                              .toString()
                                          : "-",
                                      style: CarroTextStyles.small_label_bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: Dimensions.dp_25),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Until',
                                    style: CarroTextStyles.small_label.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: CarroColors.getColor(
                                        context,
                                        CarroColors.textInputColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: Dimensions.dp_5,
                                        top: Dimensions.dp_3),
                                    child: Text(
                                      addCarModel.carToAdd.availableFromDate !=
                                              null
                                          ? DateFormat('MM-dd-yyyy  hh:mm a')
                                              .format(addCarModel
                                                  .carToAdd.availableToDate!)
                                              .toString()
                                          : "-",
                                      style: CarroTextStyles.small_label_bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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

  nextButtonFunction(AddCarProvider addCarModel, BuildContext context) async {}
}
