import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/presentation/blocs/playlist/playlist_bloc.dart';

class PlaylistAddNew extends StatefulWidget {
  const PlaylistAddNew({super.key});

  @override
  State<PlaylistAddNew> createState() => _PlaylistAddNewState();
}

class _PlaylistAddNewState extends State<PlaylistAddNew> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showAddNewBottomModal(context);
      },
      child: BlocListener<PlaylistBloc, PlaylistState>(
        listener: (context, plState) {
          if (plState is PLAddNewSuccess) {
            EasyLoading.showSuccess("Playlist created successfully");
            context.pop();
            if (context.read<PlaylistBloc>().state is! PlaylistGetSuccess) {
              context.read<PlaylistBloc>().add(PlaylistGetListRequested());
            }
          } else if (plState is PLAddNewFailure) {
            EasyLoading.showError(
                "Failed to create playlist: ${plState.message}");
          } else if (plState is PLAddNewLoading) {
            EasyLoading.show(status: "Creating playlist ...");
          }
        },
        child: Container(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  CupertinoIcons.add,
                  size: 50,
                  color: AppColor.primaryColor,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text left
                children: [
                  Text(
                    "New Playlist ...",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAddNewBottomModal(BuildContext context) {
    final TextEditingController playlistNameController =
        TextEditingController();
    bool isButtonEnabled = false; // Track button state

    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Prevent full-screen modal
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(), // Close modal
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: AppColor.primaryColor),
                        ),
                      ),
                      Text(
                        "New Playlist",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: isButtonEnabled
                            ? () {
                                context.read<PlaylistBloc>().add(
                                    PLAddNewRequested(
                                        playlistName:
                                            playlistNameController.text));
                              }
                            : null, // Disable tap if empty
                        child: Text(
                          "Create",
                          style: TextStyle(
                            color: isButtonEnabled
                                ? AppColor.primaryColor
                                : AppColor
                                    .inkGrey, // Change color based on state
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    margin: const EdgeInsets.all(16),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.primaryColor,
                        ),
                        child: Icon(
                          CupertinoIcons.camera_fill,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    controller: playlistNameController,
                    cursorColor: AppColor.primaryColor,
                    onChanged: (text) {
                      setState(() {
                        isButtonEnabled = text.trim().isNotEmpty;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Playlist Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.primaryColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.primaryColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Show on Profile and in Search",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColor.inkGreyDark,
                        ),
                      ),
                      const Spacer(),
                      Switch.adaptive(value: false, onChanged: (value) {}),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
