import 'package:cached_network_image/cached_network_image.dart';
import 'package:carro_flutter_app/core/provider/view_model/theme_provider.dart';
import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/core/utils/shared_prefs.dart';
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
import 'package:provider/provider.dart';
import 'package:carro_flutter_app/main.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            HomeTopWidget(
              buttonOne: () {
                locator<CarroRouter>().navigateTo(CarRoute.addCar);
                // print(SharedPrefs().userSessionData.token?.token.toString());
              },
              buttonTwo: () {},
              buttonThree: () {},
            ),
            Consumer<HomeProvider>(
              builder: (context, homeModel, child) {
                if (homeModel.isBusy) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (homeModel.isError) {
                  return const Expanded(
                    child: Center(
                      child: Text("Something went wrong"),
                    ),
                  );
                } else {
                  return Expanded(
                    child: homeModel.cars.isNotEmpty
                        ? ListView.builder(
                            itemCount: homeModel.cars.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, position) {
                              Car carItem = homeModel.cars[position];
                              return HomeCarListItem(
                                  onTap: () {
                                    locator<CarroRouter>().navigateToWithArgs(
                                      CarRoute.viewCarPage,
                                      ViewCarPageArgs(
                                        carData: carItem,
                                      ),
                                    );
                                  },
                                  carItem: carItem);
                            },
                          )
                        : const Center(
                            child: Text("No data"),
                          ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
