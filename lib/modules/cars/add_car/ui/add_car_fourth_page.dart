import 'dart:io';

import 'package:carro_flutter_app/core/controller/image_controller.dart';
import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/core/widget/image_picker_square_widget.dart';
import 'package:carro_flutter_app/core/widget/rounded_button.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/widgets/register_top_bar_widget.dart';
import 'package:carro_flutter_app/modules/cars/add_car/view_model/add_car_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddCarFourthPage extends StatefulWidget {
  const AddCarFourthPage({super.key});

  @override
  State<AddCarFourthPage> createState() => _AddCarFourthPageState();
}

class _AddCarFourthPageState extends State<AddCarFourthPage> {
  XFile? selectedExterior1;
  XFile? selectedExterior2;
  XFile? selectedExterior3;
  XFile? selectedInterior1;
  XFile? selectedInterior2;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: Consumer<AddCarProvider>(
          builder: (context, registerModel, child) {
            return Container(
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
              SliverAppBar(
                pinned: true,
                scrolledUnderElevation: 0.0,
                leadingWidth: Dimensions.dp_290,
                leading: RegisterTopBarWidget(
                  titleAppBar: 'Upload photo',
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    locator<CarroRouter>().pop();
                  },
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
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
                        'Get the best shots of your car that will make heads turn.',
                        style: CarroTextStyles.large_item_text.copyWith(
                          color: CarroColors.getColor(
                            context,
                            CarroColors.textInputColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.dp_25),
                      const SizedBox(height: Dimensions.dp_10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Exterior',
                            style:
                                CarroTextStyles.large_normal_text_bold.copyWith(
                              color: CarroColors.getColor(
                                context,
                                CarroColors.registerHeadlineColor,
                              ),
                            ),
                          ),
                          Text(
                            'You need to upload 3 exterior photos',
                            style: CarroTextStyles.medium_item_text.copyWith(
                              color: CarroColors.getColor(
                                context,
                                CarroColors.textInputColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.dp_10),
                          Row(
                            children: [
                              ImagePickerSquareWidget(
                                onTap: () async {
                                  selectedExterior1 =
                                      await ImageController(context: context)
                                          .selectImageFromGallery();
                                  setState(() {});
                                },
                                onRemoveSelectedImage: () {
                                  selectedExterior1 = null;
                                  setState(() {});
                                },
                                imageFile: selectedExterior1,
                              ),
                              ImagePickerSquareWidget(
                                onTap: () async {
                                  selectedExterior2 =
                                      await ImageController(context: context)
                                          .selectImageFromGallery();
                                  setState(() {});
                                },
                                onRemoveSelectedImage: () {
                                  selectedExterior2 = null;
                                  setState(() {});
                                },
                                imageFile: selectedExterior2,
                              ),
                              ImagePickerSquareWidget(
                                onTap: () async {
                                  selectedExterior3 =
                                      await ImageController(context: context)
                                          .selectImageFromGallery();
                                  setState(() {});
                                },
                                onRemoveSelectedImage: () {
                                  selectedExterior3 = null;
                                  setState(() {});
                                },
                                imageFile: selectedExterior3,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        height: Dimensions.dp_100,
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
                            'Interior',
                            style:
                                CarroTextStyles.large_normal_text_bold.copyWith(
                              color: CarroColors.getColor(
                                context,
                                CarroColors.registerHeadlineColor,
                              ),
                            ),
                          ),
                          Text(
                            'You need to upload 2 interior photos',
                            style: CarroTextStyles.medium_item_text.copyWith(
                              color: CarroColors.getColor(
                                context,
                                CarroColors.textInputColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.dp_10),
                          Row(
                            children: [
                              ImagePickerSquareWidget(
                                onTap: () async {
                                  selectedInterior1 =
                                      await ImageController(context: context)
                                          .selectImageFromGallery();
                                  setState(() {});
                                },
                                onRemoveSelectedImage: () {
                                  selectedInterior1 = null;
                                  setState(() {});
                                },
                                imageFile: selectedInterior1,
                              ),
                              ImagePickerSquareWidget(
                                onTap: () async {
                                  selectedInterior2 =
                                      await ImageController(context: context)
                                          .selectImageFromGallery();
                                  setState(() {});
                                },
                                onRemoveSelectedImage: () {
                                  selectedInterior2 = null;
                                  setState(() {});
                                },
                                imageFile: selectedInterior2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  nextButtonFunction(AddCarProvider addCarModel, BuildContext context) async {
    if (selectedExterior1 == null ||
        selectedExterior2 == null ||
        selectedExterior3 == null ||
        selectedInterior1 == null ||
        selectedInterior2 == null) {
      EasyLoading.showError(
        "Please ensure all photos are uploaded.",
        duration: const Duration(
          seconds: 3,
        ),
      );
    } else {
      await addCarModel.addCarPage4Updater(
        imageMainExterior: selectedExterior1!,
        image1Exterior: selectedExterior2!,
        image2Exterior: selectedExterior3!,
        image3Interior: selectedInterior1!,
        image4Interior: selectedInterior2!,
      );
      //Go to next add car page
      locator<CarroRouter>().navigateTo(CarRoute.addCarConfirmationPage);
    }
  }
}
