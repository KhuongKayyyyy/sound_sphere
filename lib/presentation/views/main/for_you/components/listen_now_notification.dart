import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';

class ListenNowNotification extends StatefulWidget {
  final VoidCallback onDismiss;
  const ListenNowNotification({super.key, required this.onDismiss});

  @override
  State<ListenNowNotification> createState() => _ListenNowNotificationState();
}

class _ListenNowNotificationState extends State<ListenNowNotification> {
  bool _isVisible = true;

  void _dismissNotification() {
    setState(() {
      _isVisible = false;
    });
    Future.delayed(const Duration(milliseconds: 300), widget.onDismiss);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: _isVisible ? Offset.zero : const Offset(1, 0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  FakeData.gnxTracks.first.imgURL,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New Release",
                      style: TextStyle(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      FakeData.gnxTracks.first.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              IconButton(
                onPressed: _dismissNotification,
                icon: Icon(
                  Icons.cancel,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
