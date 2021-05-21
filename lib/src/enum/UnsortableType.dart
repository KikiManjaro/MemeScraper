enum UnsortableType { researching, newsworthy, popular }

extension UnsortableTypeExtension on UnsortableType {
  String getValue() {
    switch (this) {
      case UnsortableType.researching:
        return 'researching';
      case UnsortableType.newsworthy:
        return 'newsworthy';
      case UnsortableType.popular:
        return 'popular';
      default:
        return '';
    }
  }
}