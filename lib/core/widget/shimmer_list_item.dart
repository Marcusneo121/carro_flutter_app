import 'package:carro_flutter_app/core/provider/view_model/theme_provider.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListItem extends StatelessWidget {
  const ShimmerListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Dimensions.dp_230,
      child: Shimmer.fromColors(
        baseColor: CarroColors.getColor(context, CarroColors.list_item_color),
        highlightColor: const Color.fromARGB(255, 56, 46, 77),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: context.read<ThemeProvider>().getTheme == ThemeMode.dark
                    ? const Color.fromARGB(0, 198, 184, 184)
                    : Colors.grey,
                offset: const Offset(0.0, 0.8), //(x,y)
                blurRadius: 3.0,
              ),
            ],
            color: Theme.of(context).colorScheme.brightness == Brightness.dark
                ? Theme.of(context).colorScheme.secondary
                : Colors.white,
          ),
        ),
      ),
    );
  }
}
