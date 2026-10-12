class DiameterClass {
  Diameter? diameter;

  DiameterClass({this.diameter});

  DiameterClass.fromJson(Map<String, dynamic> json) {
    diameter =
        json['diameter'] != null ? Diameter.fromJson(json['diameter']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (diameter != null) {
      data['diameter'] = diameter!.toJson();
    }

    return data;
  }
}

class Diameter {
  int? id;
  List? needlesFront;
  List? needlesback;
  bool? concentricFront;
  bool? concentricBack;
  bool? frontFlag;
  bool? backFlag;
  String? front;
  String? back;
  double? frontInnerDiameter;
  double? frontExternalDiameter;
  double? backInnerDiameter;
  double? backExternalDiameter;
  String? date;
  int? user;
  double? frontInnerDistance;
  double? outerFrontDistance;
  double? innerFrontError;
  double? outerFrontError;
  double? centerFrontDistance;
  double? centerFrontError;
  double? innerBackDistance;
  double? outerBackDistance;
  double? innerBackError;
  double? outerBackError;
  double? centerBackDistance;
  double? centerBackError;
  bool? finalFlag;

  Diameter({
    this.id,
    this.needlesFront,
    this.needlesback,
    this.concentricFront,
    this.concentricBack,
    this.frontFlag,
    this.backFlag,
    this.front,
    this.back,
    this.frontInnerDiameter,
    this.frontExternalDiameter,
    this.backInnerDiameter,
    this.backExternalDiameter,
    this.date,
    this.user,
    this.frontInnerDistance,
    this.outerFrontDistance,
    this.innerFrontError,
    this.outerFrontError,
    this.centerFrontDistance,
    this.centerFrontError,
    this.innerBackDistance,
    this.outerBackDistance,
    this.innerBackError,
    this.outerBackError,
    this.centerBackDistance,
    this.centerBackError,
    this.finalFlag,
  });

  Diameter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    frontFlag = json['flag_front'];
    backFlag = json['flag_back'];
    front = json['front'];
    back = json['back'];
    frontInnerDiameter = json['inner_front_diameter'];
    frontExternalDiameter = json['external_front_diameter'];
    backInnerDiameter = json['inner_back_diameter'];
    backExternalDiameter = json['external_back_diameter'];
    date = json['date'];
    user = json['user'];
    needlesFront = json["needles_front_list"];
    needlesback = json["needles_back_list"];
    concentricFront = json["concentric_front"];
    concentricBack = json["concentric_back"];
    frontInnerDistance = json["inner_front_distance"];
    outerFrontDistance = json["outer_front_distance"];
    innerFrontError = json["inner_front_error"];
    outerFrontError = json["outer_front_error"];
    centerFrontDistance = json["center_front_distance"];
    centerFrontError = json["center_front_error"];
    innerBackDistance = json["inner_back_distance"];
    outerBackDistance = json["outer_back_distance"];
    innerBackError = json["inner_back_error"];
    outerBackError = json["outer_back_error"];
    centerBackDistance = json["center_back_distance"];
    centerBackError = json["center_back_error"];

    finalFlag = json["final_flag"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['frontFlag'] = frontFlag;
    data['backFlag'] = backFlag;
    data['front'] = front;
    data['back'] = back;
    data['inner_front_diameter'] = frontInnerDiameter;
    data['external_front_diameter'] = frontExternalDiameter;
    data['inner_back_diameter'] = backInnerDiameter;
    data['external_back_diameter'] = backExternalDiameter;
    data['date'] = date;
    data['user'] = user;
    return data;
  }
}
