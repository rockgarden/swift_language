//: Playground - noun: a place where people can play

import Foundation
/*:
 # 正则表达式 Regular Expression
 正则表达式使用单个字符串来描述、匹配一系列符合某个句法规则的字符串。
 在很多文本编辑器里，正则表达式通常被用来检索、替换那些符合某个模式的文本。
 正则表达式的字符组成
 普通字符【a~z】、特殊字符（称为"元字符"）
 使用
 
 ## 匹配
 (pattern) 匹配pattern并获取这一匹配，所获取的匹配可以从产生的Matches集合得到
 集合
 [xyz] 字符集合(x||y||z)
 [a-z] 字符范围a-z
 [a-zA-Z] 字符范围a-z A-Z
 [^xyz] 负值字符集合 (任何字符, 除了xyz)
 [^a-z] 负值字符范围
 [a-d][m-p] 并集(a到d 或 m到p)
 
 常用元字符
 . 匹配除换行符以外的任意字符
 \w 匹配字母或数字或下划线或汉字 [a-zA-Z_0-9]
 \s 匹配任意的空白符（空格、TAB\t、回车\r \n）
 \d 匹配数字 [0-9]
 ^a 匹配字符串的开始a字符
 a$ 匹配字符串的结束a字符
 \bw 匹配单词的开始或结束w字符
 
 常用反义符
 \W 匹配任意不是字母，数字，下划线，汉字的字符[^\w]
 \S 匹配任意不是空白符的字符 [^\s]
 \D 匹配任意非数字的字符[^0-9]
 \Ba 匹配不是单词开头或结束的位置的a字符
 [^a] 匹配除了a以外的任意字符
 [^aeiou] 匹配除了aeiou这几个字母以外的任意字符
 
 常用限定符
 w*oo 重复零次或更多次
 w+oo 重复一次或更多次
 w?oo 重复零次或一次
 w{n} w重复n次
 w{n,} w重复n次或更多次
 w{n,m} w重复n到m次
 贪婪和懒惰
 *? 重复任意次，但尽可能少重复
 *+ 重复1次或更多次，但尽可能少重复
 ?? 重复0次或1次，但尽可能少重复
 w{1,2}? 重复1到2次，但尽可能少重复
 ww{1,}? 重复1次以上，但尽可能少重复
 
 匹配手机号码："^((13[0-9])|(147)|(15[0-3,5-9])|(18[0,0-9])|(17[0-3,5-9]))\d{8}$"
 
 至少输入3至多输入15位："^[a-zA-Z0-9]{3,15}$"  // 输入3-15位的正则表达式
 
 正则匹配用户身份证号15或18位："(^[0-9]{15}$)|([0-9]{17}([0-9]|[0-9a-zA-Z])$)"
 
 红包输入框的过滤："^[0-9]*?((\\.|,)[0-9]{0,2})?$" // 金额输入框
 // 1.创建规则
 // 看看字符串是否字母
 let pattern = "[a-zA-Z]"
 // 看看字符串是否是数字
 let pattern = "[0-9]"
 let pattern = "[^a-zA-Z]"
 let pattern = "\\d"
 // 看看字符串中有没有3个连在一起的数字
 let pattern = "\\d{3}"
 // 看看字符串中有没有3个或3个以上连在一起的数字
 let pattern = "\\d{3,}"
 // 看看字符串中有没有3~5个连在一起的数字
 let pattern = "\\d{3,5}?"
 */

do {
    func test(_ pattern: String, str: String) -> Bool{
        
        // 2.利用规则创建表达式对象
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
        
        // 3.利用表达式对象取出结果
        let res = regex.firstMatch(in: str, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, str.characters.count))
        
        print(res?.description as Any)
        
        if res != nil {
            return true
        }
        return false
    }

    test("\\d{3,5}?", str: "11A9eew23")
    
    test("1[3578]\\d{9}", str: "13554499311")
    
    /// 正则判断手机号码
    func checkPhoneNumber(_ str:String)->Bool {
        // 匹配手机号码
        /*
         1.11位
         2.必须以1开头
         3.第二位必须是 3578
         4.必须都是数字
         */
        let pattern = "1[3578]\\d{9}"
        
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue:0))
        let res = regex.matches(in: str, options: NSRegularExpression.MatchingOptions(rawValue:0), range: NSMakeRange(0, str.characters.count))
        print(res.description as Any)
        if res.count > 0 {
            return true
        }
        return false
    }
    
    checkPhoneNumber("13554499311")
}

/// 判断QQ号码（常规判断）
fileprivate func checkIsQQNumber(str:String) ->Bool {
    // 1.判断是否以0开头
    if str.hasPrefix("0"){
        return false
    }
    
    // 2.判断是否是5~15位
    if str.characters.count < 5 || str.characters.count > 15{
        return false
    }
    
    // 3.判断是否全部都是数字
    for c in str.characters{
        if c < "0" || c > "9"{
            return false
        }
    }
    return true
}





