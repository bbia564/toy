class ToyModel {
  int? id;
  String? name;
  String? photo;
  int? status;
  double? price;
  String? localPhoto;
  String? createTime;

  ToyModel(
      {this.id,
      this.name,
      this.photo,
      this.price,
      this.status,
      this.localPhoto,
      this.createTime});

  ToyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    price = json['price'];
    status = json['status'];
    createTime = json['createTime'];
    localPhoto = json['localPhoto'];
  }
}

class PlanModel {
  int? id;
  int? tID;
  String? name;
  String? photo;
  int? status;
  double? price;
  String? localPhoto;
  String? createTime;

  PlanModel(
      {this.id,
      this.name,
      this.photo,
      this.price,
      this.status,
      this.localPhoto,
      this.createTime});

  PlanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tID = json['tID'];
    name = json['name'];
    photo = json['photo'];
    price = json['price'];
    status = json['status'];
    createTime = json['createTime'];
    localPhoto = json['localPhoto'];
  }
}
