enum Type { confirmed, submissions, deadpool, all }

extension TypeExtension on Type {
  String getValue() {
    switch (this) {
      case Type.confirmed:
        return '';
      case Type.submissions:
        return 'submissions';
      case Type.deadpool:
        return 'deadpool';
      case Type.all:
        return 'all';
      default:
        return '';
    }
  }
}