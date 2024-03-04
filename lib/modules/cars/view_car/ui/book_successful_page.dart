import 'package:carro_flutter_app/core/provider/view_model/theme_provider.dart';
import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/core/widget/rounded_button.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/cars/add_car/view_model/add_car_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class BookSuccessfulPage extends StatefulWidget {
  const BookSuccessfulPage({super.key});

  @override
  State<BookSuccessfulPage> createState() => _BookSuccessfulPageState();
}

class _BookSuccessfulPageState extends State<BookSuccessfulPage> {
  DateTime selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: Consumer<AddCarProvider>(
          builder: (context, addCarModel, child) {
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
                        'Yay! You had booked the car',
                        style: CarroTextStyles.large_label,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.dp_20,
                          horizontal: Dimensions.dp_50,
                        ),
                        child: Text(
                          'We will let the host know, and update you asap!',
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
