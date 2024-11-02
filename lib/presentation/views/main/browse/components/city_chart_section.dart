import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/main/browse/components/city_top_songs_item.dart';

// ignore: must_be_immutable
class CityChartSection extends StatelessWidget {
  List<Map<String, String>> cityList = FakeData.locationImages;
  CityChartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Theme.of(context).primaryColor, Colors.purple],
                tileMode: TileMode.mirror,
              ).createShader(bounds),
              child: const Row(
                children: [
                  Text(
                    "Daily Top 100",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Icon(CupertinoIcons.forward, color: Colors.white),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              scrollDirection: Axis.horizontal,
              itemCount: cityList.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: CityTopSongsItem(
                        cityName: cityList.elementAt(index)["location"]!,
                        imageUrl: cityList.elementAt(index)["imageURL"]!));
              },
            ),
          ),
        ],
      ),
    );
  }
}
