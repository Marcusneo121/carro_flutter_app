import 'package:cached_network_image/cached_network_image.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/core/widget/rounded_button.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/widgets/register_top_bar_widget.dart';
import 'package:carro_flutter_app/modules/bookings/entity/booking.dart';
import 'package:carro_flutter_app/modules/bookings/view_model/bookings_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentConfirmationPageArgs {
  PaymentConfirmationPageArgs(
      {required this.bookingModel, required this.bookingData});
  final BookingsModel bookingModel;
  final Booking bookingData;
}

class PaymentConfirmationPage extends StatefulWidget {
  final PaymentConfirmationPageArgs args;

  const PaymentConfirmationPage({super.key, required this.args});

  @override
  State<PaymentConfirmationPage> createState() =>
      _PaymentConfirmationPageState();
}

class _PaymentConfirmationPageState extends State<PaymentConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
          left: Dimensions.dp_20,
          right: Dimensions.dp_20,
          bottom: Dimensions.dp_30,
          top: Dimensions.dp_10,
        ),
        child: RoundedButton(
            buttonText: 'Checkout',
            onTap: () async {
              FocusScope.of(context).unfocus();
              await widget.args.bookingModel.initPaymentSheet(
                totalAmount:
                    "${int.parse(widget.args.bookingData.lastBargainAmount ?? "0") * (widget.args.bookingData.daysOfRental ?? 0)}",
                bargainID: widget.args.bookingData.oriBargainId ?? -1,
                rentalTansactionId: widget.args.bookingData.transactionId ?? -1,
                bookingData: widget.args.bookingData,
              );
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
                titleAppBar: 'Confirm your booking',
                onTap: () async {
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
                  left: Dimensions.dp_20,
                  right: Dimensions.dp_20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                        borderRadius: BorderRadius.circular(Dimensions.dp_18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            height: Dimensions.dp_200,
                            imageUrl: widget.args.bookingData.carMainPic ?? "-",
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    // left: Dimensions.dp_25,
                                    // right: Dimensions.dp_25,
                                    // top: Dimensions.dp_15,
                                    // bottom: Dimensions.dp_15,
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
                            progressIndicatorBuilder: (context, url, progress) {
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
                          ),
                          const SizedBox(height: Dimensions.dp_15),
                          Text(
                            widget.args.bookingData.carName.toString(),
                            style: CarroTextStyles.large_label_bold,
                          ),
                          const SizedBox(height: Dimensions.dp_15),
                          Row(
                            children: [
                              const Text(
                                "From : ",
                                style: CarroTextStyles.large_item_text_bold,
                              ),
                              Text(
                                widget.args.bookingData.rentFromDate == null
                                    ? "-"
                                    : DateFormat('MM-dd-yyyy  hh:mm a')
                                        .format(DateTime.parse(widget.args
                                                .bookingData.rentFromDate ??
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
                                style: CarroTextStyles.large_item_text_bold,
                              ),
                              Text(
                                widget.args.bookingData.rentToDate == null
                                    ? "-"
                                    : DateFormat('MM-dd-yyyy  hh:mm a')
                                        .format(DateTime.parse(widget
                                                .args.bookingData.rentToDate ??
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
                                "Total Day(s) Rent : ",
                                style: CarroTextStyles.large_item_text_bold,
                              ),
                              Text(
                                "${widget.args.bookingData.daysOfRental.toString()} day(s)",
                                style: CarroTextStyles.large_item_text,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: Dimensions.dp_25),
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
                        borderRadius: BorderRadius.circular(Dimensions.dp_18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Booking Summary",
                            style: CarroTextStyles.small_label_bold,
                          ),
                          const SizedBox(height: Dimensions.dp_30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Price per day : ",
                                style: CarroTextStyles.large_item_text_bold,
                              ),
                              Text(
                                "RM ${widget.args.bookingData.lastBargainAmount}.00",
                                style: CarroTextStyles.small_label_bold,
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimensions.dp_5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Day(s) rent : ",
                                style: CarroTextStyles.large_item_text_bold,
                              ),
                              Text(
                                "${widget.args.bookingData.daysOfRental} day(s)",
                                style: CarroTextStyles.small_label_bold,
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimensions.dp_15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Total Amount :",
                                style: CarroTextStyles.small_label_bold,
                              ),
                              Text(
                                "RM ${int.parse(widget.args.bookingData.lastBargainAmount ?? "0") * (widget.args.bookingData.daysOfRental ?? 0)}.00",
                                style: CarroTextStyles.small_label_bold,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: Dimensions.dp_15),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '**Ensure the total amount to pay and day(s) of rental is satisfied before checkout.',
                          style: CarroTextStyles.large_item_text.copyWith(
                            color: CarroColors.getColor(
                              context,
                              CarroColors.textInputColor,
                            ),
                          ),
                        ),
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
}
