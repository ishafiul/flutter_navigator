class Info {
  Info({List<String>? copyrights, int? took}) {
    if (copyrights != null) {
      this.copyrights = copyrights;
    }
    if (took != null) {
      this.took = took;
    }
  }

  Info.fromJson(Map<String, dynamic> json) {
    copyrights = json['copyrights'] as List<String>;
    took = json['took'] as int;
  }
  List<String>? copyrights;
  int? took;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['copyrights'] = copyrights;
    data['took'] = took;
    return data;
  }
}
