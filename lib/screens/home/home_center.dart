import 'package:dogehouse_flutter/components/home_header.dart';
import 'package:dogehouse_flutter/components/search_bar.dart';
import 'package:dogehouse_flutter/items/home_item_live.dart';
import 'package:dogehouse_flutter/items/home_item_planned.dart';
import 'package:dogehouse_flutter/provider/doge_provider.dart';
import 'package:dogehouse_flutter/resources/palette.dart';
import 'package:dogehouse_flutter/screens/call/call_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeCenter extends StatefulWidget {
  @override
  _HomeCenterState createState() => _HomeCenterState();
}

class _HomeCenterState extends State<HomeCenter> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DogeProvider>(builder: (context, model, _) {
      return CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            actions: [Container()],
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: SearchBar(),
            centerTitle: true,
            floating: true,
            pinned: true,
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            actions: [Container()],
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: HomeHeader(),
            centerTitle: true,
            floating: true,
            pinned: false,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return HomeItemLive(model.publicRoomsQuery.rooms![index], () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CallScreen(model.publicRoomsQuery.rooms![index].id)),
                  );
                });
              },
              childCount: model.publicRoomsQuery.rooms!.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Palette.separateLine,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return HomeItemPlanned(model.scheduledRoomsInfo.scheduledRooms![index]);
              },
              childCount: model.scheduledRoomsInfo.scheduledRooms!.length,
            ),
          ),
        ],
      );
    });
  }
}
