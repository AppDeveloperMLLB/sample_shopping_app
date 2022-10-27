import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/constants/app_sizes.dart';
import 'package:sample_shopping_app/src/features/authentication/presentation/acount/account_page_controller.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(accountPageControllerProvider);
    final currentUser =
        ref.read(accountPageControllerProvider.notifier).getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currentUser?.email ?? "",
                style: TextStyle(fontSize: 24),
              ),
              gapH8,
              ElevatedButton(
                onPressed: state.isLoading ? null : () => _logout(ref),
                child: const Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logout(WidgetRef ref) {
    ref.read(accountPageControllerProvider.notifier).logout();
  }
}
