import 'package:flutter/material.dart';
import 'package:happyco/core/ui/dialogs/app_dialog.dart';
import 'package:happyco/core/ui/dialogs/dialog_config.dart';
import 'package:happyco/core/ui/dialogs/dialog_type.dart';

/// Dialog Service for Happyco App
///
/// Provides a centralized way to manage dialogs with:
/// - Lifecycle management (proper disposal)
/// - Dialog stacking (multiple dialogs on top of each other)
/// - Global access via GetIt service locator
/// - Type-safe dialog configuration
///
/// Usage:
/// ```dart
/// final dialogService = getIt<DialogService>();
///
/// // Show dialog
/// await dialogService.show(DialogType.login);
///
/// // Show with result
/// final result = await dialogService.show<bool>(DialogType.confirmation);
///
/// // Close top dialog
/// dialogService.close();
///
/// // Close all dialogs
/// dialogService.closeAll();
/// ```
class DialogService {
  /// Global key for accessing navigator state from anywhere
  final GlobalKey<NavigatorState> _navigatorKey;

  /// Stack of currently open dialogs
  final List<DialogEntry> _dialogStack = [];

  DialogService(this._navigatorKey);

  /// Get current context from navigator key
  BuildContext? get context => _navigatorKey.currentContext;

  /// Get number of open dialogs
  int get openDialogsCount => _dialogStack.length;

  /// Check if any dialogs are open
  bool get hasOpenDialogs => _dialogStack.isNotEmpty;

  /// Show a dialog by type
  ///
  /// Returns the result from the dialog (if any)
  Future<T?> show<T>(DialogType type, {DialogConfig? config}) async {
    if (context == null) {
      debugPrint('DialogService: No context available');
      return null;
    }

    final dialogConfig = config ?? DialogConfig.getDefault(type);

    final entry = DialogEntry(
      type: type,
      config: dialogConfig,
      timestamp: DateTime.now(),
    );
    _dialogStack.add(entry);

    debugPrint('DialogService: Opening dialog $type (stack size: ${_dialogStack.length})');

    final completer = Completer<T?>();

    final result = await showDialog<T>(
      context: context!,
      barrierDismissible: dialogConfig.barrierDismissible,
      barrierColor: dialogConfig.barrierColor,
      builder: (dialogContext) => AppDialog(
        type: type,
        config: dialogConfig,
        onDismiss: () {
          _removeDialog(entry);
          Navigator.of(dialogContext).pop();
        },
      ),
    );

    _removeDialog(entry);

    completer.complete(result);

    debugPrint('DialogService: Dialog $type closed with result: $result');

    return result;
  }

  /// Show dialog and push to stack (without waiting for result)
  void push(DialogType type, {DialogConfig? config}) {
    show(type, config: config);
  }

  /// Close the top-most dialog
  void close<T>([T? result]) {
    if (_dialogStack.isEmpty) {
      debugPrint('DialogService: No dialogs to close');
      return;
    }

    final entry = _dialogStack.last;
    debugPrint('DialogService: Closing dialog ${entry.type}');

    if (context != null) {
      Navigator.of(context!).pop(result);
    }

    _removeDialog(entry);
  }

  /// Close all dialogs (clear entire stack)
  void closeAll() {
    if (_dialogStack.isEmpty) return;

    debugPrint('DialogService: Closing all dialogs (${_dialogStack.length})');

    if (context != null) {
      Navigator.of(context!).popUntil((route) => route.isFirst);
    }

    _dialogStack.clear();
  }

  /// Close a specific dialog type (removes it from stack)
  void closeType(DialogType type) {
    final index = _dialogStack.indexWhere((e) => e.type == type);
    if (index == -1) {
      debugPrint('DialogService: Dialog $type not found in stack');
      return;
    }

    final entry = _dialogStack[index];
    _removeDialog(entry);

    // If it's not the top dialog, we need to pop to it first
    if (index != _dialogStack.length) {
      if (context != null) {
        Navigator.of(context!).popUntil((route) => route.isFirst);
      }
    }
  }

  /// Replace current dialog with a new one (swaps dialogs without closing underlying ones)
  Future<T?> replace<T>(DialogType newType, {DialogConfig? config}) async {
    if (_dialogStack.isEmpty) {
      return show<T>(newType, config: config);
    }

    debugPrint('DialogService: Replacing dialog with $newType');

    close();

    return show<T>(newType, config: config);
  }

  /// Check if a specific dialog type is currently open
  bool isOpen(DialogType type) {
    return _dialogStack.any((e) => e.type == type);
  }

  /// Get the top-most dialog type
  DialogType? get topDialog => _dialogStack.lastOrNull?.type;

  /// Remove dialog from stack
  void _removeDialog(DialogEntry entry) {
    final removed = _dialogStack.remove(entry);
    if (removed) {
      debugPrint('DialogService: Removed dialog ${entry.type} from stack');
    }
  }

  /// Dispose all resources (call when app is closing)
  void dispose() {
    closeAll();
  }
}

/// Entry in dialog stack
class DialogEntry {
  final DialogType type;
  final DialogConfig config;
  final DateTime timestamp;

  DialogEntry({
    required this.type,
    required this.config,
    required this.timestamp,
  });

  @override
  String toString() =>
      'DialogEntry(type: $type, timestamp: $timestamp)';
}

/// Completer for async dialog results
typedef Completer<T> = _Completer<T>;

class _Completer<T> {
  T? _result;
  bool _completed = false;

  void complete(T? result) {
    if (_completed) return;
    _result = result;
    _completed = true;
  }

  T? get result => _result;
  bool get isCompleted => _completed;
}
