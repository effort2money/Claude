#include <iostream>
#include <string>
#include <vector>

// 简单的问候函数
void greet(const std::string& name) {
    std::cout << "你好, " << name << "!" << std::endl;
}

// 计算向量中所有元素的和
int sum(const std::vector<int>& numbers) {
    int total = 0;
    for (int num : numbers) {
        total += num;
    }
    return total;
}

int main() {
    // 基本输出
    std::cout << "=== C++ 示例程序 ===" << std::endl;
    std::cout << std::endl;

    // 使用问候函数
    greet("世界");
    greet("Claude");
    std::cout << std::endl;

    // 使用向量和求和函数
    std::vector<int> numbers = {1, 2, 3, 4, 5};
    std::cout << "数字列表: ";
    for (int num : numbers) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    std::cout << "总和: " << sum(numbers) << std::endl;
    std::cout << std::endl;

    // 用户输入示例
    std::string user_name;
    std::cout << "请输入你的名字: ";
    std::getline(std::cin, user_name);

    if (!user_name.empty()) {
        greet(user_name);
    }

    return 0;
}
