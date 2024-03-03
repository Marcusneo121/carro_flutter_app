import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/core/widget/rounded_button.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/widgets/register_top_bar_widget.dart';
import 'package:carro_flutter_app/modules/home/entity/car.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../view_model/view_car_model.dart';

class ViewCarPageArgs {
  ViewCarPageArgs({required this.carData});
  final Car carData;
}

class ViewCarPage extends StatefulWidget {
  final ViewCarPageArgs args;

  const ViewCarPage({super.key, required this.args});

  @override
  State<ViewCarPage> createState() => _ViewCarPageState();
}

class _ViewCarPageState extends State<ViewCarPage> {
  ViewCarModel? model;

  @override
  void initState() {
    super.initState();
    model = ViewCarModel(car: widget.args.carData);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => model,
      child: Scaffold(
        bottomNavigationBar: Consumer<ViewCarModel>(
          builder: (context, viewCarModel, child) {
            return Container(
              // padding: const EdgeInsets.symmetric(
              //     vertical: Dimensions.dp_15, horizontal: Dimensions.dp_30),
              margin: const EdgeInsets.only(
                left: Dimensions.dp_30,
                right: Dimensions.dp_30,
                bottom: Dimensions.dp_40,
                top: Dimensions.dp_10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Dimensions.dp_60 + Dimensions.dp_5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "RM ${widget.args.carData.price ?? "-"}",
                          style: CarroTextStyles.large_title_bold,
                        ),
                        Text(
                          "per day",
                          style: CarroTextStyles.normal_text.copyWith(
                            color: CarroColors.getColor(
                              context,
                              CarroColors.textInputColor,
                            ),
                          ),
                        ),
                        Text(
                          "* Insurance included",
                          style: CarroTextStyles.medium_item_text.copyWith(
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
                    width: Dimensions.dp_184,
                    child: ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() {});
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                          CarroColors.getColor(context, CarroColors.iconColor),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          CarroColors.getColor(
                              context, CarroColors.list_item_color),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.dp_12),
                            //side: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Book now",
                        style: CarroTextStyles.medium_label_bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        body: SafeArea(
          child:
              //Continue with Consumer to get loading
              CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                scrolledUnderElevation: 0.0,
                leadingWidth: Dimensions.dp_290,
                leading: RegisterTopBarWidget(
                  titleAppBar: '',
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    locator<CarroRouter>().pop();
                  },
                ),
              ),
              Consumer<ViewCarModel>(
                builder: (context, viewCarModel, child) {
                  if (viewCarModel.isBusy) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (viewCarModel.isError) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: Text('Something went wrong'),
                      ),
                    );
                  } else if (viewCarModel.isIdle) {
                    return SliverFillRemaining(
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
                              items: viewCarModel.getImageList.map((img) {
                                if (img != "-") {
                                  return CachedNetworkImage(
                                    imageUrl: img,
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        margin: const EdgeInsets.only(
                                          left: Dimensions.dp_25,
                                          right: Dimensions.dp_25,
                                          top: Dimensions.dp_15,
                                          bottom: Dimensions.dp_15,
                                        ),
                                        height: Dimensions.dp_280 +
                                            Dimensions.dp_40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
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
                                          borderRadius:
                                              BorderRadius.circular(14),
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
                                // top: Dimensions.dp_10,
                                // bottom: Dimensions.dp_10,
                                left: Dimensions.dp_20,
                                right: Dimensions.dp_20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: Dimensions.dp_10,
                                      right: Dimensions.dp_10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.args?.carData.carName
                                                  .toString() ??
                                              "-",
                                          style:
                                              CarroTextStyles.medium_title_bold,
                                        ),
                                        const SizedBox(
                                            height: Dimensions.dp_10),
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
                                            widget.args?.carData.carPlate
                                                    .toString() ??
                                                "-",
                                            style: CarroTextStyles.normal_text
                                                .copyWith(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: Dimensions.dp_20),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: Dimensions.dp_20,
                                      horizontal: Dimensions.dp_20,
                                    ),
                                    decoration: BoxDecoration(
                                      color: CarroColors.getColor(
                                        context,
                                        CarroColors
                                            .carViewListItemBackgroundColor,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.dp_18),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Location",
                                          style: CarroTextStyles.large_label,
                                        ),
                                        const SizedBox(
                                            height: Dimensions.dp_10),
                                        Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: Dimensions.dp_15,
                                                horizontal: Dimensions.dp_10),
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(
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
                                                  color:
                                                      CarroColors.primayColor,
                                                ),
                                                const SizedBox(
                                                    width: Dimensions.dp_10),
                                                Expanded(
                                                  child: Text(
                                                    widget.args?.carData
                                                            .location
                                                            .toString() ??
                                                        "-",
                                                    style: CarroTextStyles
                                                        .normal_text_bold
                                                        .copyWith(
                                                      color:
                                                          CarroColors.getColor(
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
                                    padding: const EdgeInsets.symmetric(
                                      vertical: Dimensions.dp_20,
                                      horizontal: Dimensions.dp_20,
                                    ),
                                    decoration: BoxDecoration(
                                      color: CarroColors.getColor(
                                        context,
                                        CarroColors
                                            .carViewListItemBackgroundColor,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.dp_18),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Car Description",
                                          style: CarroTextStyles.large_label,
                                        ),
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
                                                    "Year made : ",
                                                    style: CarroTextStyles
                                                        .large_item_text_bold,
                                                  ),
                                                  const SizedBox(
                                                      width: Dimensions.dp_5),
                                                  Text(
                                                    widget.args?.carData
                                                            .yearMade ??
                                                        "-",
                                                    style: CarroTextStyles
                                                        .large_item_text
                                                        .copyWith(
                                                      color:
                                                          CarroColors.getColor(
                                                        context,
                                                        CarroColors
                                                            .registerHeadlineColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                  height: Dimensions.dp_5),
                                              Row(
                                                children: [
                                                  Text(
                                                    (widget.args?.carData
                                                                .isElectric ??
                                                            false)
                                                        ? "Power Output (kW): "
                                                        : "Engine Capacity (CC): ",
                                                    style: CarroTextStyles
                                                        .large_item_text_bold,
                                                  ),
                                                  const SizedBox(
                                                      width: Dimensions.dp_5),
                                                  Text(
                                                    "${widget.args?.carData.engineCapacity}",
                                                    style: CarroTextStyles
                                                        .large_item_text
                                                        .copyWith(
                                                      color:
                                                          CarroColors.getColor(
                                                        context,
                                                        CarroColors
                                                            .registerHeadlineColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                  height: Dimensions.dp_5),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Color : ",
                                                    style: CarroTextStyles
                                                        .large_item_text_bold,
                                                  ),
                                                  const SizedBox(
                                                      width: Dimensions.dp_5),
                                                  Text(
                                                    widget.args?.carData.color
                                                            .toString() ??
                                                        "-",
                                                    style: CarroTextStyles
                                                        .large_item_text
                                                        .copyWith(
                                                      color:
                                                          CarroColors.getColor(
                                                        context,
                                                        CarroColors
                                                            .registerHeadlineColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                  height: Dimensions.dp_5),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Seat Number : ",
                                                    style: CarroTextStyles
                                                        .large_item_text_bold,
                                                  ),
                                                  const SizedBox(
                                                      width: Dimensions.dp_5),
                                                  Text(
                                                    widget.args?.carData.seat
                                                            .toString() ??
                                                        "-",
                                                    style: CarroTextStyles
                                                        .large_item_text
                                                        .copyWith(
                                                      color:
                                                          CarroColors.getColor(
                                                        context,
                                                        CarroColors
                                                            .registerHeadlineColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
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
                                        CarroColors
                                            .carViewListItemBackgroundColor,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.dp_18),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              "Available from : ",
                                              style: CarroTextStyles
                                                  .large_item_text_bold,
                                            ),
                                            Text(
                                              widget.args?.carData
                                                          .availableFromDate ==
                                                      null
                                                  ? "-"
                                                  : DateFormat(
                                                          'MM-dd-yyyy  hh:mm a')
                                                      .format(DateTime.parse(widget
                                                              .args
                                                              ?.carData
                                                              .availableFromDate ??
                                                          "-"))
                                                      .toString(),
                                              style: CarroTextStyles
                                                  .large_item_text,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: Dimensions.dp_5),
                                        Row(
                                          children: [
                                            const Text(
                                              "Available until : ",
                                              style: CarroTextStyles
                                                  .large_item_text_bold,
                                            ),
                                            Text(
                                              DateFormat('MM-dd-yyyy  hh:mm a')
                                                  .format(DateTime.parse(widget
                                                          .args
                                                          ?.carData
                                                          .availableToDate ??
                                                      "-"))
                                                  .toString(),
                                              style: CarroTextStyles
                                                  .large_item_text,
                                            ),
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
                                        CarroColors
                                            .carViewListItemBackgroundColor,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.dp_18),
                                    ),
                                    child: Row(
                                      children: [
                                        viewCarModel.getOwnerData?.data
                                                        ?.profileImage ==
                                                    null ||
                                                viewCarModel.getOwnerData?.data
                                                        ?.profileImage ==
                                                    "-"
                                            ? const CircleAvatar(
                                                radius: Dimensions.dp_30,
                                                child: Icon(
                                                  Icons.person_outlined,
                                                  size: Dimensions.dp_30,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            : CachedNetworkImage(
                                                imageUrl: viewCarModel
                                                        .getOwnerData
                                                        ?.data
                                                        ?.profileImage ??
                                                    "-",
                                                imageBuilder:
                                                    (context, imageProvider) {
                                                  return CircleAvatar(
                                                    radius: Dimensions.dp_30,
                                                    backgroundImage:
                                                        imageProvider,
                                                  );
                                                },
                                                progressIndicatorBuilder:
                                                    (context, url, progress) {
                                                  return Container(
                                                    height: 145.0,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14),
                                                      color: Colors.grey
                                                          .withOpacity(0.1),
                                                    ),
                                                  );
                                                },
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                        const SizedBox(width: Dimensions.dp_15),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${viewCarModel.getOwnerData?.data?.firstName ?? ""} ${viewCarModel.getOwnerData?.data?.lastName ?? ""}",
                                            ),
                                            Text(
                                              viewCarModel.getOwnerData?.data
                                                      ?.phoneNumber ??
                                                  "-",
                                              style: CarroTextStyles
                                                  .large_item_text,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const SliverFillRemaining(
                      child: Center(
                        child: Text('Something went wrong'),
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
}
