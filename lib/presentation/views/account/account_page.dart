import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:sound_sphere/presentation/views/account/components/view_noti_page_item.dart';
import 'package:sound_sphere/presentation/views/account/components/view_profile_item.dart';
import 'package:sound_sphere/presentation/views/account/components/view_setting_item.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          automaticallyImplyLeading: false,
          leading: null,
          title: const Text(
            'Account',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
                onPressed: () => context.pop(),
                child: Text(
                  "Done",
                  style: TextStyle(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 16),
                ))
          ],
        ),
        body: Column(
          children: [
            ViewProfileItem(),
            const SizedBox(height: 16),
            Text(
              "Your name and photo will be shown to others in playlist or while listening together.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            ViewNotiPageItem(),
            const SizedBox(height: 16),
            _buildSettingSection(),
            const Spacer(),
            _buildLogOutItem(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildLogOutItem() {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, authState) {
        if (authState is AuthLogoutSuccess) {
          context.pop();
          context.go(Routes.home);
          context.read<AuthenticationBloc>().add(AuthGetUserRequested());

          EasyLoading.dismiss();
          EasyLoading.showSuccess("Logged out successfully");
        } else if (authState is AuthLogoutFailure) {
          EasyLoading.showError(authState.message);
        } else if (authState is AuthLoading) {
          EasyLoading.show(status: "Logging out...");
        }
        if (authState is AuthGetUserFailure) {
          EasyLoading.dismiss();
        }
      },
      child: InkWell(
        onTap: () {
          showCupertinoDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text("Log Out"),
                content: Text("Are you sure you want to log out?"),
                actions: [
                  CupertinoDialogAction(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: () {
                      Navigator.of(context).pop();
                      context
                          .read<AuthenticationBloc>()
                          .add(AuthLogoutRequested());
                    },
                    child: Text("Log Out"),
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "Log Out",
            style: TextStyle(
              color: AppColor.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Container _buildSettingSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ViewSettingItem(
            setting: "Manage Payments ",
            onTap: () {
              context.pushNamed(Routes.managePayment);
            },
          ),
          Divider(
            color: Colors.black,
          ),
          const SizedBox(height: 8),
          ViewSettingItem(
            setting: "Subscriptions",
            onTap: () {
              context.pushNamed(Routes.subscription);
            },
          ),
          Divider(
            color: Colors.black,
          ),
          const SizedBox(height: 8),
          ViewSettingItem(
            setting: "Purchase History",
            onTap: () {
              context.pushNamed(Routes.purchaseHistory);
            },
          ),
          Divider(
            color: Colors.black,
          ),
          const SizedBox(height: 8),
          ViewSettingItem(
            setting: "Country",
            subtitle: "Vietnam",
          ),
        ],
      ),
    );
  }
}
