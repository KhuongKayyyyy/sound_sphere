import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/constant/app_image.dart';
import 'package:sound_sphere/presentation/views/authentication/components/main_button.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

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
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  bool isEmailValid = false;
  bool isPasswordVisible = false;

  // Animation controller
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_validateEmail);
    emailFocusNode.addListener(() {
      setState(() {}); // Update UI when email focus changes
    });
    passwordFocusNode.addListener(() {
      setState(() {}); // Update UI when password focus changes
    });

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward(); // Start the animation
  }

  @override
  void dispose() {
    emailController.removeListener(_validateEmail);
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose(); // Dispose of the FocusNode
    passwordFocusNode.dispose(); // Dispose of the FocusNode
    _animationController.dispose(); // Dispose of the AnimationController
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
          _buildHeader(),
          // Login Form
          Positioned(top: 280, left: 0, right: 0, child: _buildLoginForm()),
          Positioned(
              bottom: 0, left: 0, right: 0, child: _buildWaveBackground())
        ],
      ),
    );
  }

  Widget _buildWaveBackground() {
    return WaveWidget(
      config: CustomConfig(
        gradients: [
          [
            AppColor.primaryColor,
            const Color.fromARGB(255, 197, 19, 54),
          ],
          [
            AppColor.primaryColor,
            const Color.fromARGB(255, 227, 136, 136),
          ],
          [
            AppColor.primaryColor,
            const Color.fromARGB(255, 255, 207, 207),
          ],
          [
            AppColor.primaryColor,
            const Color.fromARGB(255, 250, 103, 132),
          ],
        ],
        durations: [19440, 10800, 6000, 13440],
        heightPercentages: [0.20, 0.35, 0.25, 0.30],
        blur: const MaskFilter.blur(BlurStyle.solid, 2),
        gradientBegin: Alignment.bottomLeft,
        gradientEnd: Alignment.topRight,
      ),
      waveAmplitude: 0,
      size: const Size(double.infinity, 80),
    );
  }

  Widget _buildHeader() {
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
              AppImage.login_background,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 200,
          left: 50,
          child: _buildTextContainer(
              emailController.text.isNotEmpty && !isEmailValid ? "eh" : "Hi"),
        ),
        Positioned(
          top: 120,
          left: 100,
          child: _buildTextContainer(
              emailController.text.isNotEmpty && !isEmailValid
                  ? "Invalid Email"
                  : "Welcome back"),
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

  Widget _buildLoginForm() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
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
            // Email TextField
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
                  borderSide: const BorderSide(
                      color: Colors.grey), // Border when not focused
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: AppColor.primaryColor), // Border when focused
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Password TextField
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
                  borderSide: const BorderSide(
                      color: Colors.grey), // Border when not focused
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: AppColor.primaryColor), // Border when focused
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    CupertinoIcons.eye,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
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
                _buildSocialButton(image: AppIcon.google),
                _buildSocialButton(image: AppIcon.facebook),
                _buildSocialButton(image: AppIcon.apple)
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
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Handle sign up tap
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextContainer(String text) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [AppColor.primaryColor, Colors.blue],
            tileMode: TileMode.mirror,
          ).createShader(bounds),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                text,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
                speed: const Duration(milliseconds: 100),
              ),
            ],
            totalRepeatCount: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({required String image}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Image.asset(
        image,
        height: 30,
        width: 30,
      ),
    );
  }
}
