class ParameterClass {
  Parameter? parameter;
  bool? flag;

  ParameterClass({this.parameter, this.flag});

  ParameterClass.fromJson(Map<String, dynamic> json) {
    parameter = json['parameter'] != null
        ? Parameter.fromJson(json['parameter'])
        : null;
    flag = json["flag"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (parameter != null) {
      data['parameter'] = parameter!.toJson();
    }
    data['flag'] = flag;
    return data;
  }
}

class Parameter {
  int? id;
  String? image;
  double? widthResult;
  double? heightResult;
  String? date;
  int? user;

  Parameter(
      {this.id,
      this.image,
      this.widthResult,
      this.heightResult,
      this.date,
      this.user});

  Parameter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    widthResult = json['width_result'];
    heightResult = json['height_result'];
    date = json['date'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['width_result'] = widthResult;
    data['height_result'] = heightResult;
    data['date'] = date;
    data['user'] = user;
    return data;
  }
}
