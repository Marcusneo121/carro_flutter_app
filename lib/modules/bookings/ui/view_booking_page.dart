import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carro_flutter_app/core/enums/enums.dart';
import 'package:carro_flutter_app/core/provider/view_model/theme_provider.dart';
import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/core/utils/shared_prefs.dart';
import 'package:carro_flutter_app/core/widget/carro_text_form_field.dart';
import 'package:carro_flutter_app/core/widget/rounded_button.dart';
import 'package:carro_flutter_app/core/widget/status_badge.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/widgets/register_top_bar_widget.dart';
import 'package:carro_flutter_app/modules/bookings/entity/booking.dart';
import 'package:carro_flutter_app/modules/bookings/ui/payment_confirmation_page.dart';
import 'package:carro_flutter_app/modules/bookings/view_model/bookings_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ViewBookingPageArgs {
  ViewBookingPageArgs({required this.bookingModel, required this.bookingData});
  final BookingsModel bookingModel;
  final Booking bookingData;
}

class ViewBookingPage extends StatefulWidget {
  final ViewBookingPageArgs args;

  const ViewBookingPage({super.key, required this.args});

  @override
  State<ViewBookingPage> createState() => _ViewBookingPageState();
}

class _ViewBookingPageState extends State<ViewBookingPage> {
  bool ableToSave = false;
  bool enableBigSaveButton = false;
  TextEditingController priceController = TextEditingController();
  String? perDayPrice;
  SharedPrefs sharef = SharedPrefs();

  saveButtonPress(Booking bookingData) {
    if (priceController.text.isEmpty) {
      EasyLoading.showError('New price cannot be empty before save.');
    } else if (int.parse(priceController.text) !=
        int.parse(bookingData.lastBargainAmount ?? "-1")) {
      perDayPrice = priceController.text.toString();
      ableToSave = false;
      enableBigSaveButton = true;
      priceController.clear();
      setState(() {});
    } else if (int.parse(priceController.text) ==
        int.parse(bookingData.lastBargainAmount ?? "-1")) {
      perDayPrice = priceController.text.toString();
      ableToSave = false;
      enableBigSaveButton = false;
      priceController.clear();
      setState(() {});
    } else {
      EasyLoading.showError('Something went wrong, please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(
            left: Dimensions.dp_20,
            right: Dimensions.dp_20,
            bottom: Dimensions.dp_30,
            top: Dimensions.dp_10,
          ),
          child: enableBigSaveButton == false
              ? acceptRejectButtonDisplay()
              : ableToSave == false && enableBigSaveButton == true
                  ? RoundedButton(
                      buttonText: 'Save',
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        await widget.args.bookingModel.bargaining(
                          bargainID: widget.args.bookingData.oriBargainId,
                          bargainAmount: perDayPrice.toString(),
                          context: context,
                        );
                      })
                  : ableToSave == true && enableBigSaveButton == true
                      ? acceptRejectButtonDisplay()
                      : const SizedBox.shrink(),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                scrolledUnderElevation: 0.0,
                leadingWidth: Dimensions.dp_290,
                leading: RegisterTopBarWidget(
                  titleAppBar: 'Your booking',
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    if (enableBigSaveButton == true) {
                      showCupertinoDialog(
                          context: context,
                          builder: (_) => CupertinoAlertDialog(
                                title: const Text("Are you sure?"),
                                content: Container(
                                  margin: const EdgeInsets.only(
                                      top: Dimensions.dp_10),
                                  child: const Text(
                                      "Your rent price change is yet to save, are you sure to quit?"),
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
                    } else {
                      locator<CarroRouter>().pop();
                    }
                  },
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  padding: const EdgeInsets.only(
                    top: Dimensions.dp_10,
                    bottom: Dimensions.dp_10,
                    // left: Dimensions.dp_20,
                    // right: Dimensions.dp_20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Consumer(
                      //   builder: (context, model, child) {
                      //     if (model.isBusy) {
                      //       return const Center(
                      //         child: CircularProgressIndicator(),
                      //       );
                      //     } else if (model.isError) {
                      //       return const Center(
                      //         child: Text("Something went wrong"),
                      //       );
                      //     } else if (model.isIdle) {
                      //       return const Center(
                      //         child: Text("Good"),
                      //       );
                      //     } else {
                      //       return const SizedBox.shrink();
                      //     }
                      //   },
                      // ),
                      CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          enableInfiniteScroll: false,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          initialPage: 0,
                          enlargeCenterPage: false,
                          scrollDirection: Axis.horizontal,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlayInterval: const Duration(seconds: 6),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 2000),
                        ),
                        items: [
                          widget.args.bookingData.carMainPic,
                          widget.args.bookingData.carImageOne,
                          widget.args.bookingData.carImageTwo,
                          widget.args.bookingData.carImageThree,
                          widget.args.bookingData.carImageFour,
                        ].map((img) {
                          if (img != "-") {
                            return CachedNetworkImage(
                              imageUrl: img ?? "-",
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  margin: const EdgeInsets.only(
                                    left: Dimensions.dp_25,
                                    right: Dimensions.dp_25,
                                    top: Dimensions.dp_15,
                                    bottom: Dimensions.dp_15,
                                  ),
                                  height: Dimensions.dp_280 + Dimensions.dp_40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              progressIndicatorBuilder:
                                  (context, url, progress) {
                                return Container(
                                  height: 145.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                );
                              },
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        }).toList(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: Dimensions.dp_20,
                          right: Dimensions.dp_20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                left: Dimensions.dp_5,
                                right: Dimensions.dp_5,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.args.bookingData.carName
                                            .toString(),
                                        style:
                                            CarroTextStyles.medium_title_bold,
                                      ),
                                      const SizedBox(height: Dimensions.dp_10),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        child: Text(
                                          widget.args.bookingData.carPlate
                                              .toString(),
                                          style: CarroTextStyles.normal_text
                                              .copyWith(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      StatusBadge(
                                          badgeID: widget.args.bookingData
                                                  .bargainStatusId ??
                                              -1,
                                          badgeType: widget.args.bookingData
                                                  .oriBargainName ??
                                              "-"),
                                      const SizedBox(height: Dimensions.dp_10),
                                      widget.args.bookingData.bargainStatusId ==
                                                  2 ||
                                              widget.args.bookingData
                                                      .bargainStatusId ==
                                                  4
                                          ? const StatusBadge(
                                              badgeID: 6,
                                              badgeType: "Payment_Pending")
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: Dimensions.dp_15),
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
                                borderRadius:
                                    BorderRadius.circular(Dimensions.dp_18),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Location",
                                    style: CarroTextStyles.large_label,
                                  ),
                                  const SizedBox(height: Dimensions.dp_10),
                                  Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: Dimensions.dp_15,
                                          horizontal: Dimensions.dp_10),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.dp_12),
                                        border: Border.all(
                                          color: CarroColors.getColor(
                                            context,
                                            CarroColors.iconColor,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.pin_drop_rounded,
                                            color: CarroColors.primayColor,
                                          ),
                                          const SizedBox(
                                              width: Dimensions.dp_10),
                                          Expanded(
                                            child: Text(
                                              widget.args.bookingData.location
                                                  .toString(),
                                              style: CarroTextStyles
                                                  .normal_text_bold
                                                  .copyWith(
                                                color: CarroColors.getColor(
                                                  context,
                                                  CarroColors.iconColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(height: Dimensions.dp_15),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.dp_20,
                                horizontal: Dimensions.dp_20,
                              ),
                              decoration: BoxDecoration(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.carViewListItemBackgroundColor,
                                ),
                                borderRadius:
                                    BorderRadius.circular(Dimensions.dp_18),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Rent date",
                                    style: CarroTextStyles.large_label,
                                  ),
                                  const SizedBox(height: Dimensions.dp_10),
                                  Row(
                                    children: [
                                      const Text(
                                        "From : ",
                                        style: CarroTextStyles
                                            .large_item_text_bold,
                                      ),
                                      Text(
                                        widget.args.bookingData.rentFromDate ==
                                                null
                                            ? "-"
                                            : DateFormat('MM-dd-yyyy  hh:mm a')
                                                .format(DateTime.parse(widget
                                                        .args
                                                        .bookingData
                                                        .rentFromDate ??
                                                    "-"))
                                                .toString(),
                                        style: CarroTextStyles.large_item_text,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: Dimensions.dp_5),
                                  Row(
                                    children: [
                                      const Text(
                                        "Until : ",
                                        style: CarroTextStyles
                                            .large_item_text_bold,
                                      ),
                                      Text(
                                        widget.args.bookingData.rentToDate ==
                                                null
                                            ? "-"
                                            : DateFormat('MM-dd-yyyy  hh:mm a')
                                                .format(DateTime.parse(widget
                                                        .args
                                                        .bookingData
                                                        .rentToDate ??
                                                    "-"))
                                                .toString(),
                                        style: CarroTextStyles.large_item_text,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: Dimensions.dp_15),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.dp_20,
                                horizontal: Dimensions.dp_20,
                              ),
                              decoration: BoxDecoration(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.carViewListItemBackgroundColor,
                                ),
                                borderRadius:
                                    BorderRadius.circular(Dimensions.dp_18),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Price",
                                        style: CarroTextStyles.large_label,
                                      ),
                                      ableToSave == false
                                          ? widget.args.bookingData
                                                          .oriBargainStatusId ==
                                                      0 ||
                                                  widget.args.bookingData
                                                          .oriBargainStatusId ==
                                                      1
                                              ? InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      ableToSave = !ableToSave;
                                                    });
                                                  },
                                                  child: const Text(
                                                    "Edit",
                                                    style: TextStyle(
                                                        color: CarroColors
                                                            .primayColor),
                                                  ),
                                                )
                                              : const SizedBox.shrink()
                                          : InkWell(
                                              onTap: () {
                                                saveButtonPress(
                                                    widget.args.bookingData);
                                              },
                                              child: const Text(
                                                "Save",
                                                style: TextStyle(
                                                    color: CarroColors
                                                        .primayColor),
                                              ),
                                            ),
                                    ],
                                  ),
                                  const SizedBox(height: Dimensions.dp_10),
                                  ableToSave == false
                                      ? Row(
                                          children: [
                                            const Text(
                                              "RM",
                                              style:
                                                  CarroTextStyles.large_label,
                                            ),
                                            const SizedBox(
                                                width: Dimensions.dp_5),
                                            Text(
                                              perDayPrice ??
                                                  widget.args.bookingData
                                                      .lastBargainAmount ??
                                                  "-",
                                              style: CarroTextStyles
                                                  .large_label_bold,
                                            ),
                                            const SizedBox(
                                                width: Dimensions.dp_5),
                                            const Text(
                                              "/day",
                                              style: CarroTextStyles
                                                  .large_normal_text_bold,
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            const SizedBox(
                                                width: Dimensions.dp_5),
                                            Text(
                                              'RM',
                                              style: CarroTextStyles
                                                  .small_label_bold
                                                  .copyWith(
                                                color: CarroColors.getColor(
                                                  context,
                                                  CarroColors.iconColor,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                                width: Dimensions.dp_10),
                                            Flexible(
                                              child: CarroTextFormField(
                                                textInputType:
                                                    const TextInputType
                                                            .numberWithOptions(
                                                        signed: true),
                                                textInputFormatter: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                                topGapHeight: Dimensions.dp_10,
                                                bottomGapHeight:
                                                    Dimensions.dp_10,
                                                controller: priceController,
                                                hintText: 'e.g. 128',
                                                onChanged: (value) {},
                                              ),
                                            ),
                                            const SizedBox(
                                                width: Dimensions.dp_5),
                                            const Text(
                                              "/day",
                                              style: CarroTextStyles
                                                  .large_normal_text_bold,
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                            const SizedBox(height: Dimensions.dp_15),
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
      ),
    );
  }

  Widget acceptRejectButtonDisplay() {
    if (widget.args.bookingData.oriBargainStatusId == 0 &&
        widget.args.bookingData.lastBargainUser?.toInt() ==
            sharef.userSessionData.data?.user?.id?.toInt()) {
      return const SizedBox.shrink();
    } else if (widget.args.bookingData.oriBargainStatusId == 1 &&
        widget.args.bookingData.lastBargainUser?.toInt() ==
            sharef.userSessionData.data?.user?.id?.toInt()) {
      return const SizedBox.shrink();
    } else if (widget.args.bookingData.oriBargainStatusId == 2) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Dimensions.dp_60 + Dimensions.dp_5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total :",
                  style: CarroTextStyles.normal_text.copyWith(
                    color: CarroColors.getColor(
                      context,
                      CarroColors.textInputColor,
                    ),
                  ),
                ),
                Text(
                  "RM ${int.parse(widget.args.bookingData.lastBargainAmount ?? "0") * (widget.args.bookingData.daysOfRental ?? 0)}",
                  style: CarroTextStyles.large_title_bold,
                ),
                Text(
                  "RM ${int.parse(widget.args.bookingData.lastBargainAmount ?? "0") * (widget.args.bookingData.daysOfRental ?? 0)} x ${(widget.args.bookingData.daysOfRental ?? 0)} day(s)",
                  style: CarroTextStyles.large_item_text.copyWith(
                    fontStyle: FontStyle.italic,
                    color: CarroColors.getColor(
                      context,
                      CarroColors.textInputColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            height: Dimensions.dp_60,
            width: Dimensions.dp_130,
            child: ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                // Navigator.pushNamed(context, CarRoute.bookCarPage,
                //     arguments:
                //         BookCarPageArgs(viewCarModel: viewCarModel));
                locator<CarroRouter>().navigateToWithArgs(
                  BookingRoute.paymentConfirmationPage,
                  PaymentConfirmationPageArgs(
                    bookingModel: widget.args.bookingModel,
                    bookingData: widget.args.bookingData,
                  ),
                );
                // setState(() {});
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                  CarroColors.getColor(context, CarroColors.iconColor),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  CarroColors.getColor(context, CarroColors.list_item_color),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.dp_12),
                    //side: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
              child: const Text(
                "Pay",
                style: CarroTextStyles.medium_label_bold,
              ),
            ),
          ),
        ],
      );
    } else if (widget.args.bookingData.oriBargainStatusId == 3) {
      return const SizedBox.shrink();
    } else if (widget.args.bookingData.oriBargainStatusId == 4) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Dimensions.dp_60 + Dimensions.dp_5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total :",
                  style: CarroTextStyles.normal_text.copyWith(
                    color: CarroColors.getColor(
                      context,
                      CarroColors.textInputColor,
                    ),
                  ),
                ),
                Text(
                  "RM ${int.parse(widget.args.bookingData.lastBargainAmount ?? "0") * (widget.args.bookingData.daysOfRental ?? 0)}",
                  style: CarroTextStyles.large_title_bold,
                ),
                Text(
                  "RM ${int.parse(widget.args.bookingData.lastBargainAmount ?? "0") * (widget.args.bookingData.daysOfRental ?? 0)} x ${(widget.args.bookingData.daysOfRental ?? 0)} day(s)",
                  style: CarroTextStyles.large_item_text.copyWith(
                    fontStyle: FontStyle.italic,
                    color: CarroColors.getColor(
                      context,
                      CarroColors.textInputColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            height: Dimensions.dp_60,
            width: Dimensions.dp_130,
            child: ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                // Navigator.pushNamed(context, CarRoute.bookCarPage,
                //     arguments:
                //         BookCarPageArgs(viewCarModel: viewCarModel));
                // locator<CarroRouter>().navigateToWithArgs(
                //     CarRoute.bookCarPage,
                //     BookCarPageArgs(viewCarModel: viewCarModel));
                setState(() {});
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                  CarroColors.getColor(context, CarroColors.iconColor),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  CarroColors.getColor(context, CarroColors.list_item_color),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.dp_12),
                    //side: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
              child: const Text(
                "Pay",
                style: CarroTextStyles.medium_label_bold,
              ),
            ),
          ),
        ],
      );
    } else if (widget.args.bookingData.oriBargainStatusId == 5) {
      return const SizedBox.shrink();
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              height: Dimensions.dp_50,
              child: ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  widget.args.bookingModel.acceptRejectBargain(
                    bargainID: widget.args.bookingData.oriBargainId,
                    hostAction: GuestAction.reject,
                    context: context,
                  );
                  // Navigator.pushNamed(context, CarRoute.bookCarPage,
                  //     arguments:
                  //         BookCarPageArgs(viewCarModel: viewCarModel));
                  // locator<CarroRouter>().navigateToWithArgs(
                  //     CarRoute.bookCarPage,
                  //     BookCarPageArgs(viewCarModel: viewCarModel));
                  setState(() {});
                },
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(0.0),
                  overlayColor: MaterialStateProperty.all<Color>(
                      Colors.red.withOpacity(0.2)),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.red,
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    CarroColors.getColor(
                        context, CarroColors.scaffoldBackgroundColor),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.dp_12),
                      side: const BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                child: const Text(
                  "Reject",
                  style: CarroTextStyles.medium_label_bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: Dimensions.dp_10),
          Expanded(
            child: SizedBox(
              height: Dimensions.dp_50,
              child: ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  widget.args.bookingModel.acceptRejectBargain(
                    bargainID: widget.args.bookingData.oriBargainId,
                    hostAction: GuestAction.accept,
                    context: context,
                  );
                  // Navigator.pushNamed(context, CarRoute.bookCarPage,
                  //     arguments:
                  //         BookCarPageArgs(viewCarModel: viewCarModel));
                  // locator<CarroRouter>().navigateToWithArgs(
                  //     CarRoute.bookCarPage,
                  //     BookCarPageArgs(viewCarModel: viewCarModel));
                  setState(() {});
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                    CarroColors.getColor(context, CarroColors.iconColor),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.green,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.dp_12),
                      //side: const BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                child: Text(
                  "Accept",
                  style: CarroTextStyles.medium_label_bold
                      .copyWith(color: CarroColors.black_1),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
