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

  fromLabel(String label) {
    switch (label) {
      case 'Limite':
        return MultiEventType.limit;
      case 'Caminho':
        return MultiEventType.road;
      default:
        return null;
    }
  }
}
