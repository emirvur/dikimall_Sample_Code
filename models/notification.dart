class Notifications {
  String fromName;
  String fromId;
  String toName;
  String toId;
  String content;
  String title;
  String notificationSendAt;
  String type;
  String typeId;

  Notifications(
      this.fromName,
      this.fromId,
      this.toName,
      this.toId,
      this.content,
      this.title,
      this.notificationSendAt,
      this.type,
      this.typeId);
  Notifications.fromMap(Map<String, dynamic> map) {

    this.fromId = map['from']['_id'];
    this.fromName = map['from']['username'];
    this.toId = map['to']['_id'];
    this.toName = map['to']['username'];
    this.content = map['content'];
    this.title = map['title'];
    this.notificationSendAt = map['notificationSendAt'];
    this.type = map['type'];
    this.typeId = map['typeId'];
  }
  Map<String, dynamic> toJson(String from, String to, String lastme,
          String fromname, String toname) =>
      {
        "to": to,
        "from": from,
        "content": content,
        "title": title,
        "notificationSendAt": notificationSendAt,
        "type": type,
        "typeId": typeId
      };
}
