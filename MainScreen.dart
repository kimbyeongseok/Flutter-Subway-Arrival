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

  SubwayArrival(this._rowNum, this._subwayId, this._trainLineNm, this._subwayHeading, this._arvlMsg2);
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

    List<Card> res = [];
    for (SubwayArrival info in _data){
      Card card = Card(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            children: [
              if(info. _subwayId == '1001')
                CircleAvatar(
                  child: Text('1', style: TextStyle(color:Colors.white),),
                  radius: 25.0,
                  backgroundColor: Color(0xFF0d3692),
                ),
              if(info. _subwayId == '1002')
                CircleAvatar(
                  child: Text('2', style: TextStyle(color:Colors.white),),
                  radius: 25.0,
                  backgroundColor: Colors.green,
                ),
              if(info. _subwayId == '1003')
                CircleAvatar(
                  child: Text('3', style: TextStyle(color:Colors.white),),
                  radius: 25.0,
                  backgroundColor: Color(0xFFfe5d10),
                ),
              if(info. _subwayId == '1004')
                CircleAvatar(
                  child: Text('4', style: TextStyle(color:Colors.white),),
                  radius: 25.0,
                  backgroundColor: Color(0xFF32A1C8),
                ),
              if(info. _subwayId == '1005')
                CircleAvatar(
                  child: Text('5', style: TextStyle(color:Colors.white),),
                  radius: 25.0,
                  backgroundColor: Color(0xFF8b50a4),
                ),
              if(info. _subwayId == '1006')
                CircleAvatar(
                  child: Text('6', style: TextStyle(color:Colors.white),),
                  radius: 25.0,
                  backgroundColor: Color(0xFFc55c1d),
                ),
              if(info. _subwayId == '1007')
                CircleAvatar(
                  child: Text('7', style: TextStyle(color:Colors.white),),
                  radius: 25.0,
                  backgroundColor: Color(0xFF54640d),
                ),
              if(info. _subwayId == '1008')
                CircleAvatar(
                  child: Text('8', style: TextStyle(color:Colors.white),),
                  radius: 25.0,
                  backgroundColor: Color(0xFFf14c82),
                ),
              if(info. _subwayId == '1009')
                CircleAvatar(
                  child: Text('9', style: TextStyle(color:Colors.white),),
                  radius: 25.0,
                  backgroundColor: Color(0xFFaa9872),
                ),
              if(info. _subwayId == '1075')
                CircleAvatar(
                  child: Text('분당', style: TextStyle(color:Colors.white),),
                  radius: 25.0,
                  backgroundColor: Color(0xFFff8c00),
                ),
              if(info. _subwayId == '1077')
                CircleAvatar(
                  child: Text('신분당', style: TextStyle(color:Colors.white),),
                  radius: 25.0,
                  backgroundColor: Color(0xFFc82127),
                ),
              if(info. _subwayId == '1063')
                CircleAvatar(
                  child: Text('경의중앙', style: TextStyle(color:Colors.white, fontSize: 12),),
                  radius: 25.0,
                  backgroundColor: Color(0xFF73c7a6),
                ),
              if(info. _subwayId == '1067')
                CircleAvatar(
                  child: Text('경춘', style: TextStyle(color:Colors.white,),),
                  radius: 25.0,
                  backgroundColor: Color(0xFF32c6a6),
                ),
              SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('도착지 방면 : ' + info._trainLineNm),
                  Text('내리는 문 방향 : ' + info._subwayHeading),
                  Text('이전 열차 위 : ' + info._arvlMsg2),
                ],
              ),
            ],
          ),
        ),
      );
      res.add(card);
    }
    return res;
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
      _data = list;
//     _rowNum = first.rowNum;
//     _subwayId = first.subwayId;
//     _trainLineNm = first.trainLineNm;
//     _subwayHeading = first.subwayHeading;
//     _arvlMsg2 = first.arvlMsg2;
    });
  }

  @override
  void initState(){
    super.initState();
    _getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //키패드 높이 위로 중앙 컨텐츠가 위
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('서울 지하철 도착정보'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            height: 60,
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
