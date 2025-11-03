


import 'package:para_job/packages/api_client/src/models/responses/section.dart';

class AboutUsData {
  final int? id;
  final String? title;
  final String? content;
 // final String? imageUrl;
  final List<Section>? sections;

  AboutUsData({
    this.id,
    this.title,
    this.content,
   // this.imageUrl,
    this.sections,
  });

  factory AboutUsData.fromJson(Map<String, dynamic> json) {
    return AboutUsData(
      id: json['id'],
      title: json['title'],
      content: json['content'],
     // imageUrl: json['image_url'],
      sections: json['sections'] != null
          ? List<Section>.from(
              json['sections'].map((x) => Section.fromJson(x)))
          : [],
    );
  }


}
