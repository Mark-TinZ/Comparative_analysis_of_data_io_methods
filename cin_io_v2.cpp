#include <iostream>
#include <vector>

int main() {
	std::ios::sync_with_stdio(false);
    std::cin.tie(nullptr);

	std::vector<int> numbers;
    int x;

	while (std::cin >> x) {
        numbers.push_back(x);
    }
	
	for (size_t i = 0; i < numbers.size(); ++i) {
        std::cout << numbers[i] << " ";
    }

    std::cout << "\n";
	return 0;
}
