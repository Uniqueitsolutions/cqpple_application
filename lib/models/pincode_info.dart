class PincodeInfo {
  String? name;
  String? description;
  String? branchType;
  String? deliveryStatus;
  String? circle;
  String? district;
  String? division;
  String? region;
  String? block;
  String? state;
  String? country;
  String? pincode;

  PincodeInfo(
      {this.name,
      this.description,
      this.branchType,
      this.deliveryStatus,
      this.circle,
      this.district,
      this.division,
      this.region,
      this.block,
      this.state,
      this.country,
      this.pincode});

  PincodeInfo.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    description = json['Description'];
    branchType = json['BranchType'];
    deliveryStatus = json['DeliveryStatus'];
    circle = json['Circle'];
    district = json['District'];
    division = json['Division'];
    region = json['Region'];
    block = json['Block'];
    state = json['State'];
    country = json['Country'];
    pincode = json['Pincode'];
  }
}
