import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gdsc/commmon/component/layout/default_layout.dart';
import 'package:gdsc/commmon/const/colors.dart';
import 'package:gdsc/map/running_box.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  final String trailName;



  const MapView({

    Key ? key,
    required this.trailName,


  }) : super (key: key);

  @override
  State<MapView> createState() => _MapViewState();
}
CollectionReference destinations = FirebaseFirestore.instance.collection('trail');


class _MapViewState extends State<MapView> {
  final Set<Polyline> _polylines = {};
  late GoogleMapController mapController;
  late final LatLng _startPoint; // 시작점 좌표
  late final LatLng _dtPoint;


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _fetchTrailData() async {
    try {
      QuerySnapshot trailDataSnapshot = await destinations.where('trail_name', isEqualTo: widget.trailName).get();
      if (trailDataSnapshot.docs.isNotEmpty) {
        // 시작점 좌표 추출
        GeoPoint startPoint = trailDataSnapshot.docs[0]['s_latlng'];
        _startPoint = LatLng(startPoint.latitude, startPoint.longitude);
        GeoPoint dtPoint = trailDataSnapshot.docs[0]['dt_latlng'];
        _dtPoint = LatLng(dtPoint.latitude, dtPoint.longitude);

        _createPolylines();
      }
    } catch (error) {
      print('Error fetching trail data: $error');
    }
  }



  // 폴리라인 그리기
  void _createPolylines() {
    Polyline polyline = Polyline(
        polylineId: PolylineId("map_polyline"),
        color: Colors.blue,
        width: 3,
        points: [_startPoint, _dtPoint]
    );
    setState(() {
      _polylines.add(polyline);
    });
    }



    // 폴리라인 추가


  @override
  void initState() {
    super.initState();
    _fetchTrailData();
  }


  Widget build(BuildContext context) {
    return DefaultLayout(
        backgroundColor: BG_COLOR,
        child: Stack(
            children: [
              GoogleMap(
                onMapCreated: _onMapCreated,
                onTap: (argument) {},
                initialCameraPosition: CameraPosition(
                    target: _startPoint,
                    zoom: 14
                ),
                myLocationButtonEnabled: true,
                mapType: MapType.normal,
                polylines: _polylines,


              ),
              Positioned(
                bottom: 30,
                  left: 30,
                  child: RunningBox(detinationName: widget.trailName)),

            ]
        )
    );
  }
}
