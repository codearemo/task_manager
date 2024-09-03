import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/router/app_route_names.dart';
import 'package:task_manager/core/theme/app_parllete.dart';
import 'package:task_manager/core/ui/widgets/app_gradient_button.dart';
import 'package:task_manager/core/ui/widgets/app_input.dart';
import 'package:task_manager/core/ui/widgets/feedback/app_snackbar.dart';
import 'package:task_manager/core/utils/form_validators.dart';
import 'package:task_manager/modules/auth/domain/usecases/signin_with_email_usecase.dart';
import 'package:task_manager/modules/auth/presentation/bloc/auth_module_bloc.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({
    super.key,
  });

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AuthModuleBloc, AuthModuleState>(
            listener: (context, state) {
              if (state is SignInWithEmailError) {
                return AppSnackBars.primarySnackbar(
                  context: context,
                  message: state.message,
                  backgroundColor: AppPallete.errorColor,
                );
              } else if (state is SignInWithEmailSuccess) {
                context.go(AppRoutesNames.allTasks);
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    const Text(
                      'Sign In. ',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppInput(
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      textCapitalization: TextCapitalization.none,
                      validator: AppFormValidator.validateEmail,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppInput(
                      hintText: 'Password',
                      controller: passwordController,
                      textCapitalization: TextCapitalization.none,
                      obscureText: true,
                      validator: (String? value) {
                        return AppFormValidator.validateField(
                            value, 'Password');
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppGradientButton(
                      loading: state is SignInWithEmailLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          context.read<AuthModuleBloc>().add(
                                SignInWithEmailEvent(
                                  params: AuthOpParams(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                ),
                              );
                        }
                      },
                      child: const Text('Sign In',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go(AppRoutesNames.signup);
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
