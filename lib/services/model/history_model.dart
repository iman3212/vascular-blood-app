class VeinModel {
  final int? id;
  final String? front;
  final String? back;
  final String? next;
  final String? previous;
  final int? count;
  final List? needlesFront;
  final List? needlesBack;
  final bool? flagFront;
  final bool? flagBack;
  final bool? concentricFront;
  final bool? concentricBack;
  var results;
  var widthResult;
  var heightResult;
  var innerFrontDiameter;
  var externalFrontDiameter;
  var innerBackDiameter;
  var externalBackDiameter;

  final dynamic date;
  final dynamic user;
  final String?
      key; // New field to track if it's from "diameter" or "parameter"

  VeinModel({
    this.id,
    this.next,
    this.back,
    this.needlesFront,
    this.needlesBack,
    this.previous,
    this.count,
    this.front,
    this.results,
    this.widthResult,
    this.heightResult,
    this.innerFrontDiameter,
    this.innerBackDiameter,
    this.externalFrontDiameter,
    this.externalBackDiameter,
    this.concentricFront,
    this.concentricBack,
    this.flagFront,
    this.flagBack,
    this.date,
    this.user,
    this.key, // Initialize the key
  });

  factory VeinModel.fromJson(Map<String, dynamic> json, String key) {
    return VeinModel(
      id: json['id'],
      front: json['front'],
      back: json['back'],
      needlesFront: json['needles_front_list'],
      needlesBack: json['needles_back_list'],
      results: json['results'],
      next: json['next'],
      previous: json['previous'],
      count: json['count'],
      widthResult: json['width_result'],
      heightResult: json['height_result'],
      innerFrontDiameter: json['inner_front_diameter'],
      innerBackDiameter: json['inner_back_diameter'],
      externalBackDiameter: json['external_back_diameter'],
      externalFrontDiameter: json['external_front_diameter'],
      flagFront: json['flag_front'],
      flagBack: json['flag_back'],
      concentricFront: json['concentric_front'],
      concentricBack: json['concentric_back'],
      date: json['date'],
      user: json['user'],
      key: key, // Assign the key (either "diameter" or "parameter")
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": front,
        "count": count,
        "next": next,
        "previous": previous,
        "results": results,
        "width_result": widthResult,
        "height_result": heightResult,
        "inner_diameter": innerFrontDiameter,
        "external_diameter": externalFrontDiameter,
        "date": date,
        "user": user,
        "key": key, // Include key in the toJson method
      };
}
