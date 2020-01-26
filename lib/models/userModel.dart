
class UserModel {
  String nombre;
  String correo;

  UserModel({this.nombre = '', this.correo = ''});

  factory UserModel.fromJson(Map<dynamic, dynamic> jsonUser) => new UserModel(
        nombre: jsonUser["name"],
        correo: jsonUser["email"],
      );

  Map<String, dynamic> toJson() => {
        "name": nombre,
        "email": correo,
      };
}
