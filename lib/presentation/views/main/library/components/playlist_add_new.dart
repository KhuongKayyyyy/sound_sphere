import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_color.dart';

class PlaylistAddNew extends StatelessWidget {
  const PlaylistAddNew({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showAddNewBottomModal(context); // Pass context here
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
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
    );
  }

  void showAddNewBottomModal(BuildContext context) {
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
        return Container(
          height: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Prevent full-screen modal
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => context.pop(), // Close modal
                    child: Text("Cancel",
                        style: TextStyle(color: AppColor.primaryColor)),
                  ),
                  Text(
                    "New Playlist",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Create",
                      style: TextStyle(
                        color: AppColor.inkGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
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
                decoration: InputDecoration(
                  hintText: "Playlist Name",
                  border: OutlineInputBorder(
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
                        color: AppColor.inkGreyDark),
                  ),
                  const Spacer(),
                  Switch.adaptive(value: true, onChanged: (value) {}),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
