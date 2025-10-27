

import 'package:para_job/packages/api_client/src/models/responses/contact_us_info_data.dart';

class ContactUsInfoResponse {
  final ContactUsInfoData? data;
 final bool isSuccess;
 

  ContactUsInfoResponse({
    this.data,required this.isSuccess
   
    
  });

  factory ContactUsInfoResponse.fromJson(Map<String, dynamic> json) {
    return ContactUsInfoResponse(
      data: json['data'] != null
          ? ContactUsInfoData.fromJson(json['data'])
          : null,
      isSuccess: json['is_success'],
     
    );
  }


}


