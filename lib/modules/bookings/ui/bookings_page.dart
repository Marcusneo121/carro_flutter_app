import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/core/widget/booking_host_list_item.dart';
import 'package:carro_flutter_app/core/widget/custom_pull_down_refresh_header.dart';
import 'package:carro_flutter_app/core/widget/shimmer_list_item.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/widgets/register_top_bar_widget.dart';
import 'package:carro_flutter_app/modules/bookings/entity/booking.dart';
import 'package:carro_flutter_app/modules/bookings/ui/view_booking_page.dart';
import 'package:carro_flutter_app/modules/bookings/view_model/bookings_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  BookingsModel? model;

  @override
  void initState() {
    super.initState();
    model = BookingsModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => model,
      child: SafeArea(
        child: Scaffold(
          body: Consumer<BookingsModel>(
            builder: (context, model, child) {
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      pinned: false,
                      scrolledUnderElevation: 0.0,
                      leadingWidth: Dimensions.dp_290,
                      leading: Container(
                        padding: const EdgeInsets.only(
                            top: Dimensions.dp_18, left: Dimensions.dp_9),
                        child: Row(
                          children: [
                            const SizedBox(width: Dimensions.dp_8),
                            Text(
                              "My bookings",
                              style: CarroTextStyles.large_title_bold.copyWith(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.iconColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: SmartRefresher(
                  header: const CarroCustomPullDownRefreshHeader(),
                  controller: model.refreshController,
                  onRefresh: () async {
                    await model.init();
                  },
                  child: CustomScrollView(
                    slivers: [
                      // CupertinoSliverRefreshControl(
                      //   onRefresh: () async {
                      //     await model?.init();
                      //     await Future.delayed(Duration(seconds: 2));
                      //   },
                      // ),
                      Consumer<BookingsModel>(
                        builder: (context, model, child) {
                          if (model.isBusy) {
                            return const SliverFillRemaining(
                              hasScrollBody: false,
                              child: Column(
                                children: [
                                  ShimmerListItem(),
                                  ShimmerListItem(),
                                  ShimmerListItem(),
                                  ShimmerListItem(),
                                ],
                              ),
                            );
                            // return const SliverFillRemaining(
                            //   hasScrollBody: false,
                            //   child: Center(
                            //     child: CircularProgressIndicator(),
                            //   ),
                            // );
                          } else if (model.isError) {
                            return const SliverFillRemaining(
                              hasScrollBody: false,
                              child: Center(
                                child: Text("Something went wrong"),
                              ),
                            );
                          } else {
                            return model.getBookingList.isEmpty
                                ? SliverFillRemaining(
                                    hasScrollBody: false,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Lottie.asset(
                                          'images/nothinghere.json',
                                          width: Dimensions.dp_165,
                                          // height: Dimensions.dp_150,
                                          fit: BoxFit.fill,
                                          repeat: true,
                                        ),
                                        const SizedBox(
                                          height: Dimensions.dp_10,
                                        ),
                                        const Text(
                                          'No booking yet...',
                                          style: CarroTextStyles.normal_text,
                                        ),
                                        const SizedBox(
                                          height: Dimensions.dp_4,
                                        ),
                                        const Text(
                                          'Find a car, Book & Drive it !',
                                          style: CarroTextStyles.normal_text,
                                        ),
                                      ],
                                    ),
                                  )
                                : SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        Booking bookingItem =
                                            model.getBookingList[index];
                                        return BookingHostListItem(
                                          bookingHostItem: bookingItem,
                                          onTap: () {
                                            locator<CarroRouter>()
                                                .navigateToWithArgs(
                                              BookingRoute.viewBookingPage,
                                              ViewBookingPageArgs(
                                                bookingModel: model,
                                                bookingData: bookingItem,
                                              ),
                                            );
                                            setState(() {});
                                          },
                                        );
                                      },
                                      childCount: model.getBookingList.length,
                                    ),
                                  );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

//Traditional Approach for after Scaffold
// Container(
//   padding: const EdgeInsets.only(
//     top: Dimensions.dp_20,
//     left: Dimensions.dp_20,
//     right: Dimensions.dp_20,
//   ),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(
//         "My bookings",
//         style: CarroTextStyles.large_title_bold,
//       ),
//       Consumer<BookingsModel>(
//         builder: (context, model, child) {
//           if (model.isBusy) {
//             return const Expanded(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           } else if (model.isError) {
//             return const Expanded(
//               child: Center(
//                 child: Text("Something went wrong"),
//               ),
//             );
//           } else {
//             return Expanded(
//               child: model.getBookingList.isNotEmpty
//                   ? ListView.builder(
//                       itemCount: model.getBookingList.length,
//                       physics: const AlwaysScrollableScrollPhysics(),
//                       itemBuilder: (context, position) {
//                         Booking bookingItem =
//                             model.getBookingList[position];
//                         return Text(bookingItem.carName ?? "-");
//                         // return HomeCarListItem(
//                         //     onTap: () {
//                         //       locator<CarroRouter>()
//                         //           .navigateToWithArgs(
//                         //         CarRoute.viewCarPage,
//                         //         ViewCarPageArgs(
//                         //           carData: carItem,
//                         //         ),
//                         //       );
//                         //     },
//                         //     carItem: carItem);
//                       },
//                     )
//                   : const Center(
//                       child: Text("No data"),
//                     ),
//             );
//           }
//         },
//       ),
//     ],
//   ),
// ),

//Another approach to use for Model.isIdle
// return SliverFillRemaining(ß
//   // hasScrollBody: false,
//   child: Consumer<BookingsModel>(
//     builder: (context, model, child) {
//       if (model.isBusy) {
//         return const Expanded(
//           child: Center(
//             child: CircularProgressIndicator(),
//           ),
//         );
//       } else if (model.isError) {
//         return const Expanded(
//           child: Center(
//             child: Text("Something went wrong"),
//           ),
//         );
//       } else {
//         return model.getBookingList.isNotEmpty
//             ? ListView.builder(
//                 itemCount: model.getBookingList.length,
//                 physics:
//                     const AlwaysScrollableScrollPhysics(),
//                 itemBuilder: (context, position) {
//                   Booking bookingItem =
//                       model.getBookingList[position];
//                   return Text(bookingItem.carName ?? "-");
//                   // return HomeCarListItem(
//                   //     onTap: () {
//                   //       locator<CarroRouter>()
//                   //           .navigateToWithArgs(
//                   //         CarRoute.viewCarPage,
//                   //         ViewCarPageArgs(
//                   //           carData: carItem,
//                   //         ),
//                   //       );
//                   //     },
//                   //     carItem: carItem);
//                 },
//               )
//             : const Center(
//                 child: Text("No data"),
//               );
//       }
//     },
//   ),
// );
