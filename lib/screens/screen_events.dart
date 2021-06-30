import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';
import 'package:stlgui/models/detail.dart';
import 'package:stlgui/models/events.dart';
import 'package:stlgui/models/track.dart';

class ScreenEvents extends StatelessWidget {
  int itemsCount = 0;
  List<Track> listTracks;

  ScreenEvents(this.listTracks) {
    itemsCount = listTracks.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              if (index >= 0 && (index < itemsCount)) {
                return _MyListItem(index);
              }
            }),
          )
        ],
      ),
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  _MyListItem(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = context.select<EventsModel, Track>(
      (events) => events.getByPosition(index),
    );

    var textTheme = Theme.of(context).textTheme.headline6;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 36,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
                child: LineIcon.route(),
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: Text(item.name, style: textTheme),
            ),
            SizedBox(width: 24),
            _GoButton(item: item),
          ],
        ),
      ),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text('List of available events', style: Theme.of(context).textTheme.headline5),
      floating: true,
      actions: [
        // View, Follow, Record, Live
        IconButton(
          icon: LineIcon.streetView(),
          onPressed: () => Navigator.pushNamed(context, '/view'),
        ),
        IconButton(
          icon: LineIcon.alternateMapMarked(),
          onPressed: () => Navigator.pushNamed(context, '/follow'),
        ),
        IconButton(
          icon: LineIcon.recordVinyl(),
          onPressed: () => Navigator.pushNamed(context, '/record'),
        ),
        IconButton(
          icon: LineIcon.video(),
          onPressed: () => Navigator.pushNamed(context, '/live'),
        ),
      ],
    );
  }
}

class _GoButton extends StatelessWidget {
  final Track item;

  const _GoButton({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInCart = context.select<DetailModel, bool>((detail) => detail.tracks.contains(item));

    return TextButton(
      onPressed: isInCart
          ? null
          : () {
              var detail = context.read<DetailModel>();
              detail.clear();
              detail.add(item);
              Navigator.pushNamed(context, '/view');
            },
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(item.color),
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: isInCart ? Icon(Icons.check, semanticLabel: 'GONE') : LineIcon.arrowCircleRight(),
    );
  }
}
