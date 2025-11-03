



class PageData {
  final String? pageTitle;
  final int? pageId;

  PageData({
    this.pageTitle,
    this.pageId,
  });

  factory PageData.fromJson(Map<String, dynamic> json) {
    return PageData(
      pageTitle: json['pageTitle'],
      pageId: json['page_id'],
    );
  }

}
