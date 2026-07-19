import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analysis_server_plugin/edit/dart/dart_fix_kind_priority.dart';
import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';

const String _name = 'require_sizes_prefix_import';

class SizesImportRule extends AnalysisRule {
  static const LintCode code = LintCode(
    _name,
    "Imports of 'sizes.dart' must be prefixed with 'as soco_sizes'.",
    correctionMessage: "Change the import to: import '{0}' as soco_sizes;",
    uniqueName: 'LintCode.$_name',
    // Sets diagnostic severity to WARNING so the file displays a warning in the IDE
    // and the rule appears in `flutter analyze` output.
    severity: DiagnosticSeverity.WARNING,
  );

  SizesImportRule()
      : super(
          name: _name,
          description: "Imports of 'sizes.dart' must be prefixed with 'as soco_sizes'.",
        );

  @override
  DiagnosticCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(RuleVisitorRegistry registry, RuleContext context) {
      var visitor = _Visitor(this);
      registry.addImportDirective(this, visitor);
    }
}

class _Visitor extends SimpleAstVisitor<void> {
  final AnalysisRule rule;

  _Visitor(this.rule);

  @override
  void visitImportDirective(ImportDirective node) {
    final uriContent = node.uri.stringValue;
    if (uriContent != null && uriContent.contains('styles/sizes.dart')) {
      final prefix = node.prefix?.name;
      if (prefix != 'soco_sizes') {
        rule.reportAtNode(node, arguments: [uriContent]);
      }
    }
  }
}

/// A quick fix that adds the prefix `as soco_sizes` to imports of `sizes.dart`
/// and prepends `soco_sizes.` to all of its imported references within the file.
class SizesImportFix extends ResolvedCorrectionProducer {
  /// Creates a [SizesImportFix] with the given [context].
  SizesImportFix({required super.context});

  @override
  CorrectionApplicability get applicability => CorrectionApplicability.singleLocation;

  @override
  FixKind get fixKind => const FixKind(
        'soco_lints.fix.$_name',
        DartFixKindPriority.standard,
        "Change import to use prefix 'as soco_sizes' and update references",
      );

  @override
  Future<void> compute(ChangeBuilder builder) async {
    final importDirective = node;
    if (importDirective is! ImportDirective) return;

    // Get the semantic library element of sizes.dart
    final importedLibrary = importDirective.libraryImport?.importedLibrary;
    if (importedLibrary == null) return;

    // Find all usages of elements from sizes.dart in this file
    final visitor = _IdentifierVisitor(importedLibrary);
    unit.accept(visitor);

    await builder.addDartFileEdit(file, (builder) {
      // 1. Update the import directive with the prefix
      final prefix = importDirective.prefix;
      if (prefix != null) {
        builder.addSimpleReplacement(
          SourceRange(prefix.offset, prefix.length),
          'soco_sizes',
        );
      } else {
        final uriEnd = importDirective.uri.end;
        builder.addSimpleInsertion(uriEnd, ' as soco_sizes');
      }

      // 2. Prepend 'soco_sizes.' to all matching references
      for (final identifier in visitor.targetIdentifiers) {
        builder.addSimpleInsertion(identifier.offset, 'soco_sizes.');
      }
    });
  }
}

/// A visitor that scans the AST to find all references to symbols defined
/// inside [importedLibrary].
class _IdentifierVisitor extends RecursiveAstVisitor<void> {
  /// The library that we are checking references against.
  final LibraryElement importedLibrary;

  /// Collected list of AST identifiers that need prefixing.
  final List<SimpleIdentifier> targetIdentifiers = [];

  /// Creates an [_IdentifierVisitor] for the specified [importedLibrary].
  _IdentifierVisitor(this.importedLibrary);

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    // Ignore identifiers that declare a new name (e.g. var definitions)
    if (node.inDeclarationContext()) return;

    final element = node.element;
    if (element != null && element.library == importedLibrary) {
      final parent = node.parent;

      // Ignore if it's the right-hand side of a prefix (e.g., `some_prefix.spacing`)
      if (parent is PrefixedIdentifier && parent.identifier == node) {
        return;
      }

      // Ignore if it's a property access target member (e.g., `target.property`)
      if (parent is PropertyAccess && parent.propertyName == node) {
        return;
      }

      // Ignore if it's a method invocation member (e.g., `target.method()`)
      if (parent is MethodInvocation && parent.methodName == node && parent.target != null) {
        return;
      }

      // Ignore import/export directives
      if (parent is ImportDirective || parent is ExportDirective) {
        return;
      }

      targetIdentifiers.add(node);
    }
    super.visitSimpleIdentifier(node);
  }
}