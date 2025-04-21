class Receipt {
  final String receiptId;
  final String orderId;
  final int price;
  final int taxFree;
  final int cancelledPrice;
  final int cancelledTaxFree;
  final String orderName;
  final String companyName;
  final bool sandbox;
  final String pg;
  final String method;
  final String methodOriginSymbol;
  final DateTime purchasedAt;
  final DateTime requestedAt;
  final String statusLocale;
  final String currency;
  final String receiptUrl;
  final int status;
  final CardData cardData;

  Receipt({
    required this.receiptId,
    required this.orderId,
    required this.price,
    required this.taxFree,
    required this.cancelledPrice,
    required this.cancelledTaxFree,
    required this.orderName,
    required this.companyName,
    required this.sandbox,
    required this.pg,
    required this.method,
    required this.methodOriginSymbol,
    required this.purchasedAt,
    required this.requestedAt,
    required this.statusLocale,
    required this.currency,
    required this.receiptUrl,
    required this.status,
    required this.cardData,
  });

  factory Receipt.fromJson(Map<String, dynamic> json) {
    return Receipt(
      receiptId: json['receipt_id'] as String,
      orderId: json['order_id'] as String,
      price: json['price'] as int,
      taxFree: json['tax_free'] as int,
      cancelledPrice: json['cancelled_price'] as int,
      cancelledTaxFree: json['cancelled_tax_free'] as int,
      orderName: json['order_name'] as String,
      companyName: json['company_name'] as String,
      sandbox: json['sandbox'] as bool,
      pg: json['pg'] as String,
      method: json['method'] as String,
      methodOriginSymbol: json['method_origin_symbol'] as String,
      purchasedAt: DateTime.parse(json['purchased_at'] as String),
      requestedAt: DateTime.parse(json['requested_at'] as String),
      statusLocale: json['status_locale'] as String,
      currency: json['currency'] as String,
      receiptUrl: json['receipt_url'] as String,
      status: json['status'] as int,
      cardData: CardData.fromJson(json['card_data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'receipt_id': receiptId,
      'order_id': orderId,
      'price': price,
      'tax_free': taxFree,
      'cancelled_price': cancelledPrice,
      'cancelled_tax_free': cancelledTaxFree,
      'order_name': orderName,
      'company_name': companyName,
      'sandbox': sandbox,
      'pg': pg,
      'method': method,
      'method_origin_symbol': methodOriginSymbol,
      'purchased_at': purchasedAt.toIso8601String(),
      'requested_at': requestedAt.toIso8601String(),
      'status_locale': statusLocale,
      'currency': currency,
      'receipt_url': receiptUrl,
      'status': status,
      'card_data': cardData.toJson(),
    };
  }

  factory Receipt.empty() {
    return Receipt(
      receiptId: '',
      orderId: '',
      price: 0,
      taxFree: 0,
      cancelledPrice: 0,
      cancelledTaxFree: 0,
      orderName: '',
      companyName: '',
      sandbox: false,
      pg: '',
      method: '',
      methodOriginSymbol: '',
      purchasedAt: DateTime.now(),
      requestedAt: DateTime.now(),
      statusLocale: '',
      currency: '',
      receiptUrl: '',
      status: 0,
      cardData: CardData(
        tid: '',
        cardApproveNo: '',
        cardNo: '',
        cardQuota: '',
        cardCompanyCode: '',
        cardCompany: '',
        cardType: '',
      ),
    );
  }
}

class CardData {
  final String tid;
  final String cardApproveNo;
  final String cardNo;
  final String cardQuota;
  final String cardCompanyCode;
  final String cardCompany;
  final String cardType;

  CardData({
    required this.tid,
    required this.cardApproveNo,
    required this.cardNo,
    required this.cardQuota,
    required this.cardCompanyCode,
    required this.cardCompany,
    required this.cardType,
  });

  factory CardData.fromJson(Map<String, dynamic> json) {
    return CardData(
      tid: json['tid'] as String,
      cardApproveNo: json['card_approve_no'] as String,
      cardNo: json['card_no'] as String,
      cardQuota: json['card_quota'] as String,
      cardCompanyCode: json['card_company_code'] as String,
      cardCompany: json['card_company'] as String,
      cardType: json['card_type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tid': tid,
      'card_approve_no': cardApproveNo,
      'card_no': cardNo,
      'card_quota': cardQuota,
      'card_company_code': cardCompanyCode,
      'card_company': cardCompany,
      'card_type': cardType,
    };
  }

}
