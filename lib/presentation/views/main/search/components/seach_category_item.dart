import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/data/models/search_category.dart';

class SeachCategoryItem extends StatelessWidget {
  final SearchCategory category;
  const SeachCategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          context.pushNamed(Routes.searchCategoryDetail, extra: category),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.saturation),
              child: Image.network(
                category.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors
                  .primaries[category.hashCode % Colors.primaries.length]
                  .withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                category.name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
