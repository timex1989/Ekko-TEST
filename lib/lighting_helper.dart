class LightingHelper {
  static String getStyleUri() {
    int hour = DateTime.now().hour;

    if (hour >= 6 && hour < 18) {
      return 'mapbox://styles/timex1989/cm8xutstu004c01quaxdu51xd'; // 🔴 Day
    } else if (hour >= 18 && hour < 20) {
      return 'mapbox://styles/timex1989/cm8xuzcbc005401s3hv4kbbk1'; // 🔴 Dusk
    } else if (hour >= 4 && hour < 6) {
      return 'mapbox://styles/timex1989/cm8xuunqm004h01qs7yergpsv'; // 🔴 Dawn
    } else {
      return 'mapbox://styles/timex1989/cm8xusfw9004g01qs5ns6b9y4'; // 🔴 Night
    }
  }
}
