import 'package:dogehouse_flutter/models/models.dart';
import 'package:dogehouse_flutter/resources/palette.dart';
import 'package:flutter/material.dart';

class PeopleItem extends StatelessWidget {
  final BaseUser baseUser;

  PeopleItem(this.baseUser);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: 50,
          child: Row(
            children: [
              Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(baseUser.avatarUrl!),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      baseUser.displayName!,
                      style: TextStyle(color: Palette.lightWhite, fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    if (baseUser.currentRoom != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          baseUser.currentRoom!.name!,
                          style: TextStyle(color: Palette.lightBlue, fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
