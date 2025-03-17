import 'package:flutter/material.dart';

class ViewSettingItem extends StatelessWidget {
  final String setting;
  final String? subtitle;
  final Function()? onTap;
  const ViewSettingItem(
      {super.key, required this.setting, this.onTap, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Row(
        children: [
          Text(setting,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          const Spacer(),
          if (subtitle != null)
            Text(subtitle!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500],
                  fontSize: 14,
                )),
          const Icon(
            size: 16,
            Icons.arrow_forward_ios,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
