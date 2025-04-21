import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:white_gym_web/app/data/models/paymentItem.dart';

class test_repository {
  final db = FirebaseFirestore.instance.collection('payment_test');

  Future<void> test() async {
    // final snapshot = await db.get();
    // final snapshotCount = await db.count().get();
    final snapshot = await db.where('sportswear', isEqualTo: true).get();
    final snapshotCount = await db.where('sportswear', isEqualTo: true).count().get();
    int count = 0;
    int total = snapshotCount.count!;
    print(total);


    // for(var i in snapshot.docs) {
    //   try{
    //     // PaymentItem a = PaymentItem.fromJson(i.data());
    //     var data = i.data();
    //     var temp = await FirebaseFirestore.instance.collection('user').doc(
    //         i.data()['userDocumentId']).get();
    //
    //     if (i.data()['sportswear'] == true) {
    //       data['sportswear'] = temp.data()!['ticket']['spotItem']['sportswear'];
    //     }
    //
    //     if (i.data()['locker'] == true) {
    //       data['locker'] = temp.data()!['ticket']['spotItem']['locker'];
    //     }
    //
    //     if (i.data()['sportswear'] == false) {
    //       data['sportswear'] = 0;
    //     }
    //     if (i.data()['locker'] == false) {
    //       data['locker'] = 0;
    //     }
    //     await db.doc(i.id).update(data);
    //
    //     count++;
    //     print('$count / $total');
    //   } catch (e) {
    //     print(e);
    //     print(i.id);
    //     print(i.data());
    //   }
    // }
    // if (count == total) {
    //   print('DB 수정 완료');
    // } else {
    //   print('DB 수정 일부 실패');
    // }

    print(4);

  }

  Future<void> test2() async {
    try {
      final snapshot = await db.get();
      List<PaymentItem> a = <PaymentItem>[];
      for(var i in snapshot.docs) {
        a.add(PaymentItem.fromJson(i.data()));
      }
      print('완료');
    } catch (e) {
      print(e);
    }
  }

}