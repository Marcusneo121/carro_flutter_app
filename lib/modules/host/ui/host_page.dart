import 'package:carro_flutter_app/core/provider/view_model/theme_provider.dart';
import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/core/widget/booking_host_list_item.dart';
import 'package:carro_flutter_app/core/widget/custom_pull_down_refresh_header.dart';
import 'package:carro_flutter_app/core/widget/shimmer_list_item.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/bookings/entity/booking.dart';
import 'package:carro_flutter_app/modules/host/ui/view_hosting_page.dart';
import 'package:carro_flutter_app/modules/host/view_model/hosting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class HostPage extends StatefulWidget {
  const HostPage({super.key});

  @override
  State<HostPage> createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  HostingModel? model;

  @override
  void initState() {
    super.initState();
    model = HostingModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => model,
      child: SafeArea(
        child: Scaffold(
          body: Consumer<HostingModel>(
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
                              "My hosts",
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
                      Consumer<HostingModel>(
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
                            return model.getHostingList.isEmpty
                                ? SliverFillRemaining(
                                    hasScrollBody: false,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Lottie.asset(
                                          'images/myrequest.json',
                                          width: Dimensions.dp_210,
                                          // height: Dimensions.dp_150,
                                          fit: BoxFit.fill,
                                          repeat: true,
                                        ),
                                        const SizedBox(
                                          height: Dimensions.dp_10,
                                        ),
                                        const Text(
                                          'No guest yet...',
                                          style: CarroTextStyles.normal_text,
                                        ),
                                        const SizedBox(
                                          height: Dimensions.dp_1,
                                        ),
                                        const Text(
                                          'But your guest is on the way !',
                                          style: CarroTextStyles.normal_text,
                                        ),
                                      ],
                                    ),
                                  )
                                : SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        Booking bookingItem =
                                            model.getHostingList[index];
                                        return BookingHostListItem(
                                          bookingHostItem: bookingItem,
                                          onTap: () {
                                            locator<CarroRouter>()
                                                .navigateToWithArgs(
                                              HostingRoute.viewHostingPage,
                                              ViewHostingPageArgs(
                                                hostingModel: model,
                                                hostingData: bookingItem,
                                              ),
                                            );
                                            setState(() {});
                                          },
                                        );
                                      },
                                      childCount: model.getHostingList.length,
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
          //         "My host",
          //         style: CarroTextStyles.large_title_bold,
          //       ),
          //       Consumer<HostingModel>(
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
        ),
      ),
    );
  }
}
