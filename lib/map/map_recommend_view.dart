import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gdsc/commmon/component/layout/default_layout.dart';
import 'package:gdsc/commmon/const/colors.dart';
import 'package:gdsc/home/component/home_card.dart';
import 'package:gdsc/map/map_view.dart';


class MapRecommendView extends StatefulWidget {

  const MapRecommendView({Key ? key}) : super(key: key);



  @override
  State<MapRecommendView> createState() => _MapRecommendViewState();
}

class _MapRecommendViewState extends State<MapRecommendView> {

  CollectionReference destinations = FirebaseFirestore.instance.collection('trail');

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: BG_COLOR,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80,),
            Container(
              padding: EdgeInsets.fromLTRB(40,10,10,10),
              child: Text("주변 산책로 추천",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
            SizedBox(height: 20,),
            StreamBuilder(
                stream: destinations.snapshots(),
                builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> streamSnapshot){
                  if(streamSnapshot.hasData){
                    return Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(20),
                        itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder:(context, index){
                          final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];

                          return Card(
                            margin: EdgeInsets.all(20),
                            child: Home_Card(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                    MapView(trailName:documentSnapshot['trail_name']))
                                );
                              },
                              height: 90,
                              Decoimage: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "asset/map/mapex.png"
                                  )),
                              child: ClipRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                  child: Container(
                                    child: Center(
                                      child: Text( documentSnapshot['trail_name'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );

                          },

                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
            }
            )
          ],
        ),
    );
  }
}
