import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/widgets/context/context_menu_divider.dart';

class TrackContextMenuAction extends StatelessWidget {
  final Track track;
  const TrackContextMenuAction({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoContextMenuAction(
          child: Row(
            children: [
              Text("View Credits"),
              const Spacer(),
              Icon(CupertinoIcons.info),
            ],
          ),
          onPressed: () {
            context.pop();
            context.pushNamed(Routes.creditPage, extra: {"track": track});
          },
        ),
        ContextMenuDivider(
          width: 4,
        ),
        CupertinoContextMenuAction(
          child: Row(
            children: [
              Text("Add to Library"),
              const Spacer(),
              Icon(CupertinoIcons.add),
            ],
          ),
          onPressed: () {},
        ),
        ContextMenuDivider(
          width: 1,
        ),
        CupertinoContextMenuAction(
          child: Row(
            children: [
              Text("Add to a Playlist"),
              const Spacer(),
              Icon(CupertinoIcons.music_note_list),
            ],
          ),
          onPressed: () {},
        ),
        ContextMenuDivider(
          width: 4,
        ),
        CupertinoContextMenuAction(
          child: Row(
            children: [
              Text("Play Next"),
              const Spacer(),
              Icon(CupertinoIcons.square_fill_line_vertical_square),
            ],
          ),
          onPressed: () {},
        ),
        ContextMenuDivider(
          width: 1,
        ),
        CupertinoContextMenuAction(
          child: Row(
            children: [
              Text("Play Last"),
              const Spacer(),
              Icon(CupertinoIcons.square_line_vertical_square_fill),
            ],
          ),
          onPressed: () {},
        ),
        ContextMenuDivider(
          width: 4,
        ),
        CupertinoContextMenuAction(
          child: Row(
            children: [
              Text("Share Song"),
              const Spacer(),
              Icon(CupertinoIcons.share),
            ],
          ),
          onPressed: () {},
        ),
        ContextMenuDivider(
          width: 1,
        ),
        CupertinoContextMenuAction(
          child: Row(
            children: [
              Text("Favorite"),
              const Spacer(),
              Icon(CupertinoIcons.star),
            ],
          ),
          onPressed: () {},
        ),
        ContextMenuDivider(
          width: 1,
        ),
        CupertinoContextMenuAction(
          child: Row(
            children: [
              Text("Suggest Less"),
              const Spacer(),
              Icon(CupertinoIcons.hand_thumbsdown),
            ],
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
