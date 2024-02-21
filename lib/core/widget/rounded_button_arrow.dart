import 'dart:ffi';

import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:flutter/material.dart';

class RoundedArrowButton extends StatelessWidget {
  final Function() onTap;
  final String buttonText;
  final bool? removeButtonText;
  final bool? fullWidthButton;
  const RoundedArrowButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.removeButtonText = false,
    this.fullWidthButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.dp_50,
      width: fullWidthButton == true ? double.infinity : null,
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            removeButtonText == true
                ? const SizedBox.shrink()
                : Text(
                    buttonText,
                    style: CarroTextStyles.medium_label_bold,
                  ),
            const SizedBox(width: Dimensions.dp_5),
            const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
