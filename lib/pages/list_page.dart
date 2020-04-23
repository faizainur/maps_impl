import 'package:flutter/material.dart';
import 'package:maps_impl/controller/dataXmlParser.dart';
import 'package:maps_impl/models/gempa.dart';
import 'package:maps_impl/pages/home_page.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  DataXmlParser xmlData = DataXmlParser();
  List<Gempa> listDataGempa;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xff3b6479),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Color(0xfff2f6fb),
        title: Text(
          "Reports",
          style: TextStyle(
            color: Color(0xff3b6479),
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        color: Color(0xfff2f6fb),
        child: FutureBuilder<List<Gempa>>(
          future: xmlData.getDataGempa(),
          builder: (context, AsyncSnapshot<List<Gempa>> snpashot) {
            if (snpashot.hasData) {
              listDataGempa = snpashot.data;
              return ListView.builder(
                  itemCount: listDataGempa.length,
                  itemBuilder: (BuildContext context, int idx) {
                    return ListTile(
                      leading: Text(listDataGempa[idx].getMagnitude),
                      title: Text(listDataGempa[idx].getLatitude +
                          " " +
                          listDataGempa[idx].getLongitude),
                      subtitle: Text(listDataGempa[idx].getTanggal +
                          " " +
                          listDataGempa[idx].getJam),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return HomePage(
                                listDataGempa[idx],
                                backButtonEnabled: true,
                              );
                            },
                          ),
                        ),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return HomePage(
                              listDataGempa[idx],
                              backButtonEnabled: true,
                            );
                          },
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
