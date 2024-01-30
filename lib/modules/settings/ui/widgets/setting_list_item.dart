import 'package:carro_flutter_app/core/provider/view_model/theme_provider.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingListItem extends StatelessWidget {
  final String itemName;
  final Widget? rightWidget;
  final VoidCallback onTap;
  final bool? disableBottomDivider;

  const SettingListItem({
    super.key,
    required this.itemName,
    this.rightWidget,
    required this.onTap,
    this.disableBottomDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 12,
              bottom: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  itemName,
                  // style: Theme.of(context).textTheme.bodyLarge,
                  style: CarroTextStyles.large_normal_text_bold,
                ),
                rightWidget ??
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ],
            ),
          ),
          disableBottomDivider == false
              ? Divider(
                  height: 0,
                  indent: 0,
                  thickness: Theme.of(context).colorScheme.brightness ==
                          Brightness.light
                      ? 0.3
                      : 0.5,
                  color: Theme.of(context).colorScheme.onSurface,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
