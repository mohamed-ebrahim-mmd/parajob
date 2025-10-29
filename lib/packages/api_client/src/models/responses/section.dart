// import 'package:para_job/packages/api_client/src/models/responses/page_data.dart';

// class Section {
//   final int? id;
//   final PageData? page;
//   final String? title;
//   final String? content;
//   final String? icon;
//   final String? linkText;
//   final String? linkUrl;
//   final String? linkStyle;

//   Section({
//     this.id,
//     this.page,
//     this.title,
//     this.content,
//     this.icon,
//     this.linkText,
//     this.linkUrl,
//     this.linkStyle,
//   });

//   factory Section.fromJson(Map<String, dynamic> json) {
//     return Section(
//       id: json['id'],
//       page: json['page'] != null ? PageData.fromJson(json['page']) : null,
//       title: json['title'],
//       content: json['content'],
//       icon: json['icon'],
//       linkText: json['link_text'],
//       linkUrl: json['link_url'],
//       linkStyle: json['link_style'],
//     );
//   }
// }













import 'package:para_job/packages/api_client/src/models/responses/page_data.dart';

class Section {
  final int? id;
  final PageData? page;
  final String? title;
  final String? content;
  // final String? icon;
  // final String? linkText;
  // final String? linkUrl;
  // final String? linkStyle;
  // final List<dynamic>? children;
  // final List<dynamic>? images;
  // final List<dynamic>? sectionImages;

  Section({
    this.id,
    this.page,
    this.title,
    this.content,
    // this.icon,
    // this.linkText,
    // this.linkUrl,
    // this.linkStyle,
    // this.children,
    // this.images,
    // this.sectionImages,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      page:
          json['page'] != null ? PageData.fromJson(json['page']) : null,
      title: json['title'],
      content: json['content'],
      // icon: json['icon'],
      // linkText: json['link_text'],
      // linkUrl: json['link_url'],
      // linkStyle: json['link_style'],
      // children: json['children'] ?? [],
      // images: json['images'] ?? [],
      // sectionImages: json['sectionImages'] ?? [],
    );
  }

}

