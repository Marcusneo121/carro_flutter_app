import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carro_flutter_app/core/provider/view_model/theme_provider.dart';
import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/core/utils/shared_prefs.dart';
import 'package:carro_flutter_app/core/widget/custom_pull_down_refresh_header.dart';
import 'package:carro_flutter_app/core/widget/shimmer_list_item.dart';
import 'package:carro_flutter_app/modules/cars/view_car/ui/view_car_page.dart';
import 'package:carro_flutter_app/modules/home/entity/car.dart';
import 'package:carro_flutter_app/modules/home/ui/widgets/home_car_list_item.dart';
import 'package:carro_flutter_app/modules/home/ui/widgets/home_top_widget.dart';
import 'package:carro_flutter_app/modules/home/view_model/home_model.dart';
import 'package:carro_flutter_app/modules/settings/entity/post.dart';
import 'package:carro_flutter_app/modules/settings/ui/widgets/setting_item_testing.dart';
import 'package:carro_flutter_app/modules/settings/view_model/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with AutomaticKeepAliveClientMixin<Homepage> {
  HomeProvider? model;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    model = HomeProvider();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => model,
      child: SafeArea(
        child: Scaffold(body: Consumer<HomeProvider>(
          builder: (context, model, child) {
            return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    pinned: true,
                    scrolledUnderElevation: 0.0,
                    leadingWidth: double.infinity,
                    leading: HomeTopWidget(
                      buttonOne: () {
                        locator<CarroRouter>().navigateTo(CarRoute.addCar);
                        // print(SharedPrefs().userSessionData.token?.token.toString());
                      },
                      buttonTwo: () {},
                      buttonThree: () {},
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
                    Consumer<HomeProvider>(
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
                          return model.getCarList.isEmpty
                              ? SliverFillRemaining(
                                  hasScrollBody: false,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                    Car carItem = model.getCarList[index];
                                    return HomeCarListItem(
                                        onTap: () {
                                          locator<CarroRouter>()
                                              .navigateToWithArgs(
                                            CarRoute.viewCarPage,
                                            ViewCarPageArgs(
                                              carData: carItem,
                                            ),
                                          );
                                        },
                                        carItem: carItem);
                                  }, childCount: model.getCarList.length),
                                );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        )

            // Column(
            //   children: [
            //     HomeTopWidget(
            //       buttonOne: () {
            //         locator<CarroRouter>().navigateTo(CarRoute.addCar);
            //         // print(SharedPrefs().userSessionData.token?.token.toString());
            //       },
            //       buttonTwo: () {},
            //       buttonThree: () {},
            //     ),
            //     Consumer<HomeProvider>(
            //       builder: (context, homeModel, child) {
            //         if (homeModel.isBusy) {
            //           return const Expanded(
            //             child: Center(
            //               child: CircularProgressIndicator(),
            //             ),
            //           );
            //         } else if (homeModel.isError) {
            //           return const Expanded(
            //             child: Center(
            //               child: Text("Something went wrong"),
            //             ),
            //           );
            //         } else {
            //           return Expanded(
            //             child: homeModel.cars.isNotEmpty
            //                 ? ListView.builder(
            //                     itemCount: homeModel.cars.length,
            //                     physics: const AlwaysScrollableScrollPhysics(),
            //                     itemBuilder: (context, position) {
            //                       Car carItem = homeModel.cars[position];
            //                       return HomeCarListItem(
            //                           onTap: () {
            //                             locator<CarroRouter>().navigateToWithArgs(
            //                               CarRoute.viewCarPage,
            //                               ViewCarPageArgs(
            //                                 carData: carItem,
            //                               ),
            //                             );
            //                           },
            //                           carItem: carItem);
            //                     },
            //                   )
            //                 : const Center(
            //                     child: Text("No data"),
            //                   ),
            //           );
            //         }
            //       },
            //     ),
            //   ],
            // ),
            ),
      ),
    );
  }
}
