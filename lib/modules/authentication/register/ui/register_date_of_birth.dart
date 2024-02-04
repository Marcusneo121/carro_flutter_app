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
import 'package:provider/provider.dart';

class RegisterDateOfBirthPage extends StatefulWidget {
  const RegisterDateOfBirthPage({super.key});

  @override
  State<RegisterDateOfBirthPage> createState() =>
      _RegisterDateOfBirthPageState();
}

class _RegisterDateOfBirthPageState extends State<RegisterDateOfBirthPage> {
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
                buttonText: 'Next',
                onTap: () {
                  FocusScope.of(context).unfocus();
                  registerModel.setRegisterDataClass(
                    data: RegisterData(
                      dateOfBirth: selectedDateTime,
                    ),
                    page: CommonRoute.registerDateOfBirthPage,
                  );
                  Future.delayed(const Duration(milliseconds: 150), () {
                    //This is use to upgrade current page, so next page will show this page is being go through
                    registerModel.registerProgressUpdater(
                        CommonRoute.registerDateOfBirthPage);
                  });
                  locator<CarroRouter>()
                      .navigateTo(CommonRoute.registerAddressPage);
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
                        FocusScope.of(context).unfocus();
                        registerModel.resetToPageProgressUpdater(
                            CommonRoute.registerPhoneNumberPage);
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
                              'Enter date of birth',
                              style: CarroTextStyles.medium_title_bold.copyWith(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.registerHeadlineColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.dp_5),
                            Text(
                              'So we can understand you better.',
                              style: CarroTextStyles.large_item_text.copyWith(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.textInputColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.dp_25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    showCupertinoModalPopup(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) =>
                                          CupertinoActionSheet(
                                        actions: [
                                          buildDateTimePicker(),
                                        ],
                                        cancelButton:
                                            CupertinoActionSheetAction(
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
                                            .format(selectedDateTime)
                                            .toString(),
                                        // selectedDateTime.month.toString(),
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
                                      builder: (context) =>
                                          CupertinoActionSheet(
                                        actions: [
                                          buildDateTimePicker(),
                                        ],
                                        cancelButton:
                                            CupertinoActionSheetAction(
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
                                            .format(selectedDateTime)
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
                                      builder: (context) =>
                                          CupertinoActionSheet(
                                        actions: [
                                          buildDateTimePicker(),
                                        ],
                                        cancelButton:
                                            CupertinoActionSheetAction(
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
                                        selectedDateTime.year.toString(),
                                        style: CarroTextStyles.large_title_bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
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

  Widget buildDateTimePicker() => SizedBox(
        height: Dimensions.dp_200,
        child: CupertinoDatePicker(
          maximumDate: DateTime.now(),
          initialDateTime: selectedDateTime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) {
            selectedDateTime = dateTime;
            // setState(() {
            //   selectedDateTime = dateTime;
            // });
          },
        ),
      );
}
