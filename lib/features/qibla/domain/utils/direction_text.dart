/// Cardinal direction key for a bearing in degrees (0-360, 0 = north).
/// Pure domain logic - returns a stable English key, not a display string;
/// the presentation layer maps this to a localized label.
String getDirectionKey(int angle) {
  if (angle > 0 && angle < 90) {
    return 'North-East';
  }
  if (angle > 90 && angle < 180) {
    return 'South-East';
  }
  if (angle > 180 && angle < 270) {
    return 'South-West';
  }
  if (angle > 270 && angle < 360) {
    return 'North-West';
  }

  switch (angle) {
    case 0:
      return 'North';
    case 90:
      return 'East';
    case 180:
      return 'South';
    case 270:
      return 'West';
    case 360:
      return 'North';
    default:
      return '';
  }
}
