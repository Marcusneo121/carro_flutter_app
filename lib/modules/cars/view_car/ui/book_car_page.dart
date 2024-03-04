import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/core/widget/carro_text_form_field.dart';
import 'package:carro_flutter_app/core/widget/rounded_button.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/widgets/register_top_bar_widget.dart';
import 'package:carro_flutter_app/modules/cars/view_car/view_model/view_car_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookCarPageArgs {
  BookCarPageArgs({required this.viewCarModel});
  final ViewCarModel viewCarModel;
}

class BookCarPage extends StatefulWidget {
  final BookCarPageArgs args;
  const BookCarPage({super.key, required this.args});

  @override
  State<BookCarPage> createState() => _BookCarPageState();
}

class _BookCarPageState extends State<BookCarPage> {
  DateTime selectedFromDateTime = DateTime.now();
  DateTime selectedToDateTime = DateTime.now();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        // padding: const EdgeInsets.symmetric(
        //     vertical: Dimensions.dp_15, horizontal: Dimensions.dp_30),
        margin: const EdgeInsets.only(
          top: Dimensions.dp_10,
          left: Dimensions.dp_30,
          right: Dimensions.dp_30,
          bottom: Dimensions.dp_40,
        ),
        child: RoundedButton(
            buttonText: 'Next',
            onTap: () async {
              FocusScope.of(context).unfocus();
              await nextButtonFunction(
                widget.args.viewCarModel,
                context,
                DateTime.parse(
                    widget.args.viewCarModel.getCarData.availableFromDate ??
                        "-"),
                DateTime.parse(
                    widget.args.viewCarModel.getCarData.availableToDate ?? "-"),
              );
              setState(() {});
            }),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              scrolledUnderElevation: 0.0,
              leadingWidth: Dimensions.dp_290,
              leading: RegisterTopBarWidget(
                titleAppBar: 'Book this car',
                onTap: () {
                  FocusScope.of(context).unfocus();
                  locator<CarroRouter>().pop();
                },
              ),
            ),
            //was wanted to use consumer here, but changeNotifierProvider in front of this page,
            //dont allow, cuz it need in material app
            //so made this page to accept viewCarModel as args
            // another way is to open a new Model for this book car page and use ChangeNotifierProvider of it own,
            // but not necessary as of now, cuz this page feature is tool small.
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                padding: const EdgeInsets.only(
                  top: Dimensions.dp_10,
                  bottom: Dimensions.dp_10,
                  left: Dimensions.dp_20,
                  right: Dimensions.dp_20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   padding: const EdgeInsets.only(
                    //     top: Dimensions.dp_10,
                    //     bottom: Dimensions.dp_10,
                    //     left: Dimensions.dp_10,
                    //     right: Dimensions.dp_10,
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       Text('safada'),
                    //     ],
                    //   ),
                    // ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.dp_20,
                        horizontal: Dimensions.dp_20,
                      ),
                      decoration: BoxDecoration(
                        color: CarroColors.getColor(
                          context,
                          CarroColors.carViewListItemBackgroundColor,
                        ),
                        borderRadius: BorderRadius.circular(Dimensions.dp_18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              top: Dimensions.dp_5,
                              left: Dimensions.dp_5,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Car Brand and Name : ",
                                      style:
                                          CarroTextStyles.large_item_text_bold,
                                    ),
                                    const SizedBox(width: Dimensions.dp_5),
                                    Text(
                                      widget.args.viewCarModel.getCarData
                                              .carName ??
                                          "-",
                                      style: CarroTextStyles.large_item_text
                                          .copyWith(
                                        color: CarroColors.getColor(
                                          context,
                                          CarroColors.registerHeadlineColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: Dimensions.dp_5),
                                Row(
                                  children: [
                                    const Text(
                                      "Color : ",
                                      style:
                                          CarroTextStyles.large_item_text_bold,
                                    ),
                                    const SizedBox(width: Dimensions.dp_5),
                                    Text(
                                      widget.args.viewCarModel.getCarData
                                              .color ??
                                          "-",
                                      style: CarroTextStyles.large_item_text
                                          .copyWith(
                                        color: CarroColors.getColor(
                                          context,
                                          CarroColors.registerHeadlineColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: Dimensions.dp_5),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Location : ",
                                      style:
                                          CarroTextStyles.large_item_text_bold,
                                    ),
                                    const SizedBox(width: Dimensions.dp_5),
                                    Flexible(
                                      child: Text(
                                        widget.args.viewCarModel.getCarData
                                                .location ??
                                            "-",
                                        style: CarroTextStyles.large_item_text
                                            .copyWith(
                                          color: CarroColors.getColor(
                                            context,
                                            CarroColors.registerHeadlineColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: Dimensions.dp_20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "RM ${widget.args.viewCarModel.getCarData.price ?? "-"}",
                                        style: CarroTextStyles.medium_title_bold
                                            .copyWith(
                                          color: CarroColors.getColor(
                                            context,
                                            CarroColors.registerHeadlineColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: Dimensions.dp_5),
                                    const Text(
                                      "/ day",
                                      style:
                                          CarroTextStyles.large_item_text_bold,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: Dimensions.dp_20,
                        bottom: Dimensions.dp_10,
                        left: Dimensions.dp_10,
                        right: Dimensions.dp_20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enter price you wish to rent per day',
                            style:
                                CarroTextStyles.large_normal_text_bold.copyWith(
                              color: CarroColors.getColor(
                                context,
                                CarroColors.textInputColor,
                              ),
                            ),
                          ),
                          Text(
                            "* If you don't wish to bargain, please enter normal price.",
                            style: CarroTextStyles.medium_item_text.copyWith(
                              fontStyle: FontStyle.italic,
                              color: CarroColors.getColor(
                                context,
                                CarroColors.textInputColor,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const SizedBox(width: Dimensions.dp_5),
                              Text(
                                'RM',
                                style:
                                    CarroTextStyles.small_label_bold.copyWith(
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
                                  hintText:
                                      'e.g. ${widget.args.viewCarModel.getCarData.price ?? "128"}',
                                  onChanged: (value) {},
                                ),
                              ),
                              const SizedBox(width: Dimensions.dp_30),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: Dimensions.dp_10),
                    Container(
                      padding: const EdgeInsets.only(
                        top: Dimensions.dp_10,
                        bottom: Dimensions.dp_10,
                        left: Dimensions.dp_10,
                        right: Dimensions.dp_10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select the date and time to book',
                            style:
                                CarroTextStyles.large_normal_text_bold.copyWith(
                              color: CarroColors.getColor(
                                context,
                                CarroColors.textInputColor,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: Dimensions.dp_10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'From',
                                  style:
                                      CarroTextStyles.small_label_bold.copyWith(
                                    color: CarroColors.getColor(
                                      context,
                                      CarroColors.registerHeadlineColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: Dimensions.dp_10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showCupertinoModalPopup(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) =>
                                            CupertinoActionSheet(
                                          actions: [
                                            buildDatePickerFrom(
                                                DateTime.parse(widget
                                                        .args
                                                        .viewCarModel
                                                        .getCarData
                                                        .availableToDate ??
                                                    "-"),
                                                DateTime.parse(widget
                                                        .args
                                                        .viewCarModel
                                                        .getCarData
                                                        .availableFromDate ??
                                                    "-")),
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
                                        color: CarroColors.getColor(context,
                                            CarroColors.list_item_color),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12.0)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          DateFormat.MMM()
                                              .format(selectedFromDateTime)
                                              .toString(),
                                          style:
                                              CarroTextStyles.large_title_bold,
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
                                            buildDatePickerFrom(
                                                DateTime.parse(widget
                                                        .args
                                                        .viewCarModel
                                                        .getCarData
                                                        .availableToDate ??
                                                    "-"),
                                                DateTime.parse(widget
                                                        .args
                                                        .viewCarModel
                                                        .getCarData
                                                        .availableFromDate ??
                                                    "-")),
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
                                        color: CarroColors.getColor(context,
                                            CarroColors.list_item_color),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12.0)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          DateFormat('dd')
                                              .format(selectedFromDateTime)
                                              .toString(),
                                          style:
                                              CarroTextStyles.large_title_bold,
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
                                            buildDatePickerFrom(
                                                DateTime.parse(widget
                                                        .args
                                                        .viewCarModel
                                                        .getCarData
                                                        .availableToDate ??
                                                    "-"),
                                                DateTime.parse(widget
                                                        .args
                                                        .viewCarModel
                                                        .getCarData
                                                        .availableFromDate ??
                                                    "-")),
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
                                        color: CarroColors.getColor(context,
                                            CarroColors.list_item_color),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12.0)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          selectedFromDateTime.year.toString(),
                                          style:
                                              CarroTextStyles.large_title_bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: Dimensions.dp_20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showCupertinoModalPopup(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) =>
                                            CupertinoActionSheet(
                                          actions: [
                                            buildTimePickerFrom(),
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
                                        color: CarroColors.getColor(context,
                                            CarroColors.list_item_color),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12.0)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          DateFormat.jm()
                                              .format(selectedFromDateTime)
                                              .toString(),
                                          style:
                                              CarroTextStyles.large_title_bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: Dimensions.dp_30),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'Until',
                                  style:
                                      CarroTextStyles.small_label_bold.copyWith(
                                    color: CarroColors.getColor(
                                      context,
                                      CarroColors.registerHeadlineColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: Dimensions.dp_10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showCupertinoModalPopup(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) =>
                                            CupertinoActionSheet(
                                          actions: [
                                            buildDatePickerTo(DateTime.parse(
                                                widget
                                                        .args
                                                        .viewCarModel
                                                        .getCarData
                                                        .availableToDate ??
                                                    "-")),
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
                                        color: CarroColors.getColor(context,
                                            CarroColors.list_item_color),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12.0)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          DateFormat.MMM()
                                              .format(selectedToDateTime)
                                              .toString(),
                                          style:
                                              CarroTextStyles.large_title_bold,
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
                                            buildDatePickerTo(DateTime.parse(
                                                widget
                                                        .args
                                                        .viewCarModel
                                                        .getCarData
                                                        .availableToDate ??
                                                    "-")),
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
                                        color: CarroColors.getColor(context,
                                            CarroColors.list_item_color),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12.0)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          DateFormat('dd')
                                              .format(selectedToDateTime)
                                              .toString(),
                                          style:
                                              CarroTextStyles.large_title_bold,
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
                                            buildDatePickerTo(DateTime.parse(
                                                widget
                                                        .args
                                                        .viewCarModel
                                                        .getCarData
                                                        .availableToDate ??
                                                    "-")),
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
                                        color: CarroColors.getColor(context,
                                            CarroColors.list_item_color),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12.0)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          selectedToDateTime.year.toString(),
                                          style:
                                              CarroTextStyles.large_title_bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: Dimensions.dp_20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showCupertinoModalPopup(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) =>
                                            CupertinoActionSheet(
                                          actions: [
                                            buildTimePickerTo(),
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
                                        color: CarroColors.getColor(context,
                                            CarroColors.list_item_color),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12.0)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          DateFormat.jm()
                                              .format(selectedToDateTime)
                                              .toString(),
                                          style:
                                              CarroTextStyles.large_title_bold,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDatePickerFrom(
          DateTime availableUntilTime, DateTime availableFromTime) =>
      SizedBox(
        height: Dimensions.dp_200,
        child: CupertinoDatePicker(
          initialDateTime: availableFromTime,
          minimumDate: availableFromTime,
          maximumDate: availableUntilTime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) {
            selectedFromDateTime = DateTime(
              dateTime.year,
              dateTime.month,
              dateTime.day,
              selectedFromDateTime.hour,
              selectedFromDateTime.minute,
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
            selectedFromDateTime = DateTime(
              selectedFromDateTime.year,
              selectedFromDateTime.month,
              selectedFromDateTime.day,
              dateTime.hour,
              dateTime.minute,
            );
          },
        ),
      );

  Widget buildDatePickerTo(DateTime availableUntilTime) => SizedBox(
        height: Dimensions.dp_200,
        child: CupertinoDatePicker(
          minimumDate: DateTime.now(),
          maximumDate: availableUntilTime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) {
            selectedToDateTime = DateTime(
              dateTime.year,
              dateTime.month,
              dateTime.day,
              selectedToDateTime.hour,
              selectedToDateTime.minute,
            );
          },
        ),
      );

  Widget buildTimePickerTo() => SizedBox(
        height: Dimensions.dp_200,
        child: CupertinoDatePicker(
          // minimumDate: DateTime.now(),
          // maximumDate: availableUntilTime,
          mode: CupertinoDatePickerMode.time,
          onDateTimeChanged: (dateTime) {
            selectedToDateTime = DateTime(
              selectedToDateTime.year,
              selectedToDateTime.month,
              selectedToDateTime.day,
              dateTime.hour,
              dateTime.minute,
            );
          },
        ),
      );

  nextButtonFunction(ViewCarModel viewCarModel, BuildContext context,
      DateTime availableFromDate, DateTime availableToDate) async {
    if (priceController.text.isEmpty) {
      EasyLoading.showError(
        "Please enter price you wish to rent",
        dismissOnTap: false,
        duration: const Duration(seconds: 2),
      );
    } else {
      if (selectedFromDateTime.isBefore(availableFromDate)) {
        EasyLoading.showError(
          "You are unable to book time before the host available time. Please book same day or after ${DateFormat("yyyy-MM-dd HH:mm a").format(availableFromDate)}",
          duration: const Duration(
            seconds: 3,
          ),
        );
      } else if (selectedFromDateTime.isBefore(DateTime.now())) {
        EasyLoading.showError(
          "Please ensure booking from date time is not before current date time",
          duration: const Duration(
            seconds: 3,
          ),
        );
      } else if (selectedToDateTime.isBefore(selectedFromDateTime)) {
        EasyLoading.showError(
          "Please ensure booking until date is not before booking from date.",
          duration: const Duration(
            seconds: 3,
          ),
        );
      } else {
        if (selectedToDateTime.difference(selectedFromDateTime).inHours >= 3) {
          await viewCarModel.bookCar(
            carID: widget.args.viewCarModel.getCarData.id,
            bargainAmount: priceController.text.toString(),
            rentFrom: selectedFromDateTime,
            rentTo: selectedToDateTime,
          );
        } else {
          EasyLoading.showError(
            "Minimum book time is 3 hours.",
            duration: const Duration(
              seconds: 3,
            ),
          );
        }
      }
    }
  }
}
