import 'package:flutter/material.dart';

typedef SuccessBuilder<T> = Widget Function(BuildContext context, T data);
typedef FailureBuilder = Widget Function(BuildContext context);
typedef EmptyBuilder = Widget Function(BuildContext context);
typedef LoadingBuilder = Widget Function(BuildContext context);

class CustomFutureBuilder<T> extends StatelessWidget {
  const CustomFutureBuilder({
    super.key,
    required this.future,
    required this.successBuilder,
    this.failureBuilder,
    this.emptyBuilder,
    this.loadingBuilder,
  });
  final Future<T>? future;
  final SuccessBuilder<T> successBuilder;
  final FailureBuilder? failureBuilder;
  final EmptyBuilder? emptyBuilder;
  final LoadingBuilder? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        final status = snapshot.connectionState;
        final data = snapshot.data;

        // Loading
        if (status == ConnectionState.waiting) {
          return loadingBuilder?.call(context) ??
              const Center(child: CircularProgressIndicator());
        }

        // Failure
        if (snapshot.hasError) {
          return failureBuilder?.call(context) ?? const Text("Error");
        }

        // Empty
        if (!snapshot.hasData) {
          return emptyBuilder?.call(context) ?? const Text("Empty");
        }

        // Success
        return successBuilder.call(context, data as T);
      },
    );
  }
}
