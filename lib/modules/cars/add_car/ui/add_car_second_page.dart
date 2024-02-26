import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/core/widget/carro_text_form_field.dart';
import 'package:carro_flutter_app/core/widget/rounded_button.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/widgets/register_top_bar_widget.dart';
import 'package:carro_flutter_app/modules/cars/add_car/view_model/add_car_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class AddCarSecondPage extends StatefulWidget {
  const AddCarSecondPage({super.key});

  @override
  State<AddCarSecondPage> createState() => _AddCarSecondPageState();
}

class _AddCarSecondPageState extends State<AddCarSecondPage> {
  TextEditingController priceController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: Consumer<AddCarProvider>(
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
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    await nextButtonFunction(registerModel, context);
                    setState(() {});
                  }),
            );
          },
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                scrolledUnderElevation: 0.0,
                leadingWidth: Dimensions.dp_290,
                leading: RegisterTopBarWidget(
                  titleAppBar: 'Price & Location',
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    locator<CarroRouter>().pop();
                  },
                ),
              ),
              SliverFillRemaining(
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
                        'Price (per day)',
                        style: CarroTextStyles.large_normal_text_bold.copyWith(
                          color: CarroColors.getColor(
                            context,
                            CarroColors.registerHeadlineColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.dp_5),
                      Text(
                        '* Price should include tax. Tax will be deduct from the total amount.',
                        style: CarroTextStyles.small_item_text_bold.copyWith(
                          fontSize: Dimensions.dp_11,
                          fontStyle: FontStyle.italic,
                          color: CarroColors.getColor(
                            context,
                            CarroColors.textInputColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.dp_5),
                      Row(
                        children: [
                          const SizedBox(width: Dimensions.dp_5),
                          Text(
                            'RM',
                            style: CarroTextStyles.small_label_bold.copyWith(
                              color: CarroColors.getColor(
                                context,
                                CarroColors.iconColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: Dimensions.dp_10),
                          Flexible(
                            child: CarroTextFormField(
                              textInputType:
                                  const TextInputType.numberWithOptions(
                                      signed: true),
                              textInputFormatter: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              topGapHeight: Dimensions.dp_10,
                              bottomGapHeight: Dimensions.dp_10,
                              controller: priceController,
                              hintText: 'e.g. 128',
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimensions.dp_25),
                      Text(
                        'Location',
                        style: CarroTextStyles.large_normal_text_bold.copyWith(
                          color: CarroColors.getColor(
                            context,
                            CarroColors.registerHeadlineColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.dp_5),
                      Text(
                        '* Suggest locations are popular places like mall or building',
                        style: CarroTextStyles.small_item_text_bold.copyWith(
                          fontSize: Dimensions.dp_11,
                          fontStyle: FontStyle.italic,
                          color: CarroColors.getColor(
                            context,
                            CarroColors.textInputColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.dp_5),
                      Text(
                        "* Don't worry, you can decide pick up location with guest later.",
                        style: CarroTextStyles.small_item_text_bold.copyWith(
                          fontSize: Dimensions.dp_11,
                          fontStyle: FontStyle.italic,
                          color: CarroColors.getColor(
                            context,
                            CarroColors.textInputColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.dp_5),
                      CarroTextFormField(
                        textInputType: TextInputType.text,
                        topGapHeight: Dimensions.dp_10,
                        bottomGapHeight: Dimensions.dp_10,
                        controller: locationController,
                        hintText: 'e.g. Pavilion Bukit Bintang',
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  nextButtonFunction(AddCarProvider addCarModel, BuildContext context) async {
    if (priceController.text.isEmpty || locationController.text.isEmpty) {
      EasyLoading.showError(
          "Please ensure all information about your car is fill.");
    } else {
      await addCarModel.addCarPage2Updater(
        price: priceController.text.toString(),
        location: locationController.text.toString(),
      );
      //Go to next add car page
      locator<CarroRouter>().navigateTo(CarRoute.addCar3);
    }
  }
}
