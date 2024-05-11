enum EventType {
  place,
  temp;

  label() {
    switch (this) {
      case EventType.place:
        return 'Place';
      case EventType.temp:
        return 'Temp';
      default:
        return '';
    }
  }

  readableLabel() {
    switch (this) {
      case EventType.place:
        return 'Local';
      case EventType.temp:
        return 'Local Temporário';
      default:
        return '';
    }
  }

  fromLabel(String label) {
    switch (label) {
      case 'Place':
        return EventType.place;
      case 'Temp':
        return EventType.temp;
      default:
        return null;
    }
  }
}
