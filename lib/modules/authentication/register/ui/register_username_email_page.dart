import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/core/widget/rounded_button.dart';
import 'package:carro_flutter_app/main.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.dp_36, horizontal: Dimensions.dp_30),
        child: RoundedButton(
          buttonText: 'Next',
          onTap: () {
            // AuthController(context: context).login(
            //     usernameController.text,
            //     passwordController.text);
            locator<CarroRouter>().navigateTo(CommonRoute.registerAddressPage);
          },
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            Consumer(
              builder: (context, homeModel, child) {
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
                                      top: Dimensions.dp_20),
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
              builder: (context, homeModel, child) {
                if (homeModel.isBusy) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (homeModel.isError) {
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
    );
  }
}
