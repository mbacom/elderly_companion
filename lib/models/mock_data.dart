class MockData {
  static String get weatherText {
    final hour = DateTime.now().hour;
    final period = hour < 12 ? '上午' : hour < 18 ? '下午' : '晚上';
    return '今日荔湾大雨\n体感清凉\n记得添衣保暖\n\n$period${hour < 6 ? '，天未光，慢慢行' : ''}';
  }

  static String get locationText => '广州 · 荔湾区';

  static String get dateText {
    final now = DateTime.now();
    const weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    return '${now.year}年${now.month}月${now.day}日 ${weekdays[now.weekday - 1]}';
  }

  static final List<Map<String, String>> songs = [
    {
      'title': '帝女花 · 香夭',
      'artist': '任剑辉 · 白雪仙',
      'description': '落花满天蔽月光\n借一杯附荐凤台上\n帝女花带泪上香\n愿丧生回谢爹娘',
    },
    {
      'title': '禅院钟声',
      'artist': '阮兆辉',
      'description': '云寒雨冷\n寂寥夜半景色凄清\n荒山悄静\n依稀隐约传来了夜半钟',
    },
    {
      'title': '分飞燕',
      'artist': '陈笑风 · 严淑芳',
      'description': '分飞万里隔千山\n离泪似珠强忍欲坠凝在眼\n我欲诉别离情无限',
    },
  ];

  static const emergencyContacts = [
    {'name': '女儿 · 阿芳', 'phone': '139-2222-3333', 'relation': '大女儿'},
    {'name': '儿子 · 阿强', 'phone': '138-1111-2222', 'relation': '二儿子'},
    {'name': '邻居 · 陈伯', 'phone': '136-5555-6666', 'relation': '老街坊'},
    {'name': '荔湾社区中心', 'phone': '020-8123-4567', 'relation': '社区'},
  ];

  static const safetyTips = [
    '出门前记得带手机、钥匙、钱包三件宝',
    '过马路走斑马线，红灯停绿灯行，唔好急',
    '随身带住紧急联系卡，写上家人电话',
    '雨天路滑，着防滑鞋，行慢啲稳阵',
    '如果唔识路，随时打俾仔女或邻居',
    '荔湾湖公园晨运，记得带水同毛巾',
    '去茶楼饮茶，唔好带太多现金',
    '身体不适即刻打120，唔好死顶',
  ];

  static const List<Map<String, String>> newspaperArticles = [
    {
      'title': '荔湾湖荷花节\n盛大开幕',
      'content': '今日上午，荔湾湖公园第三十八届荷花节正式开幕。公园内近百个品种的荷花竞相绽放，吸引了大批街坊前来观赏拍照。今年特别增设长者赏花专区，设有休息座椅和免费茶水供应，服务贴心周到。',
    },
    {
      'title': '上下九步行街\n老字号新气象',
      'content': '有着百年历史的上下九步行街近日完成翻新工程。陶陶居、莲香楼、广州酒家等老字号以全新面貌迎客。街坊们熟悉的骑楼建筑得到修缮保护，重现昔日西关风情。每日早上七点，各大茶楼已是座无虚席。',
    },
    {
      'title': '陈家祠粤剧\n周末公益专场',
      'content': '为弘扬岭南传统文化，陈家祠将于本周末举办粤剧公益专场演出。届时将由广州粤剧院名家献唱经典折子戏《帝女花》《紫钗记》选段。年满六十岁长者凭身份证免费入场，欢迎各位老友记踊跃参加。',
    },
    {
      'title': '珠江夜游推出\n长者优惠月',
      'content': '珠江夜游公司宣布本月为长者优惠月，六十岁以上长者凭身份证可享受船票五折优惠。每晚七点半从天字码头出发，沿途可欣赏广州塔、海心沙、二沙岛等珠江两岸璀璨夜景。船上提供粤语导览服务。',
    },
  ];

  static String get extractedText => '荔湾区，地处广州市西部，是广州市中心城区之一。荔湾因“一湾溪水绿，两岸荔枝红”而得名，素有“西关”之称。这里是广府文化的发祥地，岭南建筑、粤剧曲艺、西关美食闻名遐迩。上下九步行街、陈家祠、荔湾湖公园、沙面岛等景点承载着老广州的集体记忆。';
}