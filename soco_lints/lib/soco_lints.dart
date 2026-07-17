import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

PluginBase createPlugin() => _SocoLintsPlugin();

class _SocoLintsPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        _RequireSizesPrefixImport(),
      ];
}

class _RequireSizesPrefixImport extends DartLintRule {
  const _RequireSizesPrefixImport() : super(code: _code);

  static const _code = LintCode(
    name: 'require_sizes_prefix_import',
    problemMessage: "Imports of 'sizes.dart' must be prefixed with 'as soco_sizes'.",
    correctionMessage: "Change the import to: import 'package:soco/ui/core/styles/sizes.dart' as soco_sizes;",
    // ignore: deprecated_member_use
    errorSeverity: ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addImportDirective((node) {
      final uri = node.uri.stringValue;
      if (uri != null && uri.contains('styles/sizes.dart')) {
        final prefix = node.prefix?.name;
        if (prefix != 'soco_sizes') {
          reporter.atNode(node, code);
        }
      }
    });
  }
}
