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
}
