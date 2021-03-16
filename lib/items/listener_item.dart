import 'package:dogehouse_flutter/models/models.dart';
import 'package:flutter/material.dart';

class ListenerItem extends StatelessWidget {
  final RoomUser roomUser;
  final bool isMod;
  final bool isMute;

  ListenerItem(this.roomUser, this.isMod, this.isMute);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 70.0,
              width: 70.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(roomUser.avatarUrl!),
                ),
              ),
            ),
          ),
          Text(roomUser.displayName! + ' ' + (isMute ? 'M' : '')),
        ],
      ),
    );
  }
}
