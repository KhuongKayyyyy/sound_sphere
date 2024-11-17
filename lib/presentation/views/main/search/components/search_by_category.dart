import 'package:flutter/material.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/main/search/components/seach_category_item.dart';

class SearchByCategory extends StatelessWidget {
  const SearchByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Browse by Category",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: FakeData
                .searchCategory.length, // Replace with your actual item count
            itemBuilder: (context, index) {
              return SizedBox(
                height: 120,
                child: SeachCategoryItem(
                  category: FakeData.searchCategory.elementAt(index),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
