import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/data/models/app_user.dart';
import 'package:sound_sphere/presentation/blocs/authentication/authentication_bloc.dart';

class ViewProfileItem extends StatelessWidget {
  const ViewProfileItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authState) {
        if (authState is AuthGetUserSuccess) {
          return _buildItem(authState.user, context);
        } else if (authState is AuthLoading) {
          return Skeletonizer(
              enabled: true, child: _buildItem(AppUser.empty(), context));
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildItem(AppUser user, BuildContext context) {
    return InkWell(
      onTap: () {
        context.pop();
        context.pushNamed(Routes.profile);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                user.avatarUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              // Ensures proper layout inside Row
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize:
                    MainAxisSize.min, // Prevents infinite height issues
                children: [
                  Text(
                    user.displayName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "View Profile",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              size: 16,
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
