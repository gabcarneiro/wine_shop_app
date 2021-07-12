import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/auth/sign_in_form/bloc/sign_in_form_bloc.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSucessOption.fold(
            () {},
            (either) => either.fold(
                  (failure) {
                    FlushbarHelper.createError(
                      message: failure.map(
                        cancelledByUser: (_) => 'Cancelled',
                        serverError: (_) => 'Server Error',
                        emailAlreadyInUse: (_) => 'Email already in use',
                        invalidEmailAndPasswordCombination: (_) =>
                            'Invalid email and password combination',
                      ),
                    ).show(context);
                  },
                  (_) {
                    // TODO: navigate
                  },
                ));
      },
      builder: (context, state) {
        final bloc = BlocProvider.of<SignInFormBloc>(context);

        return Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Form(
            autovalidateMode: state.showErrorMessages
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email',
                  ),
                  autocorrect: false,
                  onChanged: (value) => bloc.add(
                    SignInFormEvent.emailChanged(value),
                  ),
                  validator: (_) => bloc.state.email.value.fold(
                    (f) => f.maybeMap(
                      invalidEmail: (_) => 'Invalid Email',
                      orElse: () => null,
                    ),
                    (r) => null,
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  autocorrect: false,
                  obscureText: true,
                  onChanged: (value) => bloc.add(
                    SignInFormEvent.passwordChanged(value),
                  ),
                  validator: (_) => bloc.state.password.value.fold(
                    (f) => f.maybeMap(
                      shortPassword: (_) => 'Short Password',
                      orElse: () => null,
                    ),
                    (r) => null,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        child: const Text('SIGN IN'),
                        onPressed: () {
                          bloc.add(
                            const SignInFormEvent
                                .signInWithEmailAndPasswordPressed(),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        child: const Text('REGISTER'),
                        onPressed: () {
                          bloc.add(
                            const SignInFormEvent
                                .registerWithEmailAndPasswordPressed(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  child: const Text('SIGN IN WITH GOOGLE'),
                  onPressed: () {
                    bloc.add(
                      const SignInFormEvent.signInWithGooglePressed(),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
