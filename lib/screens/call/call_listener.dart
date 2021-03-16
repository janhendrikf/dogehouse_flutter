import 'package:dogehouse_flutter/items/listener_item.dart';
import 'package:dogehouse_flutter/provider/doge_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CallListener extends StatefulWidget {
  @override
  _CallListenerState createState() => _CallListenerState();
}

class _CallListenerState extends State<CallListener> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DogeProvider>(builder: (context, model, _) {
      return CustomScrollView(slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, bottom: 25),
            child: Text(
              'Speaker',
              style: TextStyle(color: Color(0xFFdee3ea), fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 136.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ListenerItem(model.currentRoom!.users![index], false, model.currentRoom!.muteMap!.containsKey(model.currentRoom!.users![index].id));
            },
            childCount: model.currentRoom!.users!.where((element) => model.currentRoom!.activeSpeakerMap!.containsKey(element.id)).length,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, bottom: 25),
            child: Text(
              'Speaker requests',
              style: TextStyle(color: Color(0xFFdee3ea), fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 136.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ListenerItem(model.currentRoom!.users![index], false, false);
            },
            childCount: 0,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, bottom: 25),
            child: Text(
              'Listeners',
              style: TextStyle(color: Color(0xFFdee3ea), fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 136.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ListenerItem(model.currentRoom!.users![index], false, false);
            },
            childCount: model.currentRoom!.users!.length,
          ),
        )
      ]);
    });
  }
}
