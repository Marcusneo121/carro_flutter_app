import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class RegisterTopBarWidget extends StatelessWidget {
  final String titleAppBar;
  final IconData? icon;
  final Function()? onTap;

  const RegisterTopBarWidget({
    super.key,
    required this.titleAppBar,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(top: Dimensions.dp_18, left: Dimensions.dp_9),
      child: Row(
        children: [
          Bounceable(
            scaleFactor: 0.75,
            onTap: onTap ??
                () {
                  locator<CarroRouter>().pop();
                },
            child: CircleAvatar(
              backgroundColor: CarroColors.getColor(
                  context, CarroColors.iconBackgroundColor),
              radius: Dimensions.dp_24,
              child: Icon(
                icon ?? Icons.arrow_back_ios_new_rounded,
                color: CarroColors.getColor(context, CarroColors.iconColor),
              ),
            ),
          ),
          const SizedBox(width: Dimensions.dp_8),
          Text(
            titleAppBar,
            style: CarroTextStyles.medium_title_bold.copyWith(
              color: CarroColors.getColor(
                context,
                CarroColors.iconColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
