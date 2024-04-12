enum MultiEventType {
  limit,
  road;

  label() {
    switch (this) {
      case MultiEventType.limit:
        return 'Limite';
      case MultiEventType.road:
        return 'Caminho';
      default:
        return '';
    }
  }
}
