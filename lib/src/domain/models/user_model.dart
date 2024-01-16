class UserModel {
  String name;
  String email;
  String celular;
  String cpf;
  String senha;

  UserModel(
      {required this.celular,
      required this.cpf,
      required this.senha,
      required this.email,
      required this.name});
}

UserModel user = UserModel(
  celular: '99 9 9999-9999',
  cpf: '999.999.999-99',
  senha: '102030',
  email: 'email@email.com',
  name: 'Usuário Teste',
);
