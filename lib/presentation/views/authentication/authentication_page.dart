import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/constant/app_image.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/presentation/views/authentication/components/login_form.dart';
import 'package:sound_sphere/presentation/views/authentication/components/login_header.dart';
import 'package:sound_sphere/presentation/views/authentication/components/main_button.dart';
import 'package:sound_sphere/presentation/views/authentication/components/sign_up_form.dart';
import 'package:sound_sphere/presentation/views/authentication/components/sign_up_header.dart';
import 'package:sound_sphere/presentation/views/authentication/components/social_button.dart';
import 'package:sound_sphere/presentation/views/authentication/components/text_container.dart';
import 'package:sound_sphere/presentation/views/authentication/components/wave_background.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  Color backgroundColor = const Color.fromRGBO(236, 219, 254, 1);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode passwordConfirmFocusNode = FocusNode();

  bool isEmailValid = false;
  bool isPasswordVisible = false;
  bool isSignUp = false;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_validateEmail);
    emailFocusNode.addListener(() {
      setState(() {});
    });
    passwordFocusNode.addListener(() {
      setState(() {});
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    emailController.removeListener(_validateEmail);
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _validateEmail() {
    final email = emailController.text;
    setState(() {
      isEmailValid =
          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          // Background and Welcome Text
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 800),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: isSignUp
                ? SignUpHeader(
                    emailController: emailController,
                    isEmailValid: isEmailValid,
                    animationController: _animationController,
                    context: context,
                    key: ValueKey('SignUpHeader'))
                : LoginHeader(
                    emailController: emailController,
                    isEmailValid: isEmailValid,
                    animationController: _animationController,
                    context: context,
                    key: ValueKey('LoginHeader')),
          ),
          // Login and SignUp Form
          Positioned(
            top: 280,
            left: 0,
            right: 0,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: isSignUp
                  ? SignUpForm(
                      animationController: _animationController,
                      nameController: nameController,
                      emailController: emailController,
                      passwordController: passwordController,
                      passwordConfirmController: passwordConfirmController,
                      nameFocusNode: nameFocusNode,
                      emailFocusNode: emailFocusNode,
                      passwordFocusNode: passwordFocusNode,
                      passwordConfirmFocusNode: passwordConfirmFocusNode,
                      isEmailValid: isEmailValid,
                      isPasswordVisible: isPasswordVisible,
                      onTogglePasswordVisibility: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      onSignUpTap: () {
                        setState(() {
                          isSignUp = !isSignUp;
                        });
                      },
                      key: ValueKey('SignUpForm'),
                    )
                  : LoginForm(
                      animationController: _animationController,
                      emailController: emailController,
                      passwordController: passwordController,
                      emailFocusNode: emailFocusNode,
                      passwordFocusNode: passwordFocusNode,
                      isEmailValid: isEmailValid,
                      isPasswordVisible: isPasswordVisible,
                      onTogglePasswordVisibility: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      onSignUpTap: () {
                        setState(() {
                          isSignUp = !isSignUp;
                        });
                      },
                      key: ValueKey('LoginForm'),
                    ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: WaveBackground(
              colorList: [
                AppColor.primaryColor,
                const Color.fromARGB(255, 197, 19, 54),
                AppColor.primaryColor,
                const Color.fromARGB(255, 227, 136, 136),
                AppColor.primaryColor,
                const Color.fromARGB(255, 255, 207, 207),
                AppColor.primaryColor,
                const Color.fromARGB(255, 250, 103, 132),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
