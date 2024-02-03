import 'package:carro_flutter_app/core/controller/auth_controller.dart';
import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/core/utils/debouncer.dart';
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

class RegisterUsernameEmailPage extends StatefulWidget {
  const RegisterUsernameEmailPage({super.key});

  @override
  State<RegisterUsernameEmailPage> createState() =>
      _RegisterUsernameEmailPageState();
}

class _RegisterUsernameEmailPageState extends State<RegisterUsernameEmailPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? emailErrorMessage;
  String? usernameErrorMessage;
  bool showUsernameTakenMessage = false;
  bool showEmailTakenMessage = false;
  final _debouncer = Debouncer(milliseconds: 300);

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
                    nextButtonFunction(registerModel, context);
                    setState(() {});
                  }),
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
                      icon: Icons.close_rounded,
                      onTap: () {
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
                                        registerModel
                                            .registerProgressUpdater('clear');
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
                              'Enter your account details',
                              style: CarroTextStyles.medium_title_bold.copyWith(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.registerHeadlineColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.dp_5),
                            Text(
                              'The account details that your will use everytime you login.',
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
                                'Username',
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
                              controller: usernameController,
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
                              onChanged: (data) async {
                                if (usernameController.text.length >= 8) {
                                  showUsernameTakenMessage =
                                      await AuthController(context: context)
                                          .checkUsernameRegister(data);
                                }

                                if (usernameController.text.isNotEmpty) {
                                  if (FormChecker().usernameChecker(data) ==
                                      false) {
                                    usernameErrorMessage =
                                        "Username must 8 character or more with at least 1 capital letter, 1 special character and number";
                                  } else {
                                    usernameErrorMessage = null;
                                  }
                                } else {
                                  usernameErrorMessage = null;
                                }

                                setState(() {});
                              },
                            ),
                            showUsernameTakenMessage == false
                                ? const SizedBox.shrink()
                                : Container(
                                    padding: const EdgeInsets.only(
                                        left: Dimensions.dp_5,
                                        top: Dimensions.dp_5),
                                    child: Text(
                                      'Username has been taken.',
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
                              height: Dimensions.dp_3,
                            ),
                            usernameErrorMessage == null
                                ? const SizedBox.shrink()
                                : Container(
                                    padding: const EdgeInsets.only(
                                        left: Dimensions.dp_5,
                                        top: Dimensions.dp_5),
                                    child: Text(
                                      usernameErrorMessage ?? '',
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
                                'Email',
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
                              controller: emailController,
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
                              onChanged: (data) {
                                if (emailController.text.isNotEmpty) {
                                  if (FormChecker().emailChecker(data) ==
                                      false) {
                                    emailErrorMessage =
                                        "Email format is incorrect.";
                                  } else {
                                    emailErrorMessage = null;
                                  }
                                } else {
                                  emailErrorMessage = null;
                                }

                                setState(() {});
                              },
                            ),
                            emailErrorMessage == null
                                ? const SizedBox.shrink()
                                : Container(
                                    padding: const EdgeInsets.only(
                                        left: Dimensions.dp_5,
                                        top: Dimensions.dp_5),
                                    child: Text(
                                      emailErrorMessage ?? '',
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

  nextButtonFunction(
      RegisterProvider registerModel, BuildContext context) async {
    if (usernameController.text.isNotEmpty && emailController.text.isNotEmpty) {
      if (FormChecker().emailChecker(emailController.text.toString()) == true &&
          FormChecker().usernameChecker(usernameController.text.toString()) ==
              true) {
        emailErrorMessage = null;
        usernameErrorMessage = null;
        registerModel.setRegisterDataClass(
          data: RegisterData(
            username: usernameController.text.toString(),
            email: emailController.text.toString(),
          ),
          page: CommonRoute.registerUsernameEmailPage,
        );

        if (showUsernameTakenMessage == false) {
          bool checkEmailResult = await AuthController(context: context)
              .checkEmailRegister(emailController.text);
          if (checkEmailResult == false) {
            Future.delayed(const Duration(milliseconds: 150), () {
              //This is use to upgrade current page, so next page will show this page is being go through
              registerModel.registerProgressUpdater(
                  CommonRoute.registerUsernameEmailPage);
            });
            locator<CarroRouter>().navigateTo(CommonRoute.registerNamePage);
          }
        }
      } else {
        if (FormChecker().emailChecker(emailController.text.toString()) ==
            false) {
          emailErrorMessage = "Email format is incorrect.";
        }
        if (FormChecker().usernameChecker(usernameController.text.toString()) ==
            false) {
          usernameErrorMessage =
              "Username must 8 character or more with at least 1 capital letter, 1 special character and number";
        }
      }
    } else {
      if (usernameController.text.isEmpty) {
        usernameErrorMessage = "Please fill in your username";
      } else {
        if (FormChecker().usernameChecker(usernameController.text.toString()) ==
            false) {
          usernameErrorMessage =
              "Username must 8 character or more with at least 1 capital letter, 1 special character and number";
        } else {
          usernameErrorMessage = null;
        }
      }
      if (emailController.text.isEmpty) {
        emailErrorMessage = "Please fill in your email";
      } else {
        if (FormChecker().emailChecker(emailController.text.toString()) ==
            false) {
          emailErrorMessage =
              "Username must 8 character or more with at least 1 capital letter, 1 special character and number";
        } else {
          emailErrorMessage = null;
        }
      }
    }
  }
}
