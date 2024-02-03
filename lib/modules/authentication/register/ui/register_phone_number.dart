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

class RegisterPhoneNumberPage extends StatefulWidget {
  const RegisterPhoneNumberPage({super.key});

  @override
  State<RegisterPhoneNumberPage> createState() =>
      _RegisterPhoneNumberPageState();
}

class _RegisterPhoneNumberPageState extends State<RegisterPhoneNumberPage> {
  TextEditingController phoneNumberController = TextEditingController();

  String? phoneNumberErrorMessage;

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
                  if (phoneNumberController.text.isEmpty) {
                    phoneNumberErrorMessage = 'Phone number cannot be empty';
                    setState(() {});
                  } else {
                    phoneNumberErrorMessage = null;
                    registerModel.setRegisterDataClass(
                      data: RegisterData(
                        phoneNumber: phoneNumberController.text.toString(),
                      ),
                      page: CommonRoute.registerPhoneNumberPage,
                    );
                    Future.delayed(const Duration(milliseconds: 150), () {
                      //This is use to upgrade current page, so next page will show this page is being go through
                      registerModel.registerProgressUpdater(
                          CommonRoute.registerPhoneNumberPage);
                    });
                    locator<CarroRouter>()
                        .navigateTo(CommonRoute.registerDateOfBirthPage);
                  }
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
                        registerModel.resetToPageProgressUpdater(
                            CommonRoute.registerPasswordPage);
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
                              'Enter your phone number',
                              style: CarroTextStyles.medium_title_bold.copyWith(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.registerHeadlineColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.dp_5),
                            Text(
                              'Phone number that people can reach you out.',
                              style: CarroTextStyles.large_item_text.copyWith(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.textInputColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.dp_25),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: Dimensions.dp_5),
                              child: Text(
                                'Phone No.',
                                style:
                                    CarroTextStyles.normal_text_bold.copyWith(
                                  color: CarroColors.getColor(
                                    context,
                                    CarroColors.textInputColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.dp_5),
                            Row(
                              children: [
                                const SizedBox(width: Dimensions.dp_5),
                                Text(
                                  '+60',
                                  style:
                                      CarroTextStyles.normal_text_bold.copyWith(
                                    color: CarroColors.getColor(
                                      context,
                                      CarroColors.iconColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: Dimensions.dp_5),
                                Flexible(
                                  child: TextFormField(
                                    style: CarroTextStyles.normal_text_bold,
                                    controller: phoneNumberController,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.left,
                                    decoration: InputDecoration(
                                        // hintText: 'Username',
                                        hintStyle: CarroTextStyles
                                            .normal_text_bold
                                            .copyWith(
                                          color: CarroColors.getColor(context,
                                              CarroColors.textInputColor),
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                            left: Dimensions.dp_10)),
                                    onChanged: (value) {
                                      if (phoneNumberController.text.isEmpty) {
                                        phoneNumberErrorMessage =
                                            "Phone number cannot be empty";
                                      } else {
                                        phoneNumberErrorMessage = null;
                                      }

                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                            phoneNumberErrorMessage == null
                                ? const SizedBox.shrink()
                                : Container(
                                    padding: const EdgeInsets.only(
                                        left: Dimensions.dp_5,
                                        top: Dimensions.dp_5),
                                    child: Text(
                                      phoneNumberErrorMessage ?? '',
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
                              height: Dimensions.dp_10,
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
