import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/presentation/views/account/components/view_setting_item.dart';

class ManagePaymentPage extends StatelessWidget {
  const ManagePaymentPage({super.key});

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
          "Manage Payment",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Edit",
                style: TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("PAYMENT METHODS",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 14)),
            const SizedBox(height: 16),
            _buildPaymentMethodSection(),
            const SizedBox(height: 16),
            Text(
                "Your default payment method is at the top.Tap Edit to re-order or remove a payment method.",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 12)),
            const SizedBox(height: 16),
            _buildAddMethodSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAddMethodSection() {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ViewSettingItem(
          setting: "Add Payment method",
        ));
  }

  Container _buildPaymentMethodSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildPaymentMethodItem(
              "https://upload.wikimedia.org/wikipedia/vi/f/fe/MoMo_Logo.png",
              "**** **** **** 1234",
              "MoMo",
              () {}),
          const Divider(),
          _buildPaymentMethodItem(
              "https://www.vietnam-visa.com/wp-content/themes/visa/img/logo_visa_payment.png",
              "**** **** **** 5678",
              "Visa",
              () {}),
          const Divider(),
          _buildPaymentMethodItem(
              "https://play-lh.googleusercontent.com/woYAzPCG1I8Z8HXCsdH3diL7oly0N8uth_1g6k7R_9Gu7lbxrsYeriEXLecRG2E9rP0",
              "**** **** **** 9012",
              "ZaloPay",
              () {}),
          const Divider(),
          _buildPaymentMethodItem(
              "https://www.siampay.com/en/images/shopeepay-img1.png",
              "**** **** **** 0803",
              "ShoppePay",
              () {}),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodItem(
      String imageUrl, String cardNumber, String method, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Image.network(
            imageUrl,
            width: 50,
            height: 50,
            // fit: BoxFit.cover,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(method),
              const SizedBox(height: 4),
              Text(
                cardNumber,
                style: TextStyle(color: Colors.grey[500]),
              )
            ],
          ),
          const Spacer(),
          Icon(CupertinoIcons.chevron_forward)
        ],
      ),
    );
  }
}
