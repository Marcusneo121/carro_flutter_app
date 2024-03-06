import 'package:cached_network_image/cached_network_image.dart';
import 'package:carro_flutter_app/core/provider/view_model/theme_provider.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/core/widget/status_badge.dart';
import 'package:carro_flutter_app/modules/bookings/entity/booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookingHostListItem extends StatelessWidget {
  final Booking bookingHostItem;
  final Function() onTap;

  const BookingHostListItem({
    super.key,
    required this.bookingHostItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      scaleFactor: 0.85,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: context.read<ThemeProvider>().getTheme == ThemeMode.dark
                  ? const Color.fromARGB(0, 198, 184, 184)
                  : Colors.grey,
              offset: const Offset(0.0, 0.8), //(x,y)
              blurRadius: 3.0,
            ),
          ],
          color: Theme.of(context).colorScheme.brightness == Brightness.dark
              ? Theme.of(context).colorScheme.secondary
              : Colors.white,
        ),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: bookingHostItem.carMainPic.toString(),
              // imageUrl:
              //     'https://www.topgear.com/sites/default/files/2022/07/13.jpg',
              imageBuilder: (context, imageProvider) {
                return Container(
                  // margin: EdgeInsets.symmetric(
                  //     horizontal: 20, vertical: 20),
                  height: 135.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
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
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookingHostItem.carName.toString(),
                  style: CarroTextStyles.small_label_bold,
                  // style: Theme.of(context)
                  //     .textTheme
                  //     .titleLarge
                  //     ?.copyWith(fontWeight: FontWeight.bold),
                ),
                StatusBadge(
                    badgeID: bookingHostItem.bargainStatusId ?? -1,
                    badgeType: bookingHostItem.oriBargainName ?? "-"),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Text(
                        bookingHostItem.carPlate.toString(),
                        style: CarroTextStyles.medium_item_text.copyWith(
                          color: Colors.grey,
                        ),
                        // style: Theme.of(context)
                        //     .textTheme
                        //     .bodySmall
                        //     ?.copyWith(
                        //       color: Theme.of(context)
                        //                   .colorScheme
                        //                   .brightness ==
                        //               Brightness.dark
                        //           ? Colors.grey
                        //           : Colors.grey,
                        //     ),
                      ),
                    ),
                    Text(
                      "RM ${bookingHostItem.lastBargainAmount.toString()} /day",
                      style: CarroTextStyles.medium_item_text_bold.copyWith(
                        color: CarroColors.getColor(
                          context,
                          CarroColors.black_8,
                        ),
                      ),
                      // style: Theme.of(context)
                      //     .textTheme
                      //     .labelMedium
                      //     ?.copyWith(
                      //       color: CarroColors.getColor(
                      //         context,
                      //         CarroColors.black_8,
                      //       ),
                      //     ),
                    ),
                  ],
                ),
                bookingHostItem.bargainStatusId == 2 ||
                        bookingHostItem.bargainStatusId == 4
                    ? bookingHostItem.bargainStatusId == 6
                        ? const SizedBox.shrink()
                        : const StatusBadge(
                            badgeID: 7, badgeType: "Payment_Pending")
                    : const SizedBox.shrink(),
              ],
            ),
            // const SizedBox(height: Dimensions.dp_20),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       "From : ${DateFormat('MM-dd-yyyy  hh:mm a').format(DateTime.parse(bookingHostItem.rentToDate ?? "-")).toString()}",
            //       style: CarroTextStyles.medium_item_text_bold.copyWith(
            //         color: CarroColors.getColor(
            //           context,
            //           CarroColors.black_8,
            //         ),
            //       ),
            //     ),
            //     const SizedBox(height: Dimensions.dp_5),
            //     Text(
            //       "Until : ${DateFormat('MM-dd-yyyy  hh:mm a').format(DateTime.parse(bookingHostItem.rentToDate ?? "-")).toString()}",
            //       style: CarroTextStyles.medium_item_text_bold.copyWith(
            //         color: CarroColors.getColor(
            //           context,
            //           CarroColors.black_8,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
