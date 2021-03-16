import 'package:dogehouse_flutter/models/models.dart';
import 'package:dogehouse_flutter/resources/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeItemPlanned extends StatelessWidget {
  final ScheduledRoom homeItemModel;

  HomeItemPlanned(
    this.homeItemModel,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Ink(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(8.0),
              onTap: () {},
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              homeItemModel.name!,
                              style: TextStyle(
                                  color: Palette.lightWhite,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                          SizedBox.shrink(),
                          Row(
                            children: [
                              Container(
                                decoration: new BoxDecoration(
                                  color: Palette.lightBlue,
                                  shape: BoxShape.circle,
                                ),
                                width: 14,
                                height: 14,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  DateFormat('dd.MM.yyyy, kk:mm')
                                      .format(homeItemModel.scheduledFor!),
                                  style: TextStyle(color: Palette.lightWhite),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Text(
                        homeItemModel.description!,
                        style: TextStyle(
                            color: Palette.lightBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 30, left: 15, right: 15, bottom: 25),
                      child: Container(
                        height: 30,
                        child: ListView.builder(
                          itemCount: 0,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Palette.darkBlue,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Text(
                                      homeItemModel.description![index],
                                      style: TextStyle(
                                        color: Palette.lightWhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
