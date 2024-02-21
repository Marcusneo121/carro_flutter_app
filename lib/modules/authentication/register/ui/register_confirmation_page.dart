import 'package:carro_flutter_app/core/controller/auth_controller.dart';
import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/core/widget/rounded_button.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/widgets/register_progress_bar_widget.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/widgets/register_top_bar_widget.dart';
import 'package:carro_flutter_app/modules/authentication/register/view_model/register_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RegisterConfirmationPage extends StatefulWidget {
  const RegisterConfirmationPage({super.key});

  @override
  State<RegisterConfirmationPage> createState() =>
      _RegisterConfirmationPageState();
}

class _RegisterConfirmationPageState extends State<RegisterConfirmationPage> {
  TextEditingController phoneNumberController = TextEditingController();

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
                buttonText: 'Create Account',
                onTap: () {
                  FocusScope.of(context).unfocus();
                  AuthController(context: context)
                      .register(data: registerModel.registrationData);
                  // registerModel.displayRegisterData();
                  // locator<CarroRouter>()
                  //     .navigateTo(CommonRoute.registerAddressPage);
                },
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
                        FocusScope.of(context).unfocus();
                        registerModel.resetToPageProgressUpdater(
                            CommonRoute.registerAddressPage);
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RegisterProgressBarWidget(
                                  homeModel: registerModel,
                                ),
                                const SizedBox(height: Dimensions.dp_10),
                                Text(
                                  'Details Confirmation',
                                  style: CarroTextStyles.medium_title_bold
                                      .copyWith(
                                    color: CarroColors.getColor(
                                      context,
                                      CarroColors.registerHeadlineColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: Dimensions.dp_5),
                                Text(
                                  'Ensure that all details are correct before create account.',
                                  style:
                                      CarroTextStyles.large_item_text.copyWith(
                                    color: CarroColors.getColor(
                                      context,
                                      CarroColors.textInputColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: Dimensions.dp_30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name',
                                  style:
                                      CarroTextStyles.large_label_bold.copyWith(
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
                                    "${registerModel.registrationData.firstName} ${registerModel.registrationData.lastName}",
                                    style: CarroTextStyles.normal_text,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: Dimensions.dp_20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  style:
                                      CarroTextStyles.large_label_bold.copyWith(
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
                                    registerModel.registrationData.email ?? "",
                                    style: CarroTextStyles.normal_text,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: Dimensions.dp_20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date of Birth',
                                  style:
                                      CarroTextStyles.large_label_bold.copyWith(
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
                                    DateFormat('MM/dd/yyyy')
                                        .format(registerModel
                                                .registrationData.dateOfBirth ??
                                            DateTime.now())
                                        .toString(),
                                    style: CarroTextStyles.normal_text,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: Dimensions.dp_20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Phone Number',
                                  style:
                                      CarroTextStyles.large_label_bold.copyWith(
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
                                    "+06${registerModel.registrationData.phoneNumber ?? "-"}",
                                    style: CarroTextStyles.normal_text,
                                  ),
                                ),
                              ],
                            ),
                            // const SizedBox(height: Dimensions.dp_20),
                            Divider(
                              height: Dimensions.dp_70,
                              thickness: 1,
                              indent: Dimensions.dp_50,
                              endIndent: Dimensions.dp_50,
                              color: CarroColors.getColor(
                                  context, CarroColors.textInputColor),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Address',
                                  style:
                                      CarroTextStyles.large_label_bold.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: CarroColors.getColor(
                                      context,
                                      CarroColors.textInputColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: Dimensions.dp_10,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: Dimensions.dp_5,
                                      top: Dimensions.dp_3),
                                  child: Text(
                                    registerModel.registrationData.address1 ??
                                        "",
                                    style: CarroTextStyles.normal_text,
                                  ),
                                ),
                                registerModel.registrationData.address2 ==
                                            null ||
                                        registerModel
                                                .registrationData.address2 ==
                                            ""
                                    ? const SizedBox.shrink()
                                    : Container(
                                        padding: const EdgeInsets.only(
                                            left: Dimensions.dp_5,
                                            top: Dimensions.dp_3),
                                        child: Text(
                                          registerModel
                                                  .registrationData.address2 ??
                                              "",
                                          style: CarroTextStyles.normal_text,
                                        ),
                                      ),
                                registerModel.registrationData.address3 ==
                                            null ||
                                        registerModel
                                                .registrationData.address3 ==
                                            ""
                                    ? const SizedBox.shrink()
                                    : Container(
                                        padding: const EdgeInsets.only(
                                            left: Dimensions.dp_5,
                                            top: Dimensions.dp_3),
                                        child: Text(
                                          registerModel
                                                  .registrationData.address3 ??
                                              "",
                                          style: CarroTextStyles.normal_text,
                                        ),
                                      ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: Dimensions.dp_5,
                                      top: Dimensions.dp_3),
                                  child: Text(
                                    registerModel.registrationData.poscode ??
                                        "",
                                    style: CarroTextStyles.normal_text,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: Dimensions.dp_5,
                                      top: Dimensions.dp_3),
                                  child: Text(
                                    registerModel.registrationData.city ?? "",
                                    style: CarroTextStyles.normal_text,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: Dimensions.dp_5,
                                      top: Dimensions.dp_3),
                                  child: Text(
                                    registerModel.registrationData.state ?? "",
                                    style: CarroTextStyles.normal_text,
                                  ),
                                ),
                              ],
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
}
