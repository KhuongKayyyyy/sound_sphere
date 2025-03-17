// login_form.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:sound_sphere/presentation/views/authentication/components/main_button.dart';
import 'package:sound_sphere/presentation/views/authentication/components/social_button.dart';

class LoginForm extends StatefulWidget {
  final AnimationController animationController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final bool isEmailValid;
  final bool isPasswordVisible;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onSignUpTap;
  final VoidCallback onSignInTap;
  final VoidCallback? onGoogleSignInTap;

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
    required this.onSignInTap,
    this.onGoogleSignInTap,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.emailController.text = 'test@gmail.com';
        widget.passwordController.text = '123456';

        widget.emailFocusNode.addListener(_updateState);
        widget.passwordFocusNode.addListener(_updateState);

        setState(() {});
      }
    });
  }

  void _updateState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    widget.emailFocusNode.removeListener(_updateState);
    widget.passwordFocusNode.removeListener(_updateState);
    super.dispose();
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
        child: _buildEmailAndPassTf(),
      ),
    );
  }

  Column _buildEmailAndPassTf() {
    return Column(
      children: [
        const Text(
          "Login",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        TextField(
          cursorColor: AppColor.primaryColor,
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
              borderSide: BorderSide(color: AppColor.primaryColor),
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          cursorColor: AppColor.primaryColor,
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
              borderSide: BorderSide(color: AppColor.primaryColor),
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
        Text(
          "Forgot password?",
          style: TextStyle(
            color: AppColor.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        BlocListener<AuthenticationBloc, AuthenticationState>(
          bloc: _authenticationBloc,
          listener: (context, loginState) {
            if (loginState is AuthLoginSuccess) {
              EasyLoading.showSuccess("Login success");
              context.read<AuthenticationBloc>().add(AuthGetUserRequested());
              // context.pop();
              context.goNamed(Routes.home);
            } else if (loginState is AuthLoginFailure) {
              EasyLoading.showError(loginState.message);
            } else if (loginState is AuthLoading) {
              EasyLoading.show(status: "Logging in...");
            }
          },
          child: MainButton(
            buttonLabel: "Login",
            // onPressed: widget.onSignInTap,
            onPressed: () {
              _authenticationBloc.add(
                AuthLoginRequested(
                  email: widget.emailController.text,
                  password: widget.passwordController.text,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        const Text("or Log in with",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SocialButton(
              image: AppIcon.google,
              onTap: widget.onGoogleSignInTap,
            ),
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
                recognizer: TapGestureRecognizer()..onTap = widget.onSignUpTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
