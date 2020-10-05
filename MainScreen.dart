import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'subway_api.dart' as api;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class SubwayArrival{
  int _rowNum;
  String _subwayId;
  String _trainLineNm;
  String _subwayHeading;
  String _arvlMsg2;

  SubwayArrival(this._rowNum, this._trainLineNm, this._subwayHeading, this._subwayId, this._arvlMsg2);
//  int get rowNum{
//    return _rowNum;
//  }
  int get rowNum => _rowNum;
  String get subwayId => _subwayId;
  String get trainLineNm => _trainLineNm;
  String get subwayHeading => _subwayHeading;
  String get arvlMsg2 => _arvlMsg2;
}

class _MainScreenState extends State<MainScreen> {

  TextEditingController _stationController = TextEditingController(
    text: api.defaultStation,
  );

  List<SubwayArrival> _data = [];
  List<Card> _buildCards(){
    print(_data.length);
    if(_data.length == 0){
      return <Card>[];
    }
  }


  _onClick(){
    _getInfo();
    _stationController.clear();
  }

  int _rowNum;
  String _subwayId;
  String _trainLineNm;
  String _subwayHeading;
  String _arvlMsg2;

  _getInfo() async{
    String station = _stationController.text;
    var response = await http.get(api.buildUrl(station));
    String responseBody = response.body;
//    print(responseBody);
    var json = jsonDecode(responseBody);
    List<dynamic> realtimeArrivalList = json['realtimeArrivalList'];
    final int cnt = realtimeArrivalList.length;
//    print(cnt);
    List<SubwayArrival> list = List.generate(cnt, (int i) {
      Map<String, dynamic> item = realtimeArrivalList[i];
      return SubwayArrival(
        item['rowNum'],
        item['subwayId'],
        item['trainLineNm'],
        item['subwayHeading'],
        item['arvlMsg2'],
      );
    });
    SubwayArrival first = list[0];

    setState(() {
     _rowNum = first.rowNum;
     _subwayId = first.subwayId;
     _trainLineNm = first.trainLineNm;
     _subwayHeading = first.subwayHeading;
     _arvlMsg2 = first.arvlMsg2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //키패드 높이 위로 중앙 컨텐츠가 위
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Subway Arrival'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            height: 70,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: TextField(
                    controller: _stationController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      hintText: '역명을 입력해 주세요.',
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox.shrink(),
                ),
                ButtonTheme(
                  child: RaisedButton(
                    textColor: Colors.white,
                    child: Text('조회'),
                    onPressed: (){
                      _onClick();
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Flexible(
            child: ListView(
//              child: Column(
//                children: [
//                  Text('rowNum : $_rowNum'),
//                  Text('subwayId : $_subwayId'),
//                  Text('trainLineNm : $_trainLineNm'),
//                  Text('subwayHeading : $_subwayHeading'),
//                  Text('arvlMsg2 : $_arvlMsg2'),
//                ],
//              ),
            children: _buildCards(),
            ),
          )
        ],
      ),
    );
  }
}
