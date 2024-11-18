import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/presentation/views/main/search/components/app_search_bar.dart';
import 'package:sound_sphere/presentation/views/main/search/components/search_history.dart';

class IntoSearch extends StatefulWidget {
  const IntoSearch({super.key});

  @override
  State<IntoSearch> createState() => _IntoSearchState();
}

class _IntoSearchState extends State<IntoSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: Hero(
                tag: 'search_bar',
                child: AppSearchBar(
                  onTap: () {},
                ),
              ),
            ),
            InkWell(
              onTap: () => context.pop(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColor),
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchHistory(),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
