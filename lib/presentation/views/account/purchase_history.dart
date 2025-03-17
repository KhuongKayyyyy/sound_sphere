import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_image.dart';

class PurchaseHistory extends StatefulWidget {
  const PurchaseHistory({super.key});

  @override
  State<PurchaseHistory> createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        leadingWidth: 100,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.chevron_back,
                color: AppColor.primaryColor,
              ),
              Text(
                "Back",
                style: TextStyle(
                    color: AppColor.primaryColor, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        title: const Text(
          "Subscription",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPurchaseHistoryItem(
                "8 Mar 2025", "35.000đ", "Sound Sphere", "Student Plan"),
            const SizedBox(height: 16),
            _buildPurchaseHistoryItem(
                "8 Mar 2025", "35.000đ", "Sound Sphere", "Student Plan"),
            const SizedBox(height: 16),
            _buildPurchaseHistoryItem(
                "8 Mar 2025", "35.000đ", "Sound Sphere", "Student Plan"),
            const SizedBox(height: 16),
            _buildPurchaseHistoryItem(
                "8 Mar 2025", "35.000đ", "Sound Sphere", "Student Plan"),
            const SizedBox(height: 16),
            _buildPurchaseHistoryItem(
                "8 Mar 2025", "35.000đ", "Sound Sphere", "Student Plan"),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildPurchaseHistoryItem(
      String date, String amount, String title, String type) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("7 Mar 2025",
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 14)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          AppImage.logo,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sound Sphere",
                          style: TextStyle(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Student Plan",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      "35.000đ",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Divider(
                  color: Colors.grey,
                ),
                Row(
                  children: [
                    Text(
                      "Payment Method",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const Spacer(),
                    Text(
                      "Momo >",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
