import 'dart:ffi';

import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Function() onTap;
  final String buttonText;
  const RoundedButton({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.dp_50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
            CarroColors.getColor(context, CarroColors.iconColor),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            CarroColors.getColor(context, CarroColors.list_item_color),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.dp_12),
              //side: const BorderSide(color: Colors.red),
            ),
          ),
        ),
        child: Text(
          buttonText,
          style: CarroTextStyles.medium_label_bold,
        ),
      ),
    );
  }
}
