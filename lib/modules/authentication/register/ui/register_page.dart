import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:carro_flutter_app/modules/authentication/register/ui/widgets/register_top_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController address3Controller = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  bool _hidePassword1 = true;
  int selectedAge = 0;
  DateTime selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   scrolledUnderElevation: 0.0,
      //   foregroundColor: CarroColors.getColor(context, CarroColors.iconColor),
      //   title: Text(
      //     'Register',
      //     style: CarroTextStyles.medium_label_bold.copyWith(
      //       color: CarroColors.getColor(context, CarroColors.iconColor),
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              pinned: true,
              scrolledUnderElevation: 0.0,
              leadingWidth: Dimensions.dp_290,
              leading: RegisterTopBarWidget(),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                padding: const EdgeInsets.only(
                  top: Dimensions.dp_10,
                  left: Dimensions.dp_10,
                ),
                child: Column(
                  children: [
                    // const RegisterTopBarWidget(),
                    const SizedBox(height: Dimensions.dp_20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.dp_40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.only(left: Dimensions.dp_5),
                            child: Text(
                              'Username',
                              style: CarroTextStyles.normal_text_bold.copyWith(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.textInputColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.dp_5),
                          TextFormField(
                            style: CarroTextStyles.normal_text_bold,
                            controller: usernameController,
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              // hintText: 'Username',
                              hintStyle:
                                  CarroTextStyles.normal_text_bold.copyWith(
                                color: CarroColors.getColor(
                                    context, CarroColors.textInputColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.dp_10,
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(left: Dimensions.dp_5),
                            child: Text(
                              'Email',
                              style: CarroTextStyles.normal_text_bold.copyWith(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.textInputColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.dp_5),
                          TextFormField(
                            style: CarroTextStyles.normal_text_bold,
                            controller: emailController,
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              // hintText: 'Username',
                              hintStyle:
                                  CarroTextStyles.normal_text_bold.copyWith(
                                color: CarroColors.getColor(
                                    context, CarroColors.textInputColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.dp_10,
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(left: Dimensions.dp_5),
                            child: Text(
                              'Password',
                              style: CarroTextStyles.normal_text_bold.copyWith(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.textInputColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.dp_5),
                          TextFormField(
                            obscureText: _hidePassword1,
                            style: CarroTextStyles.normal_text_bold,
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                                // hintText: 'Password',
                                hintStyle:
                                    CarroTextStyles.normal_text_bold.copyWith(
                                  color: CarroColors.getColor(
                                      context, CarroColors.textInputColor),
                                ),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _hidePassword1 = !_hidePassword1;
                                    });
                                  },
                                  child: _hidePassword1 == true
                                      ? Icon(
                                          Icons.visibility_off_rounded,
                                          color: CarroColors.getColor(
                                            context,
                                            CarroColors.iconColor,
                                          ),
                                        )
                                      : Icon(
                                          Icons.visibility_rounded,
                                          color: CarroColors.getColor(
                                            context,
                                            CarroColors.iconColor,
                                          ),
                                        ),
                                )),
                            onChanged: (value) {
                              //Do something with the user input.
                              //email = value;
                            },
                          ),
                          const SizedBox(
                            height: Dimensions.dp_10,
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(left: Dimensions.dp_5),
                            child: Text(
                              'Confirm password',
                              style: CarroTextStyles.normal_text_bold.copyWith(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.textInputColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.dp_5),
                          TextFormField(
                            obscureText: _hidePassword1,
                            style: CarroTextStyles.normal_text_bold,
                            controller: confirmPasswordController,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                                // hintText: 'Password',
                                hintStyle:
                                    CarroTextStyles.normal_text_bold.copyWith(
                                  color: CarroColors.getColor(
                                      context, CarroColors.textInputColor),
                                ),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _hidePassword1 = !_hidePassword1;
                                    });
                                  },
                                  child: _hidePassword1 == true
                                      ? Icon(
                                          Icons.visibility_off_rounded,
                                          color: CarroColors.getColor(
                                            context,
                                            CarroColors.iconColor,
                                          ),
                                        )
                                      : Icon(
                                          Icons.visibility_rounded,
                                          color: CarroColors.getColor(
                                            context,
                                            CarroColors.iconColor,
                                          ),
                                        ),
                                )),
                            onChanged: (value) {
                              //Do something with the user input.
                              //email = value;
                            },
                          ),
                          Divider(
                            height: Dimensions.dp_100,
                            thickness: 1,
                            indent: Dimensions.dp_40,
                            endIndent: Dimensions.dp_40,
                            color: CarroColors.getColor(
                                context, CarroColors.textInputColor),
                          ),
                          Text(
                            'Biography',
                            style: CarroTextStyles.large_label_bold.copyWith(
                              color: CarroColors.getColor(
                                context,
                                CarroColors.iconColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.dp_20),
                          Container(
                            padding:
                                const EdgeInsets.only(left: Dimensions.dp_5),
                            child: Text(
                              'First Name',
                              style: CarroTextStyles.normal_text_bold.copyWith(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.textInputColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.dp_5),
                          TextFormField(
                            style: CarroTextStyles.normal_text_bold,
                            controller: firstNameController,
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              // hintText: 'Username',
                              hintStyle:
                                  CarroTextStyles.normal_text_bold.copyWith(
                                color: CarroColors.getColor(
                                    context, CarroColors.textInputColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.dp_10,
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(left: Dimensions.dp_5),
                            child: Text(
                              'Last Name',
                              style: CarroTextStyles.normal_text_bold.copyWith(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.textInputColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.dp_5),
                          TextFormField(
                            style: CarroTextStyles.normal_text_bold,
                            controller: firstNameController,
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              // hintText: 'Username',
                              hintStyle:
                                  CarroTextStyles.normal_text_bold.copyWith(
                                color: CarroColors.getColor(
                                    context, CarroColors.textInputColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.dp_20,
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(left: Dimensions.dp_5),
                            child: Text(
                              'Address',
                              style: CarroTextStyles.normal_text_bold.copyWith(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.textInputColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.dp_5),
                          TextFormField(
                            style: CarroTextStyles.normal_text_bold,
                            controller: address1Controller,
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              hintText: 'Address 1',
                              hintStyle:
                                  CarroTextStyles.normal_text_bold.copyWith(
                                color: CarroColors.getColor(
                                    context, CarroColors.textInputColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.dp_10,
                          ),
                          TextFormField(
                            style: CarroTextStyles.normal_text_bold,
                            controller: address2Controller,
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              hintText: 'Address 2',
                              hintStyle:
                                  CarroTextStyles.normal_text_bold.copyWith(
                                color: CarroColors.getColor(
                                    context, CarroColors.textInputColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.dp_10,
                          ),
                          TextFormField(
                            style: CarroTextStyles.normal_text_bold,
                            controller: address3Controller,
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              hintText: 'Address 3',
                              hintStyle:
                                  CarroTextStyles.normal_text_bold.copyWith(
                                color: CarroColors.getColor(
                                    context, CarroColors.textInputColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.dp_20,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: Dimensions.dp_5),
                                    child: Text(
                                      'Age',
                                      style: CarroTextStyles.normal_text_bold
                                          .copyWith(
                                        color: CarroColors.getColor(
                                          context,
                                          CarroColors.textInputColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: Dimensions.dp_5),
                                  Bounceable(
                                    onTap: () {
                                      showCupertinoModalPopup(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) =>
                                            CupertinoActionSheet(
                                          actions: [
                                            buildAgeSelector(),
                                          ],
                                          cancelButton:
                                              CupertinoActionSheetAction(
                                            onPressed: () {
                                              setState(() {});
                                              locator<CarroRouter>().pop();
                                            },
                                            child: const Text('Done'),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: Dimensions.dp_48,
                                      width: Dimensions.dp_70,
                                      decoration: BoxDecoration(
                                        color: CarroColors.getColor(context,
                                            CarroColors.iconBackgroundColor),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12.0)),
                                        border: Border.all(
                                            width: Dimensions.dp_3,
                                            color: CarroColors.getColor(context,
                                                CarroColors.list_item_color)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          selectedAge.toString(),
                                          style:
                                              CarroTextStyles.normal_text_bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: Dimensions.dp_20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: Dimensions.dp_5),
                                    child: Text(
                                      'Date of Birth',
                                      style: CarroTextStyles.normal_text_bold
                                          .copyWith(
                                        color: CarroColors.getColor(
                                          context,
                                          CarroColors.textInputColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: Dimensions.dp_5),
                                  Bounceable(
                                    onTap: () {
                                      showCupertinoModalPopup(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) =>
                                            CupertinoActionSheet(
                                          actions: [
                                            buildDateTimePicker(),
                                          ],
                                          cancelButton:
                                              CupertinoActionSheetAction(
                                            onPressed: () {
                                              selectedAge = calculateAge(
                                                  selectedDateTime);
                                              setState(() {});
                                              locator<CarroRouter>().pop();
                                            },
                                            child: const Text('Done'),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: Dimensions.dp_48,
                                      width: Dimensions.dp_150,
                                      decoration: BoxDecoration(
                                        color: CarroColors.getColor(context,
                                            CarroColors.iconBackgroundColor),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12.0)),
                                        border: Border.all(
                                            width: Dimensions.dp_3,
                                            color: CarroColors.getColor(context,
                                                CarroColors.list_item_color)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          DateFormat('MM/dd/yyyy')
                                              .format(selectedDateTime)
                                              .toString(),
                                          style:
                                              CarroTextStyles.normal_text_bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: Dimensions.dp_15,
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(left: Dimensions.dp_5),
                            child: Text(
                              'Phone No.',
                              style: CarroTextStyles.normal_text_bold.copyWith(
                                color: CarroColors.getColor(
                                  context,
                                  CarroColors.textInputColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.dp_5),
                          Row(
                            children: [
                              const SizedBox(width: Dimensions.dp_5),
                              Text(
                                '+60',
                                style:
                                    CarroTextStyles.normal_text_bold.copyWith(
                                  color: CarroColors.getColor(
                                    context,
                                    CarroColors.iconColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: Dimensions.dp_5),
                              Flexible(
                                child: TextFormField(
                                  style: CarroTextStyles.normal_text_bold,
                                  controller: phoneNumberController,
                                  keyboardType: TextInputType.name,
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                      // hintText: 'Username',
                                      hintStyle: CarroTextStyles
                                          .normal_text_bold
                                          .copyWith(
                                        color: CarroColors.getColor(context,
                                            CarroColors.textInputColor),
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          left: Dimensions.dp_10)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: Dimensions.dp_10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDateTimePicker() => SizedBox(
        height: Dimensions.dp_200,
        child: CupertinoDatePicker(
          maximumDate: DateTime.now(),
          initialDateTime: selectedDateTime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) {
            setState(() {
              selectedDateTime = dateTime;
            });
          },
        ),
      );

  Widget buildAgeSelector() => StatefulBuilder(builder: (context, setState) {
        return SizedBox(
          height: Dimensions.dp_200,
          child: NumberPicker(
            haptics: true,
            value: selectedAge,
            minValue: 0,
            maxValue: 100,
            onChanged: (value) {
              print(value);
              selectedAge = value;
              setState(() {});
            },
            selectedTextStyle: CarroTextStyles.large_title_bold.copyWith(
              color: const Color(0xFF7620FF),
            ),
          ),
        );
      });
}

int calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}
