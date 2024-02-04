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

class RegisterNamePage extends StatefulWidget {
  const RegisterNamePage({super.key});

  @override
  State<RegisterNamePage> createState() => _RegisterNamePageState();
}

class _RegisterNamePageState extends State<RegisterNamePage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  String? firstNameErrorMessage;
  String? lastNameErrorMessage;

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
                    FocusScope.of(context).unfocus();
                    nextButtonFunction(registerModel);
                    setState(() {});
                  }
                  // onTap: () {
                  //   // AuthController(context: context).login(
                  //   //     usernameController.text,
                  //   //     passwordController.text);
                  //   Future.delayed(const Duration(milliseconds: 150), () {
                  //     //This is use to upgrade current page, so next page will show this page is being go through
                  //     registerModel
                  //         .registerProgressUpdater(CommonRoute.registerNamePage);
                  //   });
                  //   locator<CarroRouter>()
                  //       .navigateTo(CommonRoute.registerPasswordPage);
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
                        FocusScope.of(context).unfocus();
                        registerModel.resetToPageProgressUpdater(
                            CommonRoute.registerUsernameEmailPage);
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
                              'Enter your name',
                              style: CarroTextStyles.medium_title_bold.copyWith(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.registerHeadlineColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.dp_5),
                            Text(
                              'Let us know how should we address you.',
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
                                'First name',
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
                              controller: firstNameController,
                              keyboardType: TextInputType.name,
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
                                if (firstNameController.text.isNotEmpty) {
                                  firstNameErrorMessage = null;
                                  setState(() {});
                                }
                              },
                            ),
                            firstNameErrorMessage == null
                                ? const SizedBox.shrink()
                                : Container(
                                    padding: const EdgeInsets.only(
                                        left: Dimensions.dp_5,
                                        top: Dimensions.dp_5),
                                    child: Text(
                                      firstNameErrorMessage ?? '',
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
                                'Last Name',
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
                              controller: lastNameController,
                              keyboardType: TextInputType.name,
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
                                if (lastNameController.text.isNotEmpty) {
                                  lastNameErrorMessage = null;
                                  setState(() {});
                                }
                              },
                            ),
                            lastNameErrorMessage == null
                                ? const SizedBox.shrink()
                                : Container(
                                    padding: const EdgeInsets.only(
                                        left: Dimensions.dp_5,
                                        top: Dimensions.dp_5),
                                    child: Text(
                                      lastNameErrorMessage ?? '',
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
    if (firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty) {
      registerModel.setRegisterDataClass(
        data: RegisterData(
          firstName: firstNameController.text.toString(),
          lastName: lastNameController.text.toString(),
        ),
        page: CommonRoute.registerNamePage,
      );
      Future.delayed(const Duration(milliseconds: 150), () {
        //This is use to upgrade current page, so next page will show this page is being go through
        registerModel.registerProgressUpdater(CommonRoute.registerNamePage);
      });
      locator<CarroRouter>().navigateTo(CommonRoute.registerPasswordPage);
    } else {
      if (firstNameController.text.isEmpty) {
        firstNameErrorMessage = 'First name cannot be empty';
      } else {
        firstNameErrorMessage = null;
      }
      if (lastNameController.text.isEmpty) {
        lastNameErrorMessage = 'Last name cannot be empty';
      } else {
        lastNameErrorMessage = null;
      }
    }
  }
}
