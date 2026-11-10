class MaterialItem {
  const MaterialItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.condition,
    required this.region,
    required this.collectionPoint,
    required this.donorName,
    required this.imageUrl,
    this.status = MaterialStatus.available,
    this.reservedByMe = false,
    this.isMine = false,
    this.isFavorite = false,
  });

  final String id;
  final String title;
  final String description;
  final String category;
  final String condition;
  final String region;
  final String collectionPoint;
  final String donorName;
  final String imageUrl;
  final MaterialStatus status;
  final bool reservedByMe;
  final bool isMine;
  final bool isFavorite;

  MaterialItem copyWith({
    String? title,
    String? description,
    String? category,
    String? condition,
    String? region,
    String? collectionPoint,
    MaterialStatus? status,
    bool? reservedByMe,
    bool? isFavorite,
  }) =>
      MaterialItem(
        id: id,
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        condition: condition ?? this.condition,
        region: region ?? this.region,
        collectionPoint: collectionPoint ?? this.collectionPoint,
        donorName: donorName,
        imageUrl: imageUrl,
        status: status ?? this.status,
        reservedByMe: reservedByMe ?? this.reservedByMe,
        isMine: isMine,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}

enum MaterialStatus { available, reserved, delivered }

extension MaterialStatusLabel on MaterialStatus {
  String get label => switch (this) {
        MaterialStatus.available => 'Disponível',
        MaterialStatus.reserved => 'Reservado',
        MaterialStatus.delivered => 'Entregue',
      };
}
