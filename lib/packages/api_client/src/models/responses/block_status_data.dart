//Mary Mark ||  mary.mark@moselaymd.com || Thu Nov 20 2025 14:22:18

class BlockStatusData {
  final bool? isBlocked;

  BlockStatusData({this.isBlocked});

  factory BlockStatusData.fromJson(Map<String, dynamic> json) {
    return BlockStatusData(
      isBlocked: json['is_blocked'],
    );
  }

}