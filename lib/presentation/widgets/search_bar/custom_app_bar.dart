import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/presentation/views/authentication/authentication_page.dart';

class CustomAppBar extends StatefulWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 80,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var appBarHeight = constraints.biggest.height;
          var isExpanded = appBarHeight > kToolbarHeight;

          return FlexibleSpaceBar(
            titlePadding: const EdgeInsets.only(left: 16, bottom: 8),
            title: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      textAlign:
                          isExpanded ? TextAlign.start : TextAlign.center,
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isExpanded ? 24.0 : 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _showLoginModal,
                    icon: Icon(
                      CupertinoIcons.person,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showLoginModal() {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (context) => const LoginPage(),
    );
  }
}
