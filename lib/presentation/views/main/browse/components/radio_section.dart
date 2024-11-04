import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/main/browse/components/radio_station_item.dart';

// ignore: must_be_immutable
class RadioSection extends StatelessWidget {
  String title;
  RadioSection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Theme.of(context).primaryColor, Colors.purple],
              tileMode: TileMode.mirror,
            ).createShader(bounds),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                if (title.isNotEmpty) ...[
                  SizedBox(width: 10),
                  Icon(CupertinoIcons.forward, color: Colors.white),
                ],
              ],
            ),
          ),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: FakeData.radioList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: index == FakeData.radioList.length - 1
                    ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
                    : const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child:
                    RadioStationItem(radioStation: FakeData.radioList[index]),
              );
            },
          ),
        )
      ],
    );
  }
}
