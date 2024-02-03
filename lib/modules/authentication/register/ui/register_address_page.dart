import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/core/widget/rounded_button.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/authentication/register/entity/register.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/widgets/register_progress_bar_widget.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/widgets/register_top_bar_widget.dart';
import 'package:carro_flutter_app/modules/authentication/register/view_model/register_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterAddressPage extends StatefulWidget {
  const RegisterAddressPage({super.key});

  @override
  State<RegisterAddressPage> createState() => _RegisterAddressPageState();
}

class _RegisterAddressPageState extends State<RegisterAddressPage> {
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController address3Controller = TextEditingController();
  TextEditingController poscodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  String? address1ErrorMessage;
  String? poscodeErrorMessage;
  String? cityErrorMessage;
  String? stateErrorMessage;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: Consumer<RegisterProvider>(
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
                  onTap: () {
                    nextButtonFunction(registerModel);
                    setState(() {});
                  }
                  // onTap: () {
                  //   Future.delayed(const Duration(milliseconds: 150), () {
                  //     //This is use to upgrade current page, so next page will show this page is being go through
                  //     registerModel.registerProgressUpdater(
                  //         CommonRoute.registerAddressPage);
                  //   });
                  //   locator<CarroRouter>()
                  //       .navigateTo(CommonRoute.registerConfirmationPage);
                  // },
                  ),
            );
          },
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              Consumer<RegisterProvider>(
                builder: (context, registerModel, child) {
                  return SliverAppBar(
                    pinned: true,
                    scrolledUnderElevation: 0.0,
                    leadingWidth: Dimensions.dp_290,
                    leading: RegisterTopBarWidget(
                      titleAppBar: '',
                      onTap: () {
                        registerModel.resetToPageProgressUpdater(
                            CommonRoute.registerDateOfBirthPage);
                        locator<CarroRouter>().pop();
                      },
                    ),
                  );
                },
              ),
              Consumer<RegisterProvider>(
                builder: (context, registerModel, child) {
                  if (registerModel.isBusy) {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (registerModel.isError) {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text("Something went wrong"),
                      ),
                    );
                  } else {
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
                            RegisterProgressBarWidget(
                              homeModel: registerModel,
                            ),
                            const SizedBox(height: Dimensions.dp_10),
                            Text(
                              'Enter your address',
                              style: CarroTextStyles.medium_title_bold.copyWith(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.registerHeadlineColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.dp_5),
                            Text(
                              'The address that we can send you important information.',
                              style: CarroTextStyles.large_item_text.copyWith(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.textInputColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.dp_18),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: Dimensions.dp_5),
                              child: Text(
                                'Address 1',
                                style: CarroTextStyles.large_normal_text_bold
                                    .copyWith(
                                  color: CarroColors.getColor(
                                    context,
                                    CarroColors.textInputColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.dp_5),
                            TextFormField(
                              style: CarroTextStyles.normal_text_bold,
                              controller: address1Controller,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                // hintText: 'Username',
                                hintStyle:
                                    CarroTextStyles.normal_text_bold.copyWith(
                                  color: CarroColors.getColor(
                                      context, CarroColors.textInputColor),
                                ),
                              ),
                              onChanged: (value) {
                                if (address1Controller.text.isNotEmpty) {
                                  address1ErrorMessage = null;
                                  setState(() {});
                                }
                              },
                            ),
                            address1ErrorMessage == null
                                ? const SizedBox.shrink()
                                : Container(
                                    padding: const EdgeInsets.only(
                                        left: Dimensions.dp_5,
                                        top: Dimensions.dp_5),
                                    child: Text(
                                      address1ErrorMessage ?? '',
                                      style: CarroTextStyles.medium_item_text
                                          .copyWith(
                                        color: CarroColors.getColor(
                                          context,
                                          CarroColors.fail,
                                        ),
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: Dimensions.dp_15,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: Dimensions.dp_5),
                              child: Text(
                                'Address 2',
                                style: CarroTextStyles.large_normal_text_bold
                                    .copyWith(
                                  color: CarroColors.getColor(
                                    context,
                                    CarroColors.textInputColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.dp_5),
                            TextFormField(
                              style: CarroTextStyles.normal_text_bold,
                              controller: address2Controller,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                // hintText: 'Username',
                                hintStyle:
                                    CarroTextStyles.normal_text_bold.copyWith(
                                  color: CarroColors.getColor(
                                      context, CarroColors.textInputColor),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: Dimensions.dp_15,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: Dimensions.dp_5),
                              child: Text(
                                'Address 3',
                                style: CarroTextStyles.large_normal_text_bold
                                    .copyWith(
                                  color: CarroColors.getColor(
                                    context,
                                    CarroColors.textInputColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.dp_5),
                            TextFormField(
                              style: CarroTextStyles.normal_text_bold,
                              controller: address3Controller,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                // hintText: 'Username',
                                hintStyle:
                                    CarroTextStyles.normal_text_bold.copyWith(
                                  color: CarroColors.getColor(
                                      context, CarroColors.textInputColor),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: Dimensions.dp_15,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: Dimensions.dp_5),
                              child: Text(
                                'Poscode',
                                style: CarroTextStyles.large_normal_text_bold
                                    .copyWith(
                                  color: CarroColors.getColor(
                                    context,
                                    CarroColors.textInputColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.dp_5),
                            TextFormField(
                              style: CarroTextStyles.normal_text_bold,
                              controller: poscodeController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                // hintText: 'Username',
                                hintStyle:
                                    CarroTextStyles.normal_text_bold.copyWith(
                                  color: CarroColors.getColor(
                                      context, CarroColors.textInputColor),
                                ),
                              ),
                              onChanged: (value) {
                                if (poscodeController.text.isNotEmpty) {
                                  poscodeErrorMessage = null;
                                  setState(() {});
                                }
                              },
                            ),
                            poscodeErrorMessage == null
                                ? const SizedBox.shrink()
                                : Container(
                                    padding: const EdgeInsets.only(
                                        left: Dimensions.dp_5,
                                        top: Dimensions.dp_5),
                                    child: Text(
                                      poscodeErrorMessage ?? '',
                                      style: CarroTextStyles.medium_item_text
                                          .copyWith(
                                        color: CarroColors.getColor(
                                          context,
                                          CarroColors.fail,
                                        ),
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: Dimensions.dp_15,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: Dimensions.dp_5),
                              child: Text(
                                'City',
                                style: CarroTextStyles.large_normal_text_bold
                                    .copyWith(
                                  color: CarroColors.getColor(
                                    context,
                                    CarroColors.textInputColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.dp_5),
                            TextFormField(
                              style: CarroTextStyles.normal_text_bold,
                              controller: cityController,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                // hintText: 'Username',
                                hintStyle:
                                    CarroTextStyles.normal_text_bold.copyWith(
                                  color: CarroColors.getColor(
                                      context, CarroColors.textInputColor),
                                ),
                              ),
                              onChanged: (value) {
                                if (cityController.text.isNotEmpty) {
                                  cityErrorMessage = null;
                                  setState(() {});
                                }
                              },
                            ),
                            cityErrorMessage == null
                                ? const SizedBox.shrink()
                                : Container(
                                    padding: const EdgeInsets.only(
                                        left: Dimensions.dp_5,
                                        top: Dimensions.dp_5),
                                    child: Text(
                                      cityErrorMessage ?? '',
                                      style: CarroTextStyles.medium_item_text
                                          .copyWith(
                                        color: CarroColors.getColor(
                                          context,
                                          CarroColors.fail,
                                        ),
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: Dimensions.dp_15,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: Dimensions.dp_5),
                              child: Text(
                                'State',
                                style: CarroTextStyles.large_normal_text_bold
                                    .copyWith(
                                  color: CarroColors.getColor(
                                    context,
                                    CarroColors.textInputColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.dp_5),
                            TextFormField(
                              style: CarroTextStyles.normal_text_bold,
                              controller: stateController,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                // hintText: 'Username',
                                hintStyle:
                                    CarroTextStyles.normal_text_bold.copyWith(
                                  color: CarroColors.getColor(
                                      context, CarroColors.textInputColor),
                                ),
                              ),
                              onChanged: (value) {
                                if (stateController.text.isNotEmpty) {
                                  stateErrorMessage = null;
                                  setState(() {});
                                }
                              },
                            ),
                            stateErrorMessage == null
                                ? const SizedBox.shrink()
                                : Container(
                                    padding: const EdgeInsets.only(
                                        left: Dimensions.dp_5,
                                        top: Dimensions.dp_5),
                                    child: Text(
                                      stateErrorMessage ?? '',
                                      style: CarroTextStyles.medium_item_text
                                          .copyWith(
                                        color: CarroColors.getColor(
                                          context,
                                          CarroColors.fail,
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  nextButtonFunction(RegisterProvider registerModel) {
    if (address1Controller.text.isNotEmpty &&
        poscodeController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        stateController.text.isNotEmpty) {
      registerModel.setRegisterDataClass(
        data: RegisterData(
          address1: address1Controller.text.toString(),
          address2: address2Controller.text.toString(),
          address3: address3Controller.text.toString(),
          poscode: poscodeController.text.toString(),
          city: cityController.text.toString(),
          state: stateController.text.toString(),
        ),
        page: CommonRoute.registerAddressPage,
      );
      Future.delayed(const Duration(milliseconds: 150), () {
        //This is use to upgrade current page, so next page will show this page is being go through
        registerModel.registerProgressUpdater(CommonRoute.registerAddressPage);
      });
      locator<CarroRouter>().navigateTo(CommonRoute.registerConfirmationPage);
    } else {
      if (address1Controller.text.isEmpty) {
        address1ErrorMessage = 'Address 1 cannot be empty';
      } else {
        address1ErrorMessage = null;
      }
      if (poscodeController.text.isEmpty) {
        poscodeErrorMessage = 'Poscode cannot be empty';
      } else {
        poscodeErrorMessage = null;
      }
      if (cityController.text.isEmpty) {
        cityErrorMessage = 'City cannot be empty';
      } else {
        cityErrorMessage = null;
      }
      if (stateController.text.isEmpty) {
        stateErrorMessage = 'State cannot be empty';
      } else {
        stateErrorMessage = null;
      }
    }
  }
}
