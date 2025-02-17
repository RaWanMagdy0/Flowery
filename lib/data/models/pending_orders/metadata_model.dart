class MetadataModel {
  final int? currentPage;
  final int? numberOfPages;
  final int? limit;

  MetadataModel({
    this.currentPage,
    this.numberOfPages,
    this.limit,
  });

  factory MetadataModel.fromJson(Map<String, dynamic> json) {
    return MetadataModel(
      currentPage: json['currentPage'],
      numberOfPages: json['numberOfPages'],
      limit: json['limit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'numberOfPages': numberOfPages,
      'limit': limit,
    };
  }
}
