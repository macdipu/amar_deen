/// Human-readable cardinal direction for a bearing in degrees (0-360, 0 = north).
String getDirectionText(int angle) {
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
