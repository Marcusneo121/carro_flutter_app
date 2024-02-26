import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/core/widget/rounded_button.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/widgets/register_top_bar_widget.dart';
import 'package:carro_flutter_app/modules/cars/add_car/view_model/add_car_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddCarThirdPage extends StatefulWidget {
  const AddCarThirdPage({super.key});

  @override
  State<AddCarThirdPage> createState() => _AddCarThirdPageState();
}

class _AddCarThirdPageState extends State<AddCarThirdPage> {
  DateTime selectedAvailableFromDateTime = DateTime.now();
  DateTime selectedAvailableToDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: Consumer<AddCarProvider>(
          builder: (context, registerModel, child) {
            return Container(
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
                  titleAppBar: 'Available Date',
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: Dimensions.dp_10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Available From',
                              style: CarroTextStyles.medium_label_bold.copyWith(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.registerHeadlineColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.dp_10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  showCupertinoModalPopup(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => CupertinoActionSheet(
                                      actions: [
                                        buildDatePickerFrom(),
                                      ],
                                      cancelButton: CupertinoActionSheetAction(
                                        onPressed: () {
                                          setState(() {});
                                          locator<CarroRouter>().pop();
                                        },
                                        child: const Text('Done'),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.dp_20,
                                    horizontal: Dimensions.dp_20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: CarroColors.getColor(
                                        context, CarroColors.list_item_color),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12.0)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      DateFormat.MMM()
                                          .format(selectedAvailableFromDateTime)
                                          .toString(),
                                      style: CarroTextStyles.large_title_bold,
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                '/',
                                style: CarroTextStyles.large_label,
                              ),
                              InkWell(
                                onTap: () {
                                  showCupertinoModalPopup(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => CupertinoActionSheet(
                                      actions: [
                                        buildDatePickerFrom(),
                                      ],
                                      cancelButton: CupertinoActionSheetAction(
                                        onPressed: () {
                                          setState(() {});
                                          locator<CarroRouter>().pop();
                                        },
                                        child: const Text('Done'),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.dp_20,
                                    horizontal: Dimensions.dp_20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: CarroColors.getColor(
                                        context, CarroColors.list_item_color),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12.0)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      DateFormat('dd')
                                          .format(selectedAvailableFromDateTime)
                                          .toString(),
                                      style: CarroTextStyles.large_title_bold,
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                '/',
                                style: CarroTextStyles.large_label,
                              ),
                              InkWell(
                                onTap: () {
                                  showCupertinoModalPopup(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => CupertinoActionSheet(
                                      actions: [
                                        buildDatePickerFrom(),
                                      ],
                                      cancelButton: CupertinoActionSheetAction(
                                        onPressed: () {
                                          setState(() {});
                                          locator<CarroRouter>().pop();
                                        },
                                        child: const Text('Done'),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.dp_20,
                                    horizontal: Dimensions.dp_20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: CarroColors.getColor(
                                        context, CarroColors.list_item_color),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12.0)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      selectedAvailableFromDateTime.year
                                          .toString(),
                                      style: CarroTextStyles.large_title_bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimensions.dp_20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  showCupertinoModalPopup(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => CupertinoActionSheet(
                                      actions: [
                                        buildTimePickerFrom(),
                                      ],
                                      cancelButton: CupertinoActionSheetAction(
                                        onPressed: () {
                                          setState(() {});
                                          locator<CarroRouter>().pop();
                                        },
                                        child: const Text('Done'),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.dp_20,
                                    horizontal: Dimensions.dp_20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: CarroColors.getColor(
                                        context, CarroColors.list_item_color),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12.0)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      DateFormat.jm()
                                          .format(selectedAvailableFromDateTime)
                                          .toString(),
                                      style: CarroTextStyles.large_title_bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimensions.dp_40),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Until',
                              style: CarroTextStyles.medium_label_bold.copyWith(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.registerHeadlineColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.dp_10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  showCupertinoModalPopup(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => CupertinoActionSheet(
                                      actions: [
                                        buildDatePickerTo(),
                                      ],
                                      cancelButton: CupertinoActionSheetAction(
                                        onPressed: () {
                                          setState(() {});
                                          locator<CarroRouter>().pop();
                                        },
                                        child: const Text('Done'),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.dp_20,
                                    horizontal: Dimensions.dp_20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: CarroColors.getColor(
                                        context, CarroColors.list_item_color),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12.0)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      DateFormat.MMM()
                                          .format(selectedAvailableToDateTime)
                                          .toString(),
                                      style: CarroTextStyles.large_title_bold,
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                '/',
                                style: CarroTextStyles.large_label,
                              ),
                              InkWell(
                                onTap: () {
                                  showCupertinoModalPopup(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => CupertinoActionSheet(
                                      actions: [
                                        buildDatePickerTo(),
                                      ],
                                      cancelButton: CupertinoActionSheetAction(
                                        onPressed: () {
                                          setState(() {});
                                          locator<CarroRouter>().pop();
                                        },
                                        child: const Text('Done'),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.dp_20,
                                    horizontal: Dimensions.dp_20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: CarroColors.getColor(
                                        context, CarroColors.list_item_color),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12.0)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      DateFormat('dd')
                                          .format(selectedAvailableToDateTime)
                                          .toString(),
                                      style: CarroTextStyles.large_title_bold,
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                '/',
                                style: CarroTextStyles.large_label,
                              ),
                              InkWell(
                                onTap: () {
                                  showCupertinoModalPopup(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => CupertinoActionSheet(
                                      actions: [
                                        buildDatePickerTo(),
                                      ],
                                      cancelButton: CupertinoActionSheetAction(
                                        onPressed: () {
                                          setState(() {});
                                          locator<CarroRouter>().pop();
                                        },
                                        child: const Text('Done'),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.dp_20,
                                    horizontal: Dimensions.dp_20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: CarroColors.getColor(
                                        context, CarroColors.list_item_color),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12.0)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      selectedAvailableToDateTime.year
                                          .toString(),
                                      style: CarroTextStyles.large_title_bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimensions.dp_20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  showCupertinoModalPopup(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => CupertinoActionSheet(
                                      actions: [
                                        buildTimePickerTo(),
                                      ],
                                      cancelButton: CupertinoActionSheetAction(
                                        onPressed: () {
                                          setState(() {});
                                          locator<CarroRouter>().pop();
                                        },
                                        child: const Text('Done'),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.dp_20,
                                    horizontal: Dimensions.dp_20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: CarroColors.getColor(
                                        context, CarroColors.list_item_color),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12.0)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      DateFormat.jm()
                                          .format(selectedAvailableToDateTime)
                                          .toString(),
                                      style: CarroTextStyles.large_title_bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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
    if (selectedAvailableFromDateTime.isBefore(DateTime.now()) ||
        selectedAvailableToDateTime.isBefore(selectedAvailableFromDateTime)) {
      EasyLoading.showError(
        "Please ensure available until date is not before available from date.",
        duration: const Duration(
          seconds: 3,
        ),
      );
    } else {
      if (selectedAvailableToDateTime
              .difference(selectedAvailableFromDateTime)
              .inHours >=
          3) {
        await addCarModel.addCarPage3Updater(
          availableFrom: selectedAvailableFromDateTime,
          availableTo: selectedAvailableToDateTime,
        );
        //Go to next add car page
        locator<CarroRouter>().navigateTo(CarRoute.addCar4);
      } else {
        EasyLoading.showError(
          "Minimum host time is 3 hours.",
          duration: const Duration(
            seconds: 3,
          ),
        );
      }
    }
  }

  Widget buildDatePickerFrom() => SizedBox(
        height: Dimensions.dp_200,
        child: CupertinoDatePicker(
          minimumDate: DateTime.now(),
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) {
            selectedAvailableFromDateTime = DateTime(
              dateTime.year,
              dateTime.month,
              dateTime.day,
              selectedAvailableFromDateTime.hour,
              selectedAvailableFromDateTime.minute,
            );
          },
        ),
      );

  Widget buildTimePickerFrom() => SizedBox(
        height: Dimensions.dp_200,
        child: CupertinoDatePicker(
          // minimumDate: DateTime.now(),
          mode: CupertinoDatePickerMode.time,
          onDateTimeChanged: (dateTime) {
            selectedAvailableFromDateTime = DateTime(
              selectedAvailableFromDateTime.year,
              selectedAvailableFromDateTime.month,
              selectedAvailableFromDateTime.day,
              dateTime.hour,
              dateTime.minute,
            );
          },
        ),
      );

  Widget buildDatePickerTo() => SizedBox(
        height: Dimensions.dp_200,
        child: CupertinoDatePicker(
          minimumDate: DateTime.now(),
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) {
            selectedAvailableToDateTime = DateTime(
              dateTime.year,
              dateTime.month,
              dateTime.day,
              selectedAvailableToDateTime.hour,
              selectedAvailableToDateTime.minute,
            );
          },
        ),
      );

  Widget buildTimePickerTo() => SizedBox(
        height: Dimensions.dp_200,
        child: CupertinoDatePicker(
          // minimumDate: DateTime.now(),
          mode: CupertinoDatePickerMode.time,
          onDateTimeChanged: (dateTime) {
            selectedAvailableToDateTime = DateTime(
              selectedAvailableToDateTime.year,
              selectedAvailableToDateTime.month,
              selectedAvailableToDateTime.day,
              dateTime.hour,
              dateTime.minute,
            );
          },
        ),
      );
}
