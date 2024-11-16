import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/radio.dart';

// ignore: must_be_immutable
class RadioStationItem extends StatelessWidget {
  RadioStation radioStation;

  RadioStationItem({
    super.key,
    required this.radioStation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 180,
          width: 180,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 5),
            ),
          ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              radioStation.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          radioStation.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          radioStation.description,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
