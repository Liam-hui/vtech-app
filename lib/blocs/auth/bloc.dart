import 'package:bloc/bloc.dart';
import 'event.dart';
import 'state.dart';
import '../../services/services.dart';
import '../../models/models.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc({ required this.authService }) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppLoaded) {
      yield* _mapAppLoadedToState(event);
    }

    if (event is UserSignInReset) {
      yield* _mapUserSignInResetToState(event);
    }

    if (event is UserSignInStart) {
      yield* _mapUserSignInStartToState(event);
    }

    if (event is UserVerifyStart) {
      yield* _mapUserVerifyStartToState(event);
    }

    // if (event is UserSignedOut) {
    //   yield* _mapUserSignedOutToState(event);
    // }
  }

  Stream<AuthState> _mapAppLoadedToState(AppLoaded event) async* {
    yield AuthLoading();
    try {
      // await Future.delayed(Duration(milliseconds: 500)); // a simulated delay
      // final currentUser = await authService.getCurrentUser();

      // if (currentUser.name != '') {
      //   yield AuthSuccess(user: currentUser);
      // } else {
      //   yield AuthNotDone();
      // }
    } catch (e) {
      print(e);
      // yield AuthFail(message: e.message ?? 'An unknown error occurred');
    }
  }

  // cancel pending
  Stream<AuthState> _mapUserSignInResetToState(UserSignInReset event) async* {
    yield AuthNotDone();
  }

  Stream<AuthState> _mapUserSignInStartToState(UserSignInStart event) async* {
    yield AuthLoading();

    try {
      final myAccount = await authService.signIn(event.email, event.password);
      if (myAccount.needVerify) {
        yield AuthPending(account: myAccount);
      }
      else {
        yield AuthSuccess(account: myAccount);
      }
    } catch (error) {
      yield AuthFail(message: error.toString());
    }
  }

  Stream<AuthState> _mapUserVerifyStartToState(UserVerifyStart event) async* {
    try {
      final myAccount = await authService.verify(event.code);

    } catch (error) {
      // yield AuthFail(message: error.toString());
    }
  }

  Stream<AuthState> _mapUserSignedOutToState(UserSignedOut event) async* {
    await authService.signOut();
    yield AuthNotDone();
  }
}
