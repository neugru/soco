import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';

import 'package:soco_lints/rules.dart';

final plugin = SocoLintPlugin();

class SocoLintPlugin extends Plugin {
  @override
  String get name => 'soco_lints';

  @override
  void register(PluginRegistry registry) {
    registry.registerWarningRule(SizesImportRule());
    registry.registerFixForRule(SizesImportRule.code, SizesImportFix.new);
  }
}
