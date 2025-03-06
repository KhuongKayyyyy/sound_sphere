import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';

class LibraryTypeItem extends StatefulWidget {
  Function? onTap;
  final IconData icon;
  final String title;
  LibraryTypeItem(
      {super.key, required this.icon, required this.title, this.onTap});

  @override
  State<LibraryTypeItem> createState() => _LibraryTypeItemState();
}

class _LibraryTypeItemState extends State<LibraryTypeItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap as void Function()?,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Icon(
                widget.icon,
                color: AppColor.primaryColor,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          CupertinoIcons.chevron_right,
                          color: AppColor.inkGrey,
                        ),
                      )
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: AppColor.inkGreyLight,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
