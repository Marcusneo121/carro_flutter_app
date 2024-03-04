import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CarroCustomPullDownRefreshHeader extends StatefulWidget {
  const CarroCustomPullDownRefreshHeader({super.key});

  @override
  State<CarroCustomPullDownRefreshHeader> createState() =>
      _CarroCustomPullDownRefreshHeaderState();
}

class _CarroCustomPullDownRefreshHeaderState
    extends State<CarroCustomPullDownRefreshHeader> {
  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      builder: (BuildContext context, RefreshStatus? mode) {
        Widget body;
        if (mode == RefreshStatus.idle) {
          body = const Icon(
            Icons.keyboard_double_arrow_down_rounded,
            color: CarroColors.primayColor,
            size: Dimensions.dp_30,
          );
        }
        // else if (mode == RefreshStatus.refreshing) {
        //   body = const SizedBox(
        //     width: Dimensions.dp_20,
        //     height: Dimensions.dp_20,
        //     child: CircularProgressIndicator(),
        //   );
        // } else if (mode == RefreshStatus.failed) {
        //   body = const Text("Refresh failed");
        // }
        else if (mode == RefreshStatus.completed) {
          body = const Icon(
            Icons.check_circle_outline_rounded,
            color: CarroColors.primayColor,
            size: Dimensions.dp_30,
          );
        } else if (mode == RefreshStatus.canRefresh) {
          body = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.keyboard_double_arrow_up_rounded,
                color: CarroColors.primayColor,
                size: Dimensions.dp_30,
              ),
              SizedBox(width: Dimensions.dp_10),
              Text(
                "Release to refresh",
                style: TextStyle(color: CarroColors.textInputColor),
              ),
            ],
          );
        } else {
          body = const SizedBox.shrink();
        }
        return Center(child: body);
      },
    );
  }
}
