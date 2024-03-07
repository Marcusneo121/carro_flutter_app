import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class HomeTopWidget extends StatelessWidget {
  final Function() buttonOne;
  final Function() buttonTwo;
  final Function() buttonThree;

  const HomeTopWidget({
    super.key,
    required this.buttonOne,
    required this.buttonTwo,
    required this.buttonThree,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.dp_60,
      color: CarroColors.getColor(context, CarroColors.scaffoldBackgroundColor),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.dp_16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Bounceable(
            scaleFactor: 0.75,
            onTap: buttonOne,
            child: CircleAvatar(
              backgroundColor: CarroColors.getColor(
                  context, CarroColors.iconBackgroundColor),
              radius: Dimensions.dp_24,
              child: Icon(
                Icons.apps_rounded,
                color: CarroColors.getColor(context, CarroColors.iconColor),
              ),
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: buttonTwo,
                child: Icon(
                  Icons.notifications_rounded,
                  size: Dimensions.dp_25 + Dimensions.dp_1,
                  color: CarroColors.getColor(context, CarroColors.iconColor),
                ),
              ),
              const SizedBox(
                width: Dimensions.dp_25,
              ),
              InkWell(
                onTap: buttonThree,
                child: Icon(
                  Icons.search_rounded,
                  size: Dimensions.dp_25 + Dimensions.dp_2,
                  color: CarroColors.getColor(context, CarroColors.iconColor),
                ),
              ),
              const SizedBox(
                width: Dimensions.dp_5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
