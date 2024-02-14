class orders {
  final int? orderId;
  final String orderCode;
  final String orderStatus;

  orders({
    this.orderId,
    required this.orderCode,
    required this.orderStatus,
  });

  factory orders.fromMap(Map<String, dynamic> json) => orders(
        orderId: json["orderId "],
        orderCode: json["orderCode "],
        orderStatus: json["orderStatus "],
      );

  Map<String, dynamic> toMap() => {
        "orderId ": orderId,
        "orderCode ": orderCode,
        "orderStatus ": orderStatus,
      };
}
