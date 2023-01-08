enum DeliveryStatus {
  undelivered(
    displayName: DeliveryStatusStr.undelivery,
  ),
  delivered(
    displayName: DeliveryStatusStr.delivered,
  );

  final String displayName;
  const DeliveryStatus({required this.displayName});

  DeliveryStatus fromDisplayName(String displayName) {
    if (displayName == DeliveryStatusStr.delivered) {
      return DeliveryStatus.delivered;
    }

    if (displayName == DeliveryStatusStr.undelivery) {
      return DeliveryStatus.undelivered;
    }

    throw Exception("DeliveryStatus parse error.");
  }
}

class DeliveryStatusStr {
  static const String undelivery = "未配達";
  static const String delivered = "配達済み";
}
