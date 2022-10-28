import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_shopping_app/src/features/authentication/presentation/login/login_page_controller_provider.dart';
import 'package:sample_shopping_app/src/features/authentication/presentation/login/login_page_state.dart';
import 'package:sample_shopping_app/src/utils/async_value_ui.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  // TODO: remove initial value
  TextEditingController emailController =
      TextEditingController(text: "test@test.com");
  TextEditingController passwordController =
      TextEditingController(text: "12345678");
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<LoginPageState>>(loginPageControllerProvider,
        (_, next) {
      next.value?.value.showAlertDialogOnError(context,
          callback: () =>
              ref.read(loginPageControllerProvider.notifier).clearError());
    });

    final state = ref.watch(loginPageControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const Spacer(),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          const InputDecoration(hintText: "Mail address"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(hintText: "Password"),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  child: Text(state.value?.buttonText ?? ""),
                  onPressed: () {
                    ref
                        .read(loginPageControllerProvider.notifier)
                        .login(emailController.text, passwordController.text);
                  },
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  ref
                      .read(loginPageControllerProvider.notifier)
                      .switchLoginType();
                },
                child: Text(state.value?.switchButtonText ?? ""),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
