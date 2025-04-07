import 'dart:io';
import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:white_gym_web/app/data/util/format_data.dart';
import 'package:white_gym_web/global/global.dart';
import 'package:white_gym_web/app/data/models/user_data.dart';

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
    TextCellValue('사물함 번호'),
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
      Get.back();
    } catch(e){
      print(e);
      Get.back();
      if(!Get.isSnackbarOpen){
        Get.snackbar('엑셀 파일 생성 실패', '다시 시도해주세요');
      }
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
        TextCellValue(formatDate(row.ticket.createDate)),
        TextCellValue(row.ticket.spotDocumentId == '' || row.ticket.endDate.isBefore(DateTime.now()) ? '-' : row.ticket.subscribe ? '구독 멤버쉽' : '일반 멤버쉽'),
        TextCellValue(formatDate(row.ticket.endDate)),
        TextCellValue(row.ticket.locker ? row.ticket.lockerNum.toString() : '-'),
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