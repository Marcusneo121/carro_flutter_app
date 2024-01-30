import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/modules/settings/ui/widgets/setting_list_item.dart';
import 'package:flutter/material.dart';

class SettingCategoryList extends StatelessWidget {
  final String? categoryTitle;
  final List<SettingListItem> settingList;

  const SettingCategoryList({
    super.key,
    this.categoryTitle,
    required this.settingList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        categoryTitle != null
            ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  categoryTitle?.toUpperCase() ?? "",
                  style: CarroTextStyles.medium_item_text.copyWith(
                    color: CarroColors.getColor(
                      context,
                      CarroColors.iconColor
                    ),
                  ),
                  // style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  //       color: Theme.of(context).colorScheme.onBackground,
                  //     ),
                ),
              )
            : const SizedBox(),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          // padding: EdgeInsets.only(top: 10.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: CarroColors.getColor(context, CarroColors.list_item_color),
            // color: Theme.of(context).colorScheme.secondary,
            // color: const Color(0xFF272036),
          ),
          child: Column(
            children: settingList,
          ),
        ),
      ],
    );
  }
}
