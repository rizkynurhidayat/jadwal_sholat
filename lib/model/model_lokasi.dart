class lokasiKu {
  String? lokasi;
  String? id;

  lokasiKu({this.id, this.lokasi});

  lokasiKu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lokasi = json['lokasi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lokasi'] = this.lokasi;
    return data;
  }
}
