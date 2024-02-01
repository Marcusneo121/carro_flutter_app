import 'package:carro_flutter_app/core/controller/auth_controller.dart';
import 'package:carro_flutter_app/core/provider/view_model/theme_provider.dart';
import 'package:carro_flutter_app/core/route/route_index.dart';
import 'package:carro_flutter_app/core/route/route_manager.dart';
import 'package:carro_flutter_app/core/theme/colors.dart';
import 'package:carro_flutter_app/core/theme/dimens.dart';
import 'package:carro_flutter_app/core/theme/styles.dart';
import 'package:carro_flutter_app/core/widget/rounded_button.dart';
import 'package:carro_flutter_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _hideText = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.dp_40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 90,
                  child: Theme.of(context).colorScheme.brightness ==
                          Brightness.light
                      ? Image.asset('images/carros_white.png')
                      : Image.asset('images/carros.png'),
                ),
                const SizedBox(
                  height: Dimensions.dp_28,
                ),
                TextFormField(
                  style: CarroTextStyles.normal_text_bold,
                  controller: usernameController,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle: CarroTextStyles.normal_text_bold.copyWith(
                      color: CarroColors.getColor(
                          context, CarroColors.textInputColor),
                    ),
                  ),
                  onChanged: (value) {
                    //Do something with the user input.
                    //email = value;
                  },
                ),
                const SizedBox(
                  height: Dimensions.dp_16,
                ),
                TextFormField(
                  obscureText: _hideText,
                  style: CarroTextStyles.normal_text_bold,
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: CarroTextStyles.normal_text_bold.copyWith(
                        color: CarroColors.getColor(
                            context, CarroColors.textInputColor),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _hideText = !_hideText;
                          });
                        },
                        child: _hideText == true
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
                  height: Dimensions.dp_36,
                ),
                RoundedButton(
                  buttonText: 'Login',
                  onTap: () {
                    AuthController(context: context).login(
                        usernameController.text, passwordController.text);
                  },
                ),
                // const Text(
                //   "Don't have an account?",
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontWeight: FontWeight.w600,
                //     fontFamily: 'Poppins',
                //     fontSize: 16.0,
                //   ),
                // ),
                // TextButton(
                //   onPressed: () {
                //     //Get.toNamed('/login/registration');
                //     //Navigator.pushNamed(context, Registration.id);
                //   },
                //   child: const Text(
                //     'Register here',
                //     style: TextStyle(
                //       color: Color(0xFF7879F1),
                //       fontWeight: FontWeight.w600,
                //       fontFamily: 'Poppins',
                //       fontSize: 17.0,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
