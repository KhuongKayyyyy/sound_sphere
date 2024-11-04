import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/presentation/views/main/browse/components/broadcast_radio_item.dart';

class BroadcastRadioSection extends StatelessWidget {
  const BroadcastRadioSection({super.key});

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
                  "Broadcast Radio",
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
        SizedBox(
          height: 300,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                // crossAxisSpacing: 10,
                // mainAxisSpacing: 10,
                childAspectRatio: 0.28),
            itemCount: 9, // Replace with your actual item count
            itemBuilder: (context, index) {
              return BroadcastRadioItem(radioStation: FakeData.radioList.first);
            },
          ),
        )
      ],
    );
  }
}
