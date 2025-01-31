import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:js' as js;
import 'package:http/http.dart' as http;

class MyWebAddressPage extends StatefulWidget {
  const MyWebAddressPage({Key? key}) : super(key: key);

  @override
  State<MyWebAddressPage> createState() => _MyWebAddressPageState();
}

class _MyWebAddressPageState extends State<MyWebAddressPage> {
  String _selectedRoadAddress = '';
  String _selectedJibunAddress = '';
  String _selectedZonecode = '';

  @override
  void initState() {
    super.initState();
    // JS -> Dart 콜백 함수 등록
    // 여기서 'onJusoSelected' 라는 이름으로 함수를 등록해두면
    // index.html 에서 window['onJusoSelected'](...) 로 호출 가능
    js.context["onJusoSelected"] = (String jsonStr) {
      // js.context에서 넘어온 데이터는 JS String 형태
      Map a = jsonDecode(jsonStr);
      print(a['roadAddress']);
      final Map<String, dynamic> data = _parseJson(jsonStr);
      setState(() {
        print(jsonStr);
        _selectedRoadAddress = a['roadAddress'] ?? '';
        _selectedJibunAddress = a['jibunAddress'] ?? '';
        _selectedZonecode = a['zoneCode'] ?? '';
      });
      getLocation();
    };
  }

  // 간단한 JSON 파싱 함수
  Map<String, dynamic> _parseJson(String jsonStr) {
    try {
      return Map<String, dynamic>.from(
          js.context.callMethod('eval', ['(' + jsonStr + ')']));
    } catch (_) {
      return {};
    }
  }
  getLocation( ) async {
    String url = 'https://dapi.kakao.com/v2/local/search/address.JSON?query=${_selectedRoadAddress}';
    http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'KakaoAK b3cb1c7aa1e076c60ec8156e4995d055' //TODO: 키 바꿔야함.
        });
    var data1 = response.body;
    var dataJson = jsonDecode(data1) ;
    print(dataJson);

  }
  void _openDaumPostcode() async {
    // index.html에 정의된 openDaumPostcode 함수를 호출.
    // 매개변수로 Dart에서 등록한 콜백 함수 이름을 넘김.
    js.context.callMethod('openDaumPostcode', ['onJusoSelected']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('도로명 주소 검색(Flutter Web)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _openDaumPostcode,
              child: Text('주소 검색 팝업 열기'),
            ),
            SizedBox(height: 20),
            Text('도로명 주소: $_selectedRoadAddress'),
            Text('지번 주소: $_selectedJibunAddress'),
            Text('우편번호: $_selectedZonecode'),
          ],
        ),
      ),
    );
  }
}
