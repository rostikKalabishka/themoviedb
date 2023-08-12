import '../widgets/auth/auth_widget.dart';
import '../widgets/signup/signup_screen.dart';
import '../widgets/main_screen/main_screen_widget.dart';
import '../widgets/resend_email/resend_email_screen.dart';

final routes = {
  '/auth': (context) => AuthWidget(),
  '/main_screen': (context) => MainScreenWidget(),
  '/resend_email': (context) => ResendEmailScreen(),
  '/sign_up': (context) => SignUpScreen()
};
