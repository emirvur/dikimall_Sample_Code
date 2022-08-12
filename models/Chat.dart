class Chat {
  String digerkulid;
  String id;
  String ad;
  String lastmes;
  String lastmessendat;
  String profile;
  String token;
  Chat(this.digerkulid, this.id, this.ad, this.lastmes, this.lastmessendat,
      this.profile, this.token);
  Map<String, dynamic> toJson(String from, String to, String lastme,
          String fromname, String toname, String foto) =>
      {
        "chatId": id,
        "lastMessage": lastme,
        "from": from,
        "to": to,
        "fromName": fromname,
        "toName": toname,
        "profile_image": foto,
      };
}
