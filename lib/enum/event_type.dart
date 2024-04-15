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
