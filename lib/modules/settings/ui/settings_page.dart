import 'package:cached_network_image/cached_network_image.dart';
import 'package:carro_flutter_app/core/controller/auth_controller.dart';
import 'package:carro_flutter_app/core/provider/view_model/theme_provider.dart';
import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/core/utils/shared_prefs.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/settings/entity/post.dart';
import 'package:carro_flutter_app/modules/settings/ui/widgets/setting_category_list.dart';
import 'package:carro_flutter_app/modules/settings/ui/widgets/setting_item_testing.dart';
import 'package:carro_flutter_app/modules/settings/ui/widgets/setting_list_item.dart';
import 'package:carro_flutter_app/modules/settings/view_model/settings_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    // final SettingsProvider settingsModel =
    //     Provider.of<SettingsProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    child: Icon(
                      Icons.person_outlined,
                      size: Dimensions.dp_40,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Marcus Neo',
                        style: themeData.textTheme.headlineSmall?.copyWith(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 3),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Edit profile',
                          style: themeData.textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF7620FF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: OutlinedButton(
                onPressed: () {
                  AuthController(context: context).logout();
                },
                child: Text(
                  'Log out',
                  style: CarroTextStyles.normal_text.copyWith(
                    color: CarroColors.getColor(context, CarroColors.iconColor),
                  ),
                ),
              ),
            ),
            SettingCategoryList(
              settingList: [
                SettingListItem(
                  itemName: 'Dark Mode',
                  onTap: () {},
                  disableBottomDivider: true,
                  rightWidget: CupertinoSwitch(
                    value:
                        context.read<ThemeProvider>().getTheme == ThemeMode.dark
                            ? true
                            : false,
                    activeColor: const Color(0xFF7620FF),
                    onChanged: (bool value) {
                      setState(() {});
                      context.read<ThemeProvider>().toggleTheme();
                    },
                  ),
                ),
              ],
            ),
            SettingCategoryList(
              categoryTitle: 'About',
              settingList: [
                SettingListItem(
                  itemName: 'Get help',
                  onTap: () {
                    // context.read<ThemeProvider>().setSelectedIndex(1);
                  },
                ),
                SettingListItem(
                  itemName: 'App Info',
                  onTap: () {
                    print(SharedPrefs().isDarkThemePref);
                    //locator<CarroRouter>().navigateTo(CommonRoute.loginPage);
                  },
                  disableBottomDivider: true,
                ),
              ],
            ),
            // Container(
            //   padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         "Dark Mode",
            //         style: themeData.textTheme.titleMedium,
            //       ),
            //       CupertinoSwitch(
            //         value:
            //             context.read<ThemeProvider>().getTheme == ThemeMode.dark
            //                 ? true
            //                 : false,
            //         activeColor: const Color(0xFF7620FF),
            //         onChanged: (bool value) {
            //           context.read<ThemeProvider>().toggleTheme();
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   margin: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 12.sp),
            //   // padding: EdgeInsets.only(top: 10.sp),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(12),
            //     color: const Color(0xFF272036),
            //   ),
            //   child: Column(
            //     children: [
            //       SettingListItem(
            //         itemName: 'GXsecure',
            //         onTap: () {},
            //       ),
            //       SettingListItem(
            //         itemName: 'Change Limit',
            //         onTap: () {},
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   padding: EdgeInsets.all(10.sp),
            //   child: Text(
            //     'Settings',
            //     style: themeData
            //         .textTheme
            //         .headlineMedium
            //         ?.copyWith(fontWeight: FontWeight.w600),
            //   ),
            // ),
            // Container(
            //   padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         "Dark Mode",
            //         style: themeData.textTheme.titleMedium,
            //       ),
            //       CupertinoSwitch(
            //         value:
            //             context.read<ThemeProvider>().getTheme == ThemeMode.dark
            //                 ? true
            //                 : false,
            //         activeColor: const Color(0xFF7620FF),
            //         onChanged: (bool value) {
            //           context.read<ThemeProvider>().toggleTheme();
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            // Expanded(
            //   child: Container(),
            // ),
            // Consumer<SettingsProvider>(
            //   builder: (context, settingsModel, child) {
            //     if (settingsModel.isBusy) {
            //       return const Expanded(
            //         child: Center(
            //           child: CircularProgressIndicator(),
            //         ),
            //       );
            //     }
            //     if (settingsModel.isError) {
            //       return const Expanded(
            //         child: Center(
            //           child: Text("Something went wrong!"),
            //         ),
            //       );
            //     }
            //     return Expanded(
            //       child: settingsModel.post.isNotEmpty
            //           ? ListView.builder(
            //               itemCount: settingsModel.post.length,
            //               physics: const AlwaysScrollableScrollPhysics(),
            //               itemBuilder: (context, position) {
            //                 Post postItem = settingsModel.post[position];
            //                 return SettingItemWidget(postItem: postItem);
            //               },
            //             )
            //           : const Center(
            //               child: Text("No data"),
            //             ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
