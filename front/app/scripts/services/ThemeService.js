'use strict';

angular.module('thnkoutApp')
.factory('ThemeGenerator', function (){
    var themes = [
        {title: "三木谷・楽天会長兼社長の父、良一氏が死去　神戸大名誉教授", numOfSubTheme: 20, numOfOpinion: 30 },
        {title: "偽装米、8割が中国産…イオンは危険な食品だらけ？告発本は即撤去の横暴（Business Journal）", numOfSubTheme: 20, numOfOpinion: 30 },
        {title: "優勝セールの“不当表示”疑惑に焦る楽天（東洋経済オンライン", numOfsubTheme: 20, numOfOpinion: 30 },
        {title: "牛丼3社、流通系の攻勢受け苦しい闘い（東洋経済オンライン）", numOfSubTheme: 20, numOfOpinion: 30 },
        {title: "来年3月のQE縮小スタートで日本株が1万9000円を目指す理由（ダイヤモンド・オンライン）", numOfSubTheme: 20, numOfOpinion: 30 }
    ];
    return {
        getThemes: function(){
            return themes;
        }
    }
});