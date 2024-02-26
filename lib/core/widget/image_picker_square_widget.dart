import 'dart:io';

import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerSquareWidget extends StatefulWidget {
  late XFile? imageFile;
  final Function() onTap;
  final Function() onRemoveSelectedImage;

  ImagePickerSquareWidget({
    super.key,
    required this.onTap,
    required this.onRemoveSelectedImage,
    this.imageFile,
  });

  @override
  State<ImagePickerSquareWidget> createState() =>
      _ImagePickerSquareWidgetState();
}

class _ImagePickerSquareWidgetState extends State<ImagePickerSquareWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: widget.imageFile != null
          ? Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    right: Dimensions.dp_5,
                    top: Dimensions.dp_5,
                    bottom: Dimensions.dp_5,
                    left: Dimensions.dp_5,
                  ),
                  child: ClipRRect(
                    borderRadius: CarroBorderRadius.circular_10,
                    child: Image.file(
                      File(widget.imageFile?.path ?? ""),
                      fit: BoxFit.fill,
                      width: Dimensions.dp_50,
                      height: Dimensions.dp_50,
                    ),
                  ),
                ),
                Positioned(
                  right: 0.0,
                  top: 0.0,
                  child: InkWell(
                    onTap: widget.onRemoveSelectedImage,
                    child: ClipRRect(
                      borderRadius: CarroBorderRadius.circular_10,
                      child: Container(
                        width: Dimensions.dp_15,
                        height: Dimensions.dp_15,
                        color: CarroColors.getColor(
                            context, CarroColors.primayColor),
                        child: const Center(
                          child: Icon(
                            Icons.close_rounded,
                            size: Dimensions.dp_14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Container(
              width: Dimensions.dp_50,
              height: Dimensions.dp_50,
              margin: const EdgeInsets.only(
                right: Dimensions.dp_5,
                top: Dimensions.dp_5,
                bottom: Dimensions.dp_5,
                left: Dimensions.dp_5,
              ),
              decoration: BoxDecoration(
                color:
                    CarroColors.getColor(context, CarroColors.list_item_color),
                borderRadius: CarroBorderRadius.circular_12,
              ),
              child: Center(
                child: Icon(
                  Icons.add_rounded,
                  color: CarroColors.getColor(
                    context,
                    CarroColors.primayColor,
                  ),
                ),
              ),
            ),
    );
  }
}
