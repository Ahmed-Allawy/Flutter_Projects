class Prediction {
  final String? boundingBox;
  final double probability;
  final String? tagId;
  final String tagName;

  Prediction({
    this.boundingBox,
    required this.probability,
    this.tagId,
    required this.tagName,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      boundingBox: json['boundingBox'],
      probability: json['probability'].toDouble(),
      tagId: json['tagId'],
      tagName: json['tagName'],
    );
  }
}

class ApiModel {
  final String created;
  final String id;
  final String iteration;
  final List<Prediction> predictions;
  final String project;

  ApiModel({
    required this.created,
    required this.id,
    required this.iteration,
    required this.predictions,
    required this.project,
  });

  factory ApiModel.fromJson(Map<String, dynamic> json) {
    return ApiModel(
      created: json['created'],
      id: json['id'],
      iteration: json['iteration'],
      predictions: List<Prediction>.from(
          json['predictions'].map((x) => Prediction.fromJson(x))),
      project: json['project'],
    );
  }
}
