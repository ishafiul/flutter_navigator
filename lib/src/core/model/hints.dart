class Hints {
  Hints({int? visitedNodesSum, int? visitedNodesAverage}) {
    if (visitedNodesSum != null) {
      this.visitedNodesSum = visitedNodesSum;
    }
    if (visitedNodesAverage != null) {
      this.visitedNodesAverage = visitedNodesAverage;
    }
  }

  Hints.fromJson(Map<String, dynamic> json) {
    visitedNodesSum = json['visited_nodes.sum'] as int;
    visitedNodesAverage = json['visited_nodes.average'] as int;
  }
  int? visitedNodesSum;
  int? visitedNodesAverage;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['visited_nodes.sum'] = visitedNodesSum;
    data['visited_nodes.average'] = visitedNodesAverage;
    return data;
  }
}
