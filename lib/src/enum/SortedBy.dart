enum SortedBy {
  newest,
  oldest,
  views,
  chronological,
  reverse_chronological,
  comments,
  images,
  videos
}

extension SortedByExtension on SortedBy {
  String getValue() {
    switch (this) {
      case SortedBy.newest:
        return '';
      case SortedBy.oldest:
        return '?sort=oldest';
      case SortedBy.views:
        return '?sort=views';
      case SortedBy.chronological:
        return '?sort=chronological';
      case SortedBy.reverse_chronological:
        return '?sort=reverse_chronological';
      case SortedBy.comments:
        return '?sort=comments';
      case SortedBy.images:
        return '?sort=images';
      case SortedBy.videos:
        return '?sort=videos';
      default:
        return '';
    }
  }
}