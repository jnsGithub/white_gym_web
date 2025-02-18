import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:white_gym_web/global.dart';
import 'package:white_gym_web/models/userData.dart';

class ToExcel{
  late Excel excel;
  late Sheet sheet;

  List<TextCellValue> header = [
    TextCellValue('지점'),
    TextCellValue('이름'),
    TextCellValue('성별'),
    TextCellValue('휴대폰 번호'),
    TextCellValue('가입 일자'),
    TextCellValue('멤버쉽 이용권'),
    TextCellValue('멤버쉽 종료일'),
    TextCellValue('마케팅 정보 수신동의 여부')];

  toExcel(List<UserData> list, String spotName) async {
    try{
      // 생성자에서 초기화
      excel = Excel.createExcel();
      sheet = excel['Sheet1'];
      CellStyle cellStyle = CellStyle(
        bold: true,
        horizontalAlign: HorizontalAlign.Center,
        verticalAlign: VerticalAlign.Center,
        fontSize: 12,
      );
      // 헤더 및 데이터 추가
      addHeaderAndData(list);
      for(int i = 0; i < list.length + 3; i++){
        for(int j = 0; j < header.length; j++){
          sheet.cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: i)).cellStyle = cellStyle;
        }
      }
      sheet.setDefaultColumnWidth(20);
      sheet.setColumnWidth(2, 10);
      sheet.setColumnWidth(3, 30);
      await saveExcel(spotName);
      print('엑셀 파일 생성 완료');
    } catch(e){
      print(e);
    }

  }

  void addHeaderAndData(List<UserData> list) {
    // 헤더 추가
    // sheet.appendRow([TextCellValue(myInfo.name)]);
    sheet.appendRow([TextCellValue('')]);
    sheet.appendRow(header);

    // 데이터 추가
    for (var row in list) {
      List<TextCellValue> rowData = [
        TextCellValue(row.ticket.paymentBranch),
        TextCellValue(row.name),
        TextCellValue(row.gender == 0 ? '남자' : '여자'),
        TextCellValue(formatPhoneNumber(row.phone)),
        TextCellValue('${row.createDate.toDate().year}-${row.createDate.toDate().month}-${row.createDate.toDate().day}'),
        TextCellValue(row.ticket.subscribe ? '구독 멤버쉽' : '일반 멤버쉽'),
        TextCellValue('${row.ticket.endDate.year}-${row.ticket.endDate.month}-${row.ticket.endDate.day}'),
        TextCellValue(row.smsAlarm ? 'O' : 'X')
      ];
      sheet.appendRow(rowData);
    }

  }

  // 엑셀 파일을 저장하거나 출력하는 메서드를 추가할 수 있음
  saveExcel(String spotName) async {
    try {
      var fileBytes = excel.save(fileName: '${DateTime.now().toString()}-WhiteGym-${spotName}.xlsx');
    } catch (e) {
      print(e);
    }
  }
}