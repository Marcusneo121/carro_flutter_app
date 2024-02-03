import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/core/utils/form_checker.dart';
import 'package:carro_flutter_app/core/widget/rounded_button.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/authentication/register/entity/register.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/widgets/register_progress_bar_widget.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/widgets/register_top_bar_widget.dart';
import 'package:carro_flutter_app/modules/authentication/register/view_model/register_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPasswordPage extends StatefulWidget {
  const RegisterPasswordPage({super.key});

  @override
  State<RegisterPasswordPage> createState() => _RegisterPasswordPageState();
}

class _RegisterPasswordPageState extends State<RegisterPasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmationPasswordController =
      TextEditingController();
  bool _hidePassword1 = true;
  String? passwordErrorMessage;
  String? confirmPasswordErrorMessage;

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
                  //         CommonRoute.registerPasswordPage);
                  //   });
                  //   locator<CarroRouter>()
                  //       .navigateTo(CommonRoute.registerPhoneNumberPage);
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
                      // icon: Icons.close_rounded,
                      onTap: () {
                        registerModel.resetToPageProgressUpdater(
                            CommonRoute.registerNamePage);
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
                              'Enter your password',
                              style: CarroTextStyles.medium_title_bold.copyWith(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.registerHeadlineColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.dp_5),
                            Text(
                              'So we can help you secure your account.',
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
                                'Password',
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
                              obscureText: _hidePassword1,
                              style: CarroTextStyles.normal_text_bold,
                              controller: passwordController,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                // hintText: 'Username',
                                hintStyle:
                                    CarroTextStyles.normal_text_bold.copyWith(
                                  color: CarroColors.getColor(
                                      context, CarroColors.textInputColor),
                                ),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _hidePassword1 = !_hidePassword1;
                                    });
                                  },
                                  child: _hidePassword1 == true
                                      ? Icon(
                                          Icons.visibility_off_rounded,
                                          color: CarroColors.getColor(
                                            context,
                                            CarroColors.iconColor,
                                          ),
                                        )
                                      : Icon(
                                          Icons.visibility_rounded,
                                          color: CarroColors.getColor(
                                            context,
                                            CarroColors.iconColor,
                                          ),
                                        ),
                                ),
                              ),
                              onChanged: (value) {
                                if (passwordController.text.isNotEmpty) {
                                  if (FormChecker().passwordChecker(value) ==
                                      false) {
                                    passwordErrorMessage =
                                        "Password must 8 character or more with at least 1 capital letter, 1 special character and number";
                                  } else {
                                    passwordErrorMessage = null;
                                  }
                                } else {
                                  passwordErrorMessage = null;
                                }

                                setState(() {});
                              },
                            ),
                            passwordErrorMessage == null
                                ? const SizedBox.shrink()
                                : Container(
                                    padding: const EdgeInsets.only(
                                        left: Dimensions.dp_5,
                                        top: Dimensions.dp_5),
                                    child: Text(
                                      passwordErrorMessage ?? '',
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
                                'Confirm Password',
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
                              obscureText: _hidePassword1,
                              style: CarroTextStyles.normal_text_bold,
                              controller: confirmationPasswordController,
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
                                if (confirmationPasswordController
                                    .text.isNotEmpty) {
                                  if (confirmationPasswordController.text !=
                                      passwordController.text) {
                                    confirmPasswordErrorMessage =
                                        'Confirm password must be same as Password';
                                  } else {
                                    confirmPasswordErrorMessage = null;
                                  }
                                } else {
                                  confirmPasswordErrorMessage = null;
                                }

                                setState(() {});
                              },
                            ),
                            confirmPasswordErrorMessage == null
                                ? const SizedBox.shrink()
                                : Container(
                                    padding: const EdgeInsets.only(
                                        left: Dimensions.dp_5,
                                        top: Dimensions.dp_5),
                                    child: Text(
                                      confirmPasswordErrorMessage ?? '',
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
    if (passwordController.text.isNotEmpty &&
        confirmationPasswordController.text.isNotEmpty) {
      if (FormChecker().passwordChecker(passwordController.text.toString()) ==
          false) {
        passwordErrorMessage =
            "Password must 8 character or more with at least 1 capital letter, 1 special character and number";
      } else {
        if (confirmationPasswordController.text.toString() ==
            passwordController.text.toString()) {
          passwordErrorMessage = null;
          registerModel.setRegisterDataClass(
            data: RegisterData(
              password: passwordController.text.toString(),
            ),
            page: CommonRoute.registerPasswordPage,
          );
          Future.delayed(const Duration(milliseconds: 150), () {
            //This is use to upgrade current page, so next page will show this page is being go through
            registerModel
                .registerProgressUpdater(CommonRoute.registerPasswordPage);
          });
          locator<CarroRouter>()
              .navigateTo(CommonRoute.registerPhoneNumberPage);
        } else {
          confirmPasswordErrorMessage =
              "Confirm password is not similar to Password";
        }
      }
    } else {
      if (passwordController.text.isEmpty) {
        passwordErrorMessage = 'Password cannot be empty';
      } else {
        passwordErrorMessage = null;
      }
      if (confirmationPasswordController.text.isEmpty) {
        confirmPasswordErrorMessage = 'Confirm password cannot be empty';
      } else {
        confirmPasswordErrorMessage = null;
      }
    }
  }
}
