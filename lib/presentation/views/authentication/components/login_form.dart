// login_form.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/presentation/views/authentication/components/main_button.dart';
import 'package:sound_sphere/presentation/views/authentication/components/social_button.dart';

class LoginForm extends StatelessWidget {
  final AnimationController animationController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final bool isEmailValid;
  final bool isPasswordVisible;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onSignUpTap;

  const LoginForm({
    super.key,
    required this.animationController,
    required this.emailController,
    required this.passwordController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.isEmailValid,
    required this.isPasswordVisible,
    required this.onTogglePasswordVisibility,
    required this.onSignUpTap,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animationController,
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
            const Text(
              "Login",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              focusNode: emailFocusNode,
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                    color: emailFocusNode.hasFocus
                        ? AppColor.primaryColor
                        : Colors.grey),
                suffixIcon: isEmailValid
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
                  borderSide: BorderSide(color: AppColor.primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              focusNode: passwordFocusNode,
              controller: passwordController,
              obscureText: !isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                    color: passwordFocusNode.hasFocus
                        ? AppColor.primaryColor
                        : Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColor.primaryColor),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible
                        ? CupertinoIcons.eye_slash
                        : CupertinoIcons.eye,
                    color: Colors.grey,
                  ),
                  onPressed: onTogglePasswordVisibility,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Forgot password?",
              style: TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            MainButton(buttonLabel: "Login"),
            const SizedBox(height: 20),
            const Text("or Log in with",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
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
                text: 'Newbie? ',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: 'Sign up now',
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = onSignUpTap,
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
