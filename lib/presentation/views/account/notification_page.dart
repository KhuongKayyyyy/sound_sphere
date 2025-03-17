import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_color.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.primaryColor,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          'Notification',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildNotiItem("Notifications",
                "Artist you like released a new music and videos."),
            const SizedBox(height: 16),
            _buildNotiItem(
                "Friend Activity", "Friends follow you and your playlist."),
          ],
        ),
      ),
    );
  }

  Widget _buildNotiItem(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
              const SizedBox(height: 4),
              SizedBox(
                width: MediaQuery.of(context).size.width - 130,
                child: Text(
                  description,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Switch.adaptive(value: true, onChanged: (value) {}),
        ],
      ),
    );
  }
}
