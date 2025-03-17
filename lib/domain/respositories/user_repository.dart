// import 'package:dartz/dartz.dart';
// import 'package:sound_sphere/core/error/failure.dart';
// import 'package:sound_sphere/data/models/app_user.dart';

// abstract class UserRepository {
//   /// Đăng nhập người dùng với tài khoản Google
//   Future<Either<Failure, AppUser>> signInWithGoogle();

//   /// Đăng nhập người dùng với email và mật khẩu
//   Future<Either<Failure, AppUser>> signInWithEmailAndPassword(
//       String email, String password);

//   /// Tạo tài khoản người dùng với email và mật khẩu
//   Future<Either<Failure, AppUser>> createUserWithEmailAndPassword(
//       String email, String password);

//   /// Đăng xuất người dùng
//   Future<Either<Failure, void>> signOut();

//   /// Kiểm tra xem người dùng có đang đăng nhập hay không
//   Future<Either<Failure, bool>> isSignedIn();

//   /// Lấy thông tin người dùng hiện tại
//   Future<Either<Failure, AppUser?>> getUser();
// }
