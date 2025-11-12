class CompanyComplaintRequest {
  final int companyId;
  final String details;

  CompanyComplaintRequest({
    required this.companyId,
    required this.details
  });

  Map<String, dynamic> toJson() {
    return {'company_id': companyId, 'details':details};
  }
}

