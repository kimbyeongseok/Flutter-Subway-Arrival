import 'package:flutter/material.dart';
//http://swopenapi.seoul.go.kr/api/subway/sample/json/realtimeStationArrival/0/5/%EC%84%9C%EC%9A%B8

const String _urlPrefix = 'http://swopenapi.seoul.go.kr/api/subway/';
const String _userKey = '4f6b6b6c43746d7837335341495168';
const String _urlSuffix= '/json/realtimeStationArrival/0/5/';
const String defaultStation= '사당';

String buildUrl(String station){
  //stringBuffer : 문자열 조합 시 사용하는 함
  StringBuffer sb = StringBuffer();
  sb.write(_urlPrefix);
  sb.write(_userKey);
  sb.write(_urlSuffix);
  sb.write(station);

  return sb.toString();
}
