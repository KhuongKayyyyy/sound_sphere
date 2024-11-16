import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/radio.dart';

// ignore: must_be_immutable
class BroadcastRadioItem extends StatelessWidget {
  RadioStation radioStation;
  BroadcastRadioItem({super.key, required this.radioStation});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                radioStation.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(radioStation.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
              Text(radioStation.description,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  )),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.more_horiz_rounded),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
