import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/router/routes.dart';

import 'package:sound_sphere/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:sound_sphere/presentation/views/account/account_page.dart';

class CustomAppBar extends StatefulWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 80,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var appBarHeight = constraints.biggest.height;
          var isExpanded = appBarHeight > kToolbarHeight;
          // debugPrint('AppBar isExpanded: $isExpanded');

          return FlexibleSpaceBar(
            titlePadding: const EdgeInsets.only(left: 16, bottom: 8),
            title: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: !isExpanded
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (isExpanded)
                    Expanded(
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isExpanded ? 24.0 : 16.0,
                          color: Colors.black,
                        ),
                      ),
                    )
                  else
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  Visibility(
                    visible: isExpanded,
                    child:
                        BlocConsumer<AuthenticationBloc, AuthenticationState>(
                      listener: (context, authState) {
                        if (authState is AuthGetUserFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(authState.message)),
                          );
                        }
                      },
                      builder: (context, authState) {
                        if (authState is AuthenticationInitial) {
                          return IconButton(
                            onPressed: () =>
                                context.pushNamed(Routes.authentication),
                            icon: Icon(
                              CupertinoIcons.person,
                              color: AppColor.primaryColor,
                            ),
                          );
                        } else if (authState is AuthLoginSuccess) {
                          context
                              .read<AuthenticationBloc>()
                              .add(AuthGetUserRequested());
                          return Skeletonizer(
                            enabled: true,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.grey,
                            ),
                          );
                        } else if (authState is AuthGetUserSuccess) {
                          final user = authState.user;
                          return InkWell(
                            onTap: _showProfileModal,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundImage: NetworkImage(user.avatarUrl),
                            ),
                          );
                        } else if (authState is AuthLoading) {
                          return Skeletonizer(
                            enabled: true,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.grey,
                            ),
                          );
                        } else {
                          return IconButton(
                            onPressed: () =>
                                context.pushNamed(Routes.authentication),
                            icon: Icon(
                              CupertinoIcons.person,
                              color: AppColor.primaryColor,
                            ),
                          );
                        }
                      },
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

  void _showProfileModal() {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => const AccountPage(),
    );
  }
}
