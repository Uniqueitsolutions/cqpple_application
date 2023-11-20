class PlumberService {
  String? serviceID;
  String? ratingID;
  String? problemID;
  String? problem;
  String? userID;
  String? serviceManID;
  String? serviceStatusID;
  String? status;
  String? complainNumber;
  String? beforeImagePath1;
  String? beforeVideopath2;
  String? afterImagePath1;
  String? afterVideoPath2;
  String? name;
  String? contactNumber;
  String? whatsappNumber;
  String? address;
  String? pincode;
  String? stateID;
  String? statename;
  String? cityID;
  String? cityname;
  String? description;
  String? created;
  String? modified;

  PlumberService(
      {this.serviceID,
      this.ratingID,
      this.problemID,
      this.problem,
      this.userID,
      this.serviceManID,
      this.serviceStatusID,
      this.status,
      this.complainNumber,
      this.beforeImagePath1,
      this.beforeVideopath2,
      this.afterImagePath1,
      this.afterVideoPath2,
      this.name,
      this.contactNumber,
      this.whatsappNumber,
      this.address,
      this.pincode,
      this.stateID,
      this.statename,
      this.cityID,
      this.cityname,
      this.description,
      this.created,
      this.modified});

  PlumberService.fromJson(Map<String, dynamic> json) {
    serviceID = json['ServiceID'];
    ratingID = json['RatingID'];
    problemID = json['ProblemID'];
    problem = json['Problem'];
    userID = json['UserID'];
    serviceManID = json['ServiceManID'];
    serviceStatusID = json['ServiceStatusID'];
    status = json['status'];
    complainNumber = json['ComplainNumber'];
    beforeImagePath1 = json['BeforeImagePath1'];
    beforeVideopath2 = json['BeforeVideopath2'];
    afterImagePath1 = json['AfterImagePath1'];
    afterVideoPath2 = json['AfterVideoPath2'];
    name = json['Name'];
    contactNumber = json['ContactNumber'];
    whatsappNumber = json['WhatsappNumber'];
    address = json['Address'];
    pincode = json['Pincode'];
    stateID = json['StateID'];
    statename = json['statename'];
    cityID = json['CityID'];
    cityname = json['cityname'];
    description = json['Description'];
    created = json['Created'];
    modified = json['Modified'];
  }
}
