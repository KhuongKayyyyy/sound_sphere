import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/presentation/views/authentication/components/main_button.dart';
import 'package:sound_sphere/presentation/views/authentication/components/social_button.dart';

class SignUpForm extends StatefulWidget {
  final AnimationController animationController;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;
  final FocusNode nameFocusNode;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode passwordConfirmFocusNode;
  final bool isEmailValid;
  final bool isPasswordVisible;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onSignUpTap;
  final VoidCallback onSignInTap;

  const SignUpForm({
    super.key,
    required this.animationController,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmController,
    required this.nameFocusNode,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.passwordConfirmFocusNode,
    required this.isEmailValid,
    required this.isPasswordVisible,
    required this.onTogglePasswordVisibility,
    required this.onSignUpTap,
    required this.onSignInTap,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool showPasswordFields = false;

  void _onNextPressed() {
    setState(() {
      if (!showPasswordFields) {
        showPasswordFields = true;
      } else {
        widget.onSignUpTap();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: widget.animationController,
          curve: Curves.easeInOut,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                if (showPasswordFields)
                  Positioned(
                    left: 0,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        setState(() {
                          showPasswordFields = false;
                        });
                      },
                    ),
                  ),
                const Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Use AnimatedSwitcher to handle transitions between fields
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: showPasswordFields
                  ? Column(
                      key: const ValueKey('passwordFields'),
                      children: [
                        TextField(
                          focusNode: widget.passwordFocusNode,
                          controller: widget.passwordController,
                          obscureText: !widget.isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                color: widget.passwordFocusNode.hasFocus
                                    ? AppColor.primaryColor
                                    : Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: AppColor.primaryColor),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                widget.isPasswordVisible
                                    ? CupertinoIcons.eye_slash
                                    : CupertinoIcons.eye,
                                color: Colors.grey,
                              ),
                              onPressed: widget.onTogglePasswordVisibility,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          focusNode: widget.passwordConfirmFocusNode,
                          controller: widget.passwordConfirmController,
                          obscureText: !widget.isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(
                                color: widget.passwordConfirmFocusNode.hasFocus
                                    ? AppColor.primaryColor
                                    : Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: AppColor.primaryColor),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                widget.isPasswordVisible
                                    ? CupertinoIcons.eye_slash
                                    : CupertinoIcons.eye,
                                color: Colors.grey,
                              ),
                              onPressed: widget.onTogglePasswordVisibility,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      key: const ValueKey('nameEmailFields'),
                      children: [
                        TextField(
                          focusNode: widget.nameFocusNode,
                          controller: widget.nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(
                                color: widget.nameFocusNode.hasFocus
                                    ? AppColor.primaryColor
                                    : Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: AppColor.primaryColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          focusNode: widget.emailFocusNode,
                          controller: widget.emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                color: widget.emailFocusNode.hasFocus
                                    ? AppColor.primaryColor
                                    : Colors.grey),
                            suffixIcon: widget.isEmailValid
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                : null,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: AppColor.primaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 20),
            MainButton(
              buttonLabel: showPasswordFields ? "Sign Up" : "Next",
              onPressed: _onNextPressed,
            ),
            const SizedBox(height: 20),
            const Text(
              "or Sign Up With",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SocialButton(image: AppIcon.google),
                SocialButton(image: AppIcon.facebook),
                SocialButton(image: AppIcon.apple),
              ],
            ),
            const SizedBox(height: 30),
            RichText(
              text: TextSpan(
                text: 'Existing User? ',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: 'Login',
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onSignInTap,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
