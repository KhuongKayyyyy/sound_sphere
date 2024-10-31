import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_image.dart';
import 'package:sound_sphere/presentation/views/authentication/components/text_container.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({
    super.key,
    required this.emailController,
    required this.isEmailValid,
    required AnimationController animationController,
    required this.context,
  }) : _animationController = animationController;

  final TextEditingController emailController;
  final bool isEmailValid;
  final AnimationController _animationController;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: SizedBox(
            height: 320,
            width: double.infinity,
            child: Image.asset(
              AppImage.sign_in_background,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 100,
          left: 50,
          child: TextContainer(
            text: emailController.text.isNotEmpty && !isEmailValid
                ? "eh"
                : "Hello",
            animationController: _animationController,
          ),
        ),
        Positioned(
          top: 120,
          left: 220,
          child: TextContainer(
            text: emailController.text.isNotEmpty && !isEmailValid
                ? "Invalid Email"
                : "Get started!",
            animationController: _animationController,
          ),
        ),
        Positioned(
          top: 60,
          right: 20,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  AppColor.primaryColor,
                  const Color.fromARGB(255, 119, 132, 143)
                ],
                tileMode: TileMode.mirror,
              ).createShader(bounds),
              child: const Text(
                "Done",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
