

import 'package:para_job/packages/api_client/src/models/responses/contact_info_data.dart';

class ContactInfoResponse {
  final ContactInfoData? data;
 final bool isSuccess;
 

  ContactInfoResponse({
    this.data,required this.isSuccess
   
    
  });

  factory ContactInfoResponse.fromJson(Map<String, dynamic> json) {
    return ContactInfoResponse(
      data: json['data'] != null
          ? ContactInfoData.fromJson(json['data'])
          : null,
      isSuccess: json['is_success'],
     
    );
  }


}


