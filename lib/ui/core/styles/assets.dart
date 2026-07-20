abstract class AppAsset {
  final String path;
  const AppAsset(this.path);
}

class SvgAsset extends AppAsset {
  const SvgAsset(super.path);
}

class RasterAsset extends AppAsset {
  const RasterAsset(super.path);
}

class AudioAsset extends AppAsset {
  const AudioAsset(super.path);
}

class FontAsset extends AppAsset {
  const FontAsset(super.path);
}

class SocoAssets {
  SocoAssets._();

  // Global assets list
  static const sleepyBean = SvgAsset('assets/images/sleepy_bean.svg');
  static const sleepyCoffeeDark = RasterAsset('assets/images/sleepy_coffee_dark.png');
  static const sleepyCoffeeLight = RasterAsset('assets/images/sleepy_coffee_light.png');
}
