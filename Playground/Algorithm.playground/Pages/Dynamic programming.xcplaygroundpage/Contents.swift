//: Playground - noun: a place where people can play

import UIKit

/**
 # 动态规划
 首先要明白动态规划有以下几个专有名词：
 
 初始状态，即此问题的最简单子问题的解。在斐波拉契数列里，最简单的问题是，一开始给定的第一个数和第二个数是几？自然我们可以得出是1
 状态转移方程，即第n个问题的解和之前的 n - m 个问题解的关系。在这道题目里，我们已经有了状态转移方程F(n) = F(n - 1) + F(n - 2)
 所以这题要求F(100)，那我们只要知道F(99)和F(98)就行了；想知道F(99)，我们只要知道F(98)和F(97)就行了；想要知道F(98)，我们需要知道F(97)和F(96)。。。，以此类推，我们最后只要知道F(2)和F(1)的值，就可以推出F(100)。而F(2)和F(1)正是我们所谓的初始状态，即 F(2) = 1，F(1) =1。
 */
do {
    func Fib(_ n: Int) -> Int {
        // 定义初始状态
        guard n > 0 else {
            return 0
        }
        if n == 1 || n == 2 {
            return 1
        }
        
        // 调用状态转移方程
        return Fib(n - 1) + Fib(n - 2)
    }
    
    print(Fib(10))
}


/**
 # 动态转移
 虽然看上去十分高大上，但是它也存在两个致命缺点：
 
 栈溢出：每一次递归，程序都会将当前的计算压入栈中。随着递归深度的加深，栈的高度也越来越高，直到超过计算机分配给当前进程的内存容量，程序就会崩溃。
 数据溢出：因为动态规划是一种由简至繁的过程，其中积蓄的数据很有可能超过系统当前数据类型的最大值，导致崩溃。
 而这两个bug，我们上面这道求解斐波拉契数列第100个数的题目就都遇到了。
 
 首先，递归的次数很多，我们要从F(100) = F(99) + F(98) ，一直推理到F(3) = F(2) + F(1)，这样很容易造成栈溢出。
 其次，F(100)应该是一个很大的数。实际上F(40)就已经突破一亿，F(100)一定会造成整型数据溢出。
 当然，这两个bug也有相应的解决方法。对付栈溢出，我们可以把递归写成循环的形式（所有的递归都可改写成循环）；对付数据溢出，我们可以在程序每次计算中，加入数据溢出的检测，适时终止计算，抛出异常。
 */
do {
    var nums = Array(repeating: 0, count: 100)
    
    func Fib(_ n: Int) -> Int {
        // 定义初始状态
        guard n > 0 else {
            return 0
        }
        if n == 1 || n == 2 {
            return 1
        }
        // 如果已经计算过，直接调用，无需重复计算
        if nums[n - 1] != 0 {
            return nums[n - 1]
        }
        
        // 将计算后的值存入数组
        nums[n - 1] = Fib(n - 1) + Fib(n - 2)
        
        return nums[n - 1]
    }
}


/**
 缩小误差范围：将所有的单词构造成前缀树。然后对于扫描的内容，搜索出相应可能的单词。具体做法可以参考《Swift 算法实战之路：深度和广度优先搜索》一文中搜索单词的方法。
 计算出最接近的单词：假如上一步，我们已经有了10个可能的单词，那么怎么确定最接近真实情况的单词呢？这里我们要定义两个单词的距离 -- 从第一个单词wordA，到第二个单词wordB，有三种操作：
 删除一个字符
 添加一个字符
 替换一个字符
 综合上述三种操作，用最少步骤将单词wordA变到单词wordB，我们就称这个值为两个单词之间的距离。比如 pr1ce -> price，只需要将 1 替换为 i 即可，所以两个单词之间的距离为1。pr1ce -> prize，要将 1 替换为 i ，再将 c 替换为 z ，所以两个单词之间的距离为2。相比于prize，price更为接近原来的单词。
 
 现在问题转变为实现下面这个方法：
 
 func wordDistance(_ wordA: String, wordB: String) -> Int { ... }
 要解决这个复杂的问题，我们不如从一个简单的例子出发：求“abce”到“abdf”之间的距离。它们两之间的距离，无非是下面三种情况中的一种。
 
 删除一个字符：假如已知 wordDistance("abc", "abdf") ，那么“abce”只需要删除一个字符到达“abc”，然后就可以得知“abce”到“abdf”之间的距离。
 添加一个字符：假如已知 wordDistance("abce", "abd")，那么我们只要让“abd”添加一个字符到达“abdf”即可求出最终解。
 替换一个字符：假如已知 wordDistance("abc", "abd")，那么就可以依此推出 wordDistance("abce", "abde") = wordDistance("abc", "abd")。故而只要将末尾的“e”替换成"f"，就可以得出wordDistance("abce", "abdf")
 这样我们就可以发现，求解任意两个单词之间的距离，只要知道之前单词组合的距离即可。我们用dp[i][j]表示第一个字符串wordA[0…i] 和第2个字符串wordB[0…j] 的最短编辑距离，那么这个动态规划的两个重要参数分别是：
 
 初始状态：dp[0][j] = j，dp[i][0] = i
 状态转移方程：dp[i][j] = min(dp[i - 1][j - 1], dp[i - 1][j], dp[i][j - 1]) + 1
 再举例解释一下，"abc"到"xyz"，dp[2][1]就是"ab"到"x"的距离，不难看出是2；dp[1][2]就是"a"到"xy"的距离，是2；dp[1][1]也就是"a"到"x"的距离，很显然就是1。所以dp[2][2]即"ab"到"xy"的距离是min(dp[2][1], dp[1][2], dp[1][1]) + 1就是2.
 */
do {
    func wordDistance(_ wordA: String, _ wordB: String) -> Int {
        let aChars = [Character](wordA.characters)
        let bChars = [Character](wordB.characters)
        let aLen = aChars.count
        let bLen = bChars.count
        
        var dp = Array(repeating: (Array(repeating: 0, count: bLen + 1)), count: aLen + 1)
        
        for i in 0 ... aLen {
            for j in 0 ... bLen {
                // 初始情况
                if i == 0 {
                    dp[i][j] = j
                } else if j == 0 {
                    dp[i][j] = i
                    // 特殊情况
                } else if aChars[i - 1] == bChars[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1]
                } else {
                    // 状态转移方程
                    dp[i][j] = min(dp[i - 1][j - 1], dp[i - 1][j], dp[i][j - 1]) + 1
                }
            }
        }
        
        return dp[aLen][bLen]
    }
}