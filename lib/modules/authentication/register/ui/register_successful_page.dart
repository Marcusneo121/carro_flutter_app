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
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class RegisterSuccessfulPage extends StatefulWidget {
  const RegisterSuccessfulPage({super.key});

  @override
  State<RegisterSuccessfulPage> createState() => _RegisterSuccessfulPageState();
}

class _RegisterSuccessfulPageState extends State<RegisterSuccessfulPage> {
  DateTime selectedDateTime = DateTime.now();

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
                buttonText: 'Done',
                onTap: () {
                  FocusScope.of(context).unfocus();
                  registerModel.resetToPageProgressUpdater(
                      CommonRoute.registerUsernameEmailPage);
                  locator<CarroRouter>()
                      .navigateToAndRemoveUntil(CommonRoute.loginPage);
                },
              ),
            );
          },
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'images/success_ani.json',
                        width: Dimensions.dp_200,
                        height: Dimensions.dp_200,
                        fit: BoxFit.fill,
                        repeat: false,
                      ),
                      const Text(
                        'Thanks for signing up.',
                        style: CarroTextStyles.large_label,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.dp_20,
                          horizontal: Dimensions.dp_50,
                        ),
                        child: Text(
                          'Account verification had sent to your email. Please verify your account, before login to your account',
                          style: CarroTextStyles.normal_text.copyWith(
                            color: CarroColors.getColor(
                              context,
                              CarroColors.textInputColor,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
