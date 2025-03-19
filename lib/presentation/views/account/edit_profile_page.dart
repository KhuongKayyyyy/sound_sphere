import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/utils/helpers.dart';
import 'package:sound_sphere/data/models/app_user.dart';
import 'package:sound_sphere/presentation/blocs/authentication/authentication_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController =
      TextEditingController(text: "Default Name");
  final TextEditingController _nickNameController =
      TextEditingController(text: "Default Nick Name");

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              "Done",
              style: TextStyle(color: Colors.grey),
            )),
        leading: TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              "Cancel",
              style: TextStyle(color: AppColor.primaryColor),
            )),
        middle: Text("Edit Profile"),
      ),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, authState) {
          if (authState is AuthGetUserSuccess) {
            _nameController.text = authState.user.displayName;
            _nickNameController.text =
                Helpers.getUserNickName(authState.user.email);
            return _buildProfileBody(authState.user);
          } else if (authState is AuthLoading) {
            return Center(
                child: CupertinoActivityIndicator(
              color: AppColor.primaryColor,
            ));
          } else {
            return Center(child: Text("Error loading profile"));
          }
        },
      ),
    );
  }

  Widget _buildProfileBody(AppUser user) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 80),
            _buildUserInformation(user),
            const SizedBox(height: 16),
            _buildFollowSettingSection(),
            const SizedBox(height: 16),
            _buildSharedPlaylistSection(),
            const SizedBox(height: 16),
            _buildShowOnProfileSetting(),
            const SizedBox(height: 16),
            _buildDeleteProfileButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteProfileButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.primaryColor),
      child: Text(
        "Delete Profile",
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildShowOnProfileSetting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Show on your profile",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Text(
                "Listening to",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Switch.adaptive(value: true, onChanged: (value) {}),
          ],
        ),
        Divider(
          thickness: 0.5,
        ),
        const SizedBox(height: 16),
        Text(
          "The album and podcast episode you're currently listening to will be displayed on your profile.",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSharedPlaylistSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Shared Playlist",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Select playlist to share with your followers and in search results.",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Divider(
          thickness: 0.5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Everyone",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                value: true, // Set the initial value
                onChanged: (bool? value) {
                  setState(() {
                    // Handle the value change
                  });
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "People you approve",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                value: false, // Set the initial value
                onChanged: (bool? value) {
                  setState(() {
                    // Handle the value change
                  });
                },
              ),
            ),
          ],
        ),
        Divider(
          thickness: 0.5,
        ),
      ],
    );
  }

  Widget _buildFollowSettingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Who can follow you",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Divider(
          thickness: 0.5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Everyone",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                value: true, // Set the initial value
                onChanged: (bool? value) {
                  setState(() {
                    // Handle the value change
                  });
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "People you approve",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                value: false, // Set the initial value
                onChanged: (bool? value) {
                  setState(() {
                    // Handle the value change
                  });
                },
              ),
            ),
          ],
        ),
        Divider(
          thickness: 0.5,
        ),
      ],
    );
  }

  Widget _buildUserInformation(AppUser user) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  user.avatarUrl,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 10,
                right: 65,
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    size: 30,
                    CupertinoIcons.camera_fill,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(
            thickness: 0.5,
          ),
          const SizedBox(height: 16),
          _buildEditTextField("Name", user.displayName, _nameController),
          Divider(
            thickness: 0.5,
          ),
          _buildEditTextField("Nick Name", Helpers.getUserNickName(user.email),
              _nickNameController),
          Divider(
            thickness: 0.5,
          ),
          Text(
            "Your photo, name and username will be visible to everyone.",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildEditTextField(
      String label, String hint, TextEditingController controller) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              cursorColor: AppColor.primaryColor,
              controller: controller,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                alignLabelWithHint: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
