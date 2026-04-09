class StartupModel {
  final int? success;
  final String? message;
  final Data? data;

  StartupModel({this.success, this.message, this.data});

  StartupModel copyWith({int? success, String? message, Data? data}) {
    return StartupModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  StartupModel.fromJson(Map<String, dynamic> json)
    : success = json['success'] as int?,
      message = json['message'] as String?,
      data = (json['data'] as Map<String, dynamic>?) != null
          ? Data.fromJson(json['data'] as Map<String, dynamic>)
          : null;

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.toJson(),
  };
}

class Data {
  final BottomNav? bottomNav;
  final Profile? profile;
  final Others? others;
  final Action? action;
  final int? userId;
  final bool? mandatoryUpdate;
  final dynamic redirectionUrl;

  Data({
    this.bottomNav,
    this.profile,
    this.others,
    this.action,
    this.userId,
    this.mandatoryUpdate,
    this.redirectionUrl,
  });

  Data copyWith({
    BottomNav? bottomNav,
    Profile? profile,
    Others? others,
    Action? action,
    int? userId,
    bool? mandatoryUpdate,
    dynamic redirectionUrl,
  }) {
    return Data(
      bottomNav: bottomNav ?? this.bottomNav,
      profile: profile ?? this.profile,
      others: others ?? this.others,
      action: action ?? this.action,
      userId: userId ?? this.userId,
      mandatoryUpdate: mandatoryUpdate ?? this.mandatoryUpdate,
      redirectionUrl: redirectionUrl ?? this.redirectionUrl,
    );
  }

  Data.fromJson(Map<String, dynamic> json)
    : bottomNav = (json['bottom_nav'] as Map<String, dynamic>?) != null
          ? BottomNav.fromJson(json['bottom_nav'] as Map<String, dynamic>)
          : null,
      profile = (json['profile'] as Map<String, dynamic>?) != null
          ? Profile.fromJson(json['profile'] as Map<String, dynamic>)
          : null,
      others = (json['others'] as Map<String, dynamic>?) != null
          ? Others.fromJson(json['others'] as Map<String, dynamic>)
          : null,
      action = (json['action'] as Map<String, dynamic>?) != null
          ? Action.fromJson(json['action'] as Map<String, dynamic>)
          : null,
      userId = json['user_id'] as int?,
      mandatoryUpdate = json['mandatory_update'] as bool?,
      redirectionUrl = json['redirection_url'];

  Map<String, dynamic> toJson() => {
    'bottom_nav': bottomNav?.toJson(),
    'profile': profile?.toJson(),
    'others': others?.toJson(),
    'action': action?.toJson(),
    'user_id': userId,
    'mandatory_update': mandatoryUpdate,
    'redirection_url': redirectionUrl,
  };
}

class BottomNav {
  final bool? chatList;
  final bool? initiateChat;
  final bool? profile;

  BottomNav({this.chatList, this.initiateChat, this.profile});

  BottomNav copyWith({bool? chatList, bool? initiateChat, bool? profile}) {
    return BottomNav(
      chatList: chatList ?? this.chatList,
      initiateChat: initiateChat ?? this.initiateChat,
      profile: profile ?? this.profile,
    );
  }

  BottomNav.fromJson(Map<String, dynamic> json)
    : chatList = json['chat_list'] as bool?,
      initiateChat = json['initiate_chat'] as bool?,
      profile = json['profile'] as bool?;

  Map<String, dynamic> toJson() => {
    'chat_list': chatList,
    'initiate_chat': initiateChat,
    'profile': profile,
  };
}

class Profile {
  final Main? main;

  Profile({this.main});

  Profile copyWith({Main? main}) {
    return Profile(main: main ?? this.main);
  }

  Profile.fromJson(Map<String, dynamic> json)
    : main = (json['main'] as Map<String, dynamic>?) != null
          ? Main.fromJson(json['main'] as Map<String, dynamic>)
          : null;

  Map<String, dynamic> toJson() => {'main': main?.toJson()};
}

class Main {
  final bool? profile;
  final bool? userContacts;
  final bool? notificationStatus;

  Main({this.profile, this.userContacts, this.notificationStatus});

  Main copyWith({bool? profile, bool? userContacts, bool? notificationStatus}) {
    return Main(
      profile: profile ?? this.profile,
      userContacts: userContacts ?? this.userContacts,
      notificationStatus: notificationStatus ?? this.notificationStatus,
    );
  }

  Main.fromJson(Map<String, dynamic> json)
    : profile = json['profile'] as bool?,
      userContacts = json['user_contacts'] as bool?,
      notificationStatus = json['notification_status'] as bool?;

  Map<String, dynamic> toJson() => {
    'profile': profile,
    'user_contacts': userContacts,
    'notification_status': notificationStatus,
  };
}

class Others {
  final bool? contactUs;
  final bool? about;
  final bool? tnc;
  final bool? privacyPolicy;
  final bool? cancellationPolicy;
  final bool? refundPolicy;

  Others({
    this.contactUs,
    this.about,
    this.tnc,
    this.privacyPolicy,
    this.cancellationPolicy,
    this.refundPolicy,
  });

  Others copyWith({
    bool? contactUs,
    bool? about,
    bool? tnc,
    bool? privacyPolicy,
    bool? cancellationPolicy,
    bool? refundPolicy,
  }) {
    return Others(
      contactUs: contactUs ?? this.contactUs,
      about: about ?? this.about,
      tnc: tnc ?? this.tnc,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      cancellationPolicy: cancellationPolicy ?? this.cancellationPolicy,
      refundPolicy: refundPolicy ?? this.refundPolicy,
    );
  }

  Others.fromJson(Map<String, dynamic> json)
    : contactUs = json['contact_us'] as bool?,
      about = json['about'] as bool?,
      tnc = json['tnc'] as bool?,
      privacyPolicy = json['privacy_policy'] as bool?,
      cancellationPolicy = json['cancellation_policy'] as bool?,
      refundPolicy = json['refund_policy'] as bool?;

  Map<String, dynamic> toJson() => {
    'contact_us': contactUs,
    'about': about,
    'tnc': tnc,
    'privacy_policy': privacyPolicy,
    'cancellation_policy': cancellationPolicy,
    'refund_policy': refundPolicy,
  };
}

class Action {
  final bool? deleteAccount;
  final bool? logout;
  final bool? login;

  Action({this.deleteAccount, this.logout, this.login});

  Action copyWith({bool? deleteAccount, bool? logout, bool? login}) {
    return Action(
      deleteAccount: deleteAccount ?? this.deleteAccount,
      logout: logout ?? this.logout,
      login: login ?? this.login,
    );
  }

  Action.fromJson(Map<String, dynamic> json)
    : deleteAccount = json['delete_account'] as bool?,
      logout = json['logout'] as bool?,
      login = json['login'] as bool?;

  Map<String, dynamic> toJson() => {
    'delete_account': deleteAccount,
    'logout': logout,
    'login': login,
  };
}
