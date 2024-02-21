import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/widget/inverted_border_radius.dart';
import 'package:carro_flutter_app/modules/authentication/register/view_model/register_model.dart';
import 'package:flutter/material.dart';

class RegisterProgressBarWidget extends StatefulWidget {
  final RegisterProvider homeModel;

  const RegisterProgressBarWidget({super.key, required this.homeModel});

  @override
  State<RegisterProgressBarWidget> createState() =>
      _RegisterProgressBarWidgetState();
}

class _RegisterProgressBarWidgetState extends State<RegisterProgressBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            // margin: const EdgeInsets.symmetric(
            //     horizontal: Dimensions.dp_5),
            height: Dimensions.dp_5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF00EFC2),
                  Color(0xFF6D9AD6),
                  Color(0xFF831AFF),
                  Color(0xFF8222FF),
                  Color(0xFFB72FD5),
                  Color(0xFFD93FB4),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    height: Dimensions.dp_5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.dp_16),
                      color: widget.homeModel.page1Progress
                          ? Colors.transparent
                          : CarroColors.getColor(
                              context, CarroColors.textInputColor),
                    ),
                  ),
                ),
                Container(
                  width: Dimensions.dp_10,
                  color: CarroColors.getColor(
                      context, CarroColors.scaffoldBackgroundColor),
                ),
                Expanded(
                  child: Container(
                    height: Dimensions.dp_5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.dp_16),
                      color: widget.homeModel.page2Progress
                          ? Colors.transparent
                          : CarroColors.getColor(
                              context, CarroColors.textInputColor),
                    ),
                  ),
                ),
                Container(
                  width: Dimensions.dp_10,
                  color: CarroColors.getColor(
                      context, CarroColors.scaffoldBackgroundColor),
                ),
                Expanded(
                  child: Container(
                    height: Dimensions.dp_5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.dp_16),
                      color: widget.homeModel.page3Progress
                          ? Colors.transparent
                          : CarroColors.getColor(
                              context, CarroColors.textInputColor),
                    ),
                  ),
                ),
                Container(
                  width: Dimensions.dp_10,
                  color: CarroColors.getColor(
                      context, CarroColors.scaffoldBackgroundColor),
                ),
                Expanded(
                  child: Container(
                    height: Dimensions.dp_5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.dp_16),
                      color: widget.homeModel.page4Progress
                          ? Colors.transparent
                          : CarroColors.getColor(
                              context, CarroColors.textInputColor),
                    ),
                  ),
                ),
                Container(
                  width: Dimensions.dp_10,
                  color: CarroColors.getColor(
                      context, CarroColors.scaffoldBackgroundColor),
                ),
                // ClipPath(
                //   clipper:
                //       const CustomCornerClipPath(cornerR: Dimensions.dp_16),
                //   child: Container(
                //     width: Dimensions.dp_10,
                //     color: CarroColors.getColor(
                //         context, CarroColors.scaffoldBackgroundColor),
                //   ),
                // ),
                Expanded(
                  child: Container(
                    height: Dimensions.dp_5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: widget.homeModel.page5Progress
                          ? Colors.transparent
                          : CarroColors.getColor(
                              context, CarroColors.textInputColor),
                    ),
                  ),
                ),
                Container(
                  width: Dimensions.dp_10,
                  color: CarroColors.getColor(
                      context, CarroColors.scaffoldBackgroundColor),
                ),
                Expanded(
                  child: Container(
                    height: Dimensions.dp_5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: widget.homeModel.page6Progress
                          ? Colors.transparent
                          : CarroColors.getColor(
                              context, CarroColors.textInputColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
