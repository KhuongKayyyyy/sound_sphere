import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/presentation/views/main/browse/components/broadcast_radio_section.dart';
import 'package:sound_sphere/presentation/views/main/browse/components/radio_section.dart';

class BrowseRadioPage extends StatefulWidget {
  const BrowseRadioPage({super.key});

  @override
  State<BrowseRadioPage> createState() => _BrowseRadioPageState();
}

class _BrowseRadioPageState extends State<BrowseRadioPage> {
  bool _showSkeleton = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _showSkeleton = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        child: Skeletonizer(
          enabled: _showSkeleton,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // page title
              _buildRadioAppBar(),
              // radio stations list
              RadioSection(title: ""),
              RadioSection(title: "Popular Stations"),
              RadioSection(title: "Our hosts"),
              RadioSection(title: "Worldwide Stations"),
              RadioSection(title: "Popular Stations"),
              RadioSection(title: "Every Show, On Demand"),
              BroadcastRadioSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioAppBar() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 10),
      child: Row(
        children: [
          Text("Radio",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: InkWell(
              child:
                  Icon(CupertinoIcons.calendar, color: AppColor.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
