class Refresh {
  String? jwtAccessToken;
  String? refreshToken;

  Refresh(String? access, String? refresh) {
    this.jwtAccessToken = access;
    this.refreshToken = refresh;
  }
  Map<String, dynamic> toJson() =>
      {'jwtAccessToken': jwtAccessToken, 'refreshToken': refreshToken};
}
