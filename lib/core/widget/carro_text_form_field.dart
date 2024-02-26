import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CarroTextFormField extends StatelessWidget {
  final double topGapHeight;
  final double bottomGapHeight;
  final TextEditingController controller;
  final Function(String) onChanged;
  final String hintText;
  final String? errorMessage;
  final TextInputType textInputType;
  final List<TextInputFormatter>? textInputFormatter;
  final String? initialValue;

  const CarroTextFormField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.hintText,
    required this.topGapHeight,
    required this.bottomGapHeight,
    this.errorMessage,
    required this.textInputType,
    this.textInputFormatter,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: topGapHeight),
        TextFormField(
          initialValue: initialValue,
          style: CarroTextStyles.normal_text_bold,
          controller: controller,
          keyboardType: textInputType,
          inputFormatters: textInputFormatter,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: CarroTextStyles.large_item_text.copyWith(
              color: CarroColors.getColor(context, CarroColors.textInputColor),
            ),
          ),
          onChanged: onChanged,
        ),
        errorMessage == null
            ? const SizedBox.shrink()
            : Container(
                padding: const EdgeInsets.only(
                    left: Dimensions.dp_5, top: Dimensions.dp_5),
                child: Text(
                  errorMessage ?? "",
                  style: CarroTextStyles.medium_item_text.copyWith(
                    color: CarroColors.getColor(
                      context,
                      CarroColors.fail,
                    ),
                  ),
                ),
              ),
        SizedBox(height: bottomGapHeight),
      ],
    );
  }
}
