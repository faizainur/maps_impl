import 'dart:io';
import 'package:xml/xml.dart' as xml;
import 'package:xml/xml_events.dart' as xml_events;
import 'package:maps_impl/models/gempa.dart';
import 'package:flutter/services.dart' show rootBundle;

class DataXmlParser {

  DataXmlParser();

  Future<String> readXmlFile() async {
    // var data;

    // final xmlFile = File(_path);

    // if (await xmlFile.exists()) {
    //   data = await xmlFile.readAsString();
    //   // print(data);
    //   return data;
    // }
    // return null;
    return await rootBundle.loadString('assets/gempaterkini.xml');
  }

  Future<List<Gempa>> getDataGempa() async {
    List<Gempa> listGempa = List<Gempa>();

    final document = xml.parse(await readXmlFile());

    final gempa = document.findAllElements('gempa');

    gempa.forEach(
      (node) {
        List<double> coordsDouble = [];
        var point = node.findElements('point');
        var coords = point.forEach((val) {
          var coordsString = val.findElements('coordinates').single.text.split(',');
          coordsString.forEach((val) {
            coordsDouble.add(double.parse(val));
          });
        });


        listGempa.add(
          Gempa(
            node.findElements('Tanggal').single.text,
            node.findElements('Jam').single.text,
            coordsDouble,
            node.findElements('Lintang').single.text,
            node.findElements('Bujur').single.text,
            node.findElements('Kedalaman').single.text,
            node.findElements('Magnitude').single.text,
            node.findElements('Wilayah').single.text
          ),
        );
        // print(node.text);
      },
    );

    return listGempa;
  }
}
