import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:maps_impl/controller/dataXmlParser.dart';
import 'package:maps_impl/models/gempa.dart';
import 'package:maps_impl/pages/list_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  Gempa _dataGempa;
  bool backButtonEnabled;
  HomePage(this._dataGempa, {this.backButtonEnabled = false});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MapboxMapController mapController;

  Symbol _selectedSymbol;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    // setState(() {
    //   _add();
    // });
  }

  Future<void> _add(LatLng coords) async {
    final symb = SymbolOptions(
      geometry: coords,
      iconImage: "marker-editor",
    );
    _selectedSymbol = await mapController.addSymbol(symb);
  }

  @override
  Widget build(BuildContext context) {
    double bottomDistance = 250;
    LatLng center =
        LatLng(widget._dataGempa.getCoords[1], widget._dataGempa.getCoords[0]);

    if (widget.backButtonEnabled) {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            SlidingUpPanel(
              minHeight: 230,
              maxHeight: 230,
              // color: Colors.grey[100],
              color: Color(0xfff2f6fb),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              body: MapboxMap(
                compassEnabled: false,
                styleString:
                    // 'mapbox://styles/cavadevop/ck9cbwk4h06y01it6o9l08ca1',
                    'mapbox://styles/cavadevop/ck9cvoxuc0y4k1io726u8p3r3',
                onMapCreated: _onMapCreated,
                onStyleLoadedCallback: () async => await _add(center),
                initialCameraPosition: CameraPosition(
                  target: center,
                  zoom: 6.0,
                ),
              ),
              panel: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    // color: Colors.blue,
                    height: 100,
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  widget._dataGempa.getTanggal,
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xff3b6479),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget._dataGempa.getJam,
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            flex: 1,
                          ),
                          SizedBox(
                            height: 50,
                            width: 1,
                            child: Container(
                              color: Colors.grey,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  widget._dataGempa.getMagnitude,
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xff3b6479),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Magnitudo',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            flex: 1,
                          ),
                          SizedBox(
                            height: 50,
                            width: 1,
                            child: Container(
                              color: Colors.grey,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  widget._dataGempa.getDepth,
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xff3b6479),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Depth',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: 32,
                              color: Colors.red[900],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Location',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget._dataGempa.getWilayah,
                                  style: TextStyle(
                                    color: Color(0xff3b6479),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              Icons.my_location,
                              size: 32,
                              color: Colors.blue[900],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Coordinates',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget._dataGempa.getLatitude +
                                      " " +
                                      widget._dataGempa.getLongitude,
                                  style: TextStyle(
                                      color: Color(0xff3b6479), fontSize: 18),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 40,
              left: 20,
              child: GestureDetector(
                child: ClipOval(
                  child: Container(
                    color: Color(0xfff2f6fb),
                    height: 50,
                    width: 50,
                    child: Icon(
                      Icons.arrow_back,
                      color: Color(0xff3b6479),
                    ),
                  ),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
            Positioned(
              top: 140,
              right: 10,
              child: GestureDetector(
                child: ClipOval(
                  child: Container(
                    color: Color(0xfff2f6fb),
                    height: 45,
                    width: 45,
                    child: Icon(
                      Icons.my_location,
                      color: Color(0xff3b6479),
                      size: 25,
                    ),
                  ),
                ),
                onTap: () {
                  mapController.moveCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(target: center, zoom: 6.0),
                      ),
                    );
                },
              ),
            )
          ],
        ),
      );
    } else {
      return new Scaffold(
          body: Stack(
        children: <Widget>[
          SlidingUpPanel(
            onPanelClosed: () {
              setState(() {
                bottomDistance = 250;
              });
            },
            onPanelOpened: () {
              setState(() {
                bottomDistance = 340;
              });
            },
            minHeight: 230,
            maxHeight: 320,
            // color: Colors.grey[100],
            color: Color(0xfff2f6fb),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            body: MapboxMap(
              compassEnabled: false,
              styleString:
                  // 'mapbox://styles/cavadevop/ck9cbwk4h06y01it6o9l08ca1',
                  'mapbox://styles/cavadevop/ck9cvoxuc0y4k1io726u8p3r3',
              onMapCreated: _onMapCreated,
              onStyleLoadedCallback: () async => await _add(center),
              initialCameraPosition: CameraPosition(
                target: center,
                zoom: 6.0,
              ),
            ),
            panel: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  // color: Colors.blue,
                  height: 100,
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                widget._dataGempa.getTanggal,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Color(0xff3b6479),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget._dataGempa.getJam,
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          flex: 1,
                        ),
                        SizedBox(
                          height: 50,
                          width: 1,
                          child: Container(
                            color: Colors.grey,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                widget._dataGempa.getMagnitude,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Color(0xff3b6479),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Magnitudo',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          flex: 1,
                        ),
                        SizedBox(
                          height: 50,
                          width: 1,
                          child: Container(
                            color: Colors.grey,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                widget._dataGempa.getDepth,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Color(0xff3b6479),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Depth',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            size: 32,
                            color: Colors.red[900],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Location',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget._dataGempa.getWilayah,
                                style: TextStyle(
                                  color: Color(0xff3b6479),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.my_location,
                            size: 32,
                            color: Colors.blue[900],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Coordinates',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget._dataGempa.getLatitude +
                                    " " +
                                    widget._dataGempa.getLongitude,
                                style: TextStyle(
                                    color: Color(0xff3b6479), fontSize: 18),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                RaisedButton(
                  color: Colors.blue[900],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ListPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width - 50,
                    child: Center(
                      child: Text(
                        "Other Reports",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
              top: 140,
              right: 10,
              child: GestureDetector(
                child: ClipOval(
                  child: Container(
                    color: Color(0xfff2f6fb),
                    height: 45,
                    width: 45,
                    child: Icon(
                      Icons.my_location,
                      color: Color(0xff3b6479),
                      size: 25,
                    ),
                  ),
                ),
                onTap: () {
                  mapController.moveCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(target: center, zoom: 6.0),
                      ),
                    );
                },
              ),
            )
        ],
      ));
    }
  }
}

// setState(() {
//                       index++;
//                     });
//                     center = LatLng(dataGempa[index].getCoords[1],dataGempa[index].getCoords[0]);
//                    mapController.updateSymbol(
//                       _selectedSymbol,
//                       SymbolOptions(
//                         geometry: center,
//                         iconImage: "tw-provincial-expy-2",
//                       ),
//                     );
//                     mapController.moveCamera(
//                       CameraUpdate.newCameraPosition(
//                         CameraPosition(target: center, zoom: 6.0),
//                       ),
//                     );
