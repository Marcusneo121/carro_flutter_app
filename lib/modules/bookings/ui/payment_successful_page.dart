import 'package:carro_flutter_app/core/provider/view_model/theme_provider.dart';
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
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class PaymentSuccesfulPageArgs {
  PaymentSuccesfulPageArgs({required this.transactionId});
  final String transactionId;
}

class PaymentSuccessfulPage extends StatefulWidget {
  final PaymentSuccesfulPageArgs args;

  const PaymentSuccessfulPage({super.key, required this.args});

  @override
  State<PaymentSuccessfulPage> createState() => _PaymentSuccessfulPageState();
}

class _PaymentSuccessfulPageState extends State<PaymentSuccessfulPage> {
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
                top: Dimensions.dp_10,
              ),
              child: RoundedButton(
                buttonText: 'Done',
                onTap: () {
                  FocusScope.of(context).unfocus();
                  locator<CarroRouter>()
                      .navigateToAndRemoveUntil(CommonRoute.homePage);
                  context.read<ThemeProvider>().setSelectedIndex(1);
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
                        'Booking payment successful',
                        style: CarroTextStyles.large_label,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.dp_20,
                          horizontal: Dimensions.dp_50,
                        ),
                        child: Text(
                          'We will let the host know. We hope you enjoy the ride!',
                          style: CarroTextStyles.normal_text.copyWith(
                            color: CarroColors.getColor(
                              context,
                              CarroColors.textInputColor,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: Dimensions.dp_40,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.dp_20,
                          horizontal: Dimensions.dp_50,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Transaction ID :  ',
                              style: CarroTextStyles.normal_text.copyWith(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.textInputColor,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: Dimensions.dp_5),
                            InkWell(
                              onLongPress: () {
                                Clipboard.setData(ClipboardData(
                                        text: widget.args.transactionId))
                                    .then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration:
                                          const Duration(milliseconds: 800),
                                      backgroundColor: CarroColors.getColor(
                                        context,
                                        CarroColors.primayColor,
                                      ),
                                      content: Row(
                                        children: [
                                          const Icon(
                                            Icons.check_circle_outline_rounded,
                                            color: Colors.green,
                                            size: Dimensions.dp_30,
                                          ),
                                          const SizedBox(
                                              width: Dimensions.dp_10),
                                          Text(
                                            'Transaction ID copied to clipboard.',
                                            style: CarroTextStyles
                                                .large_normal_text_bold
                                                .copyWith(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              },
                              child: Text(
                                widget.args.transactionId,
                                style:
                                    CarroTextStyles.large_normal_text.copyWith(
                                  color: CarroColors.getColor(
                                    context,
                                    CarroColors.primayColor,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
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
