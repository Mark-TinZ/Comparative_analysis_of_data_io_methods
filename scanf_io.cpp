
#include <cstdio>
#include <vector>

int main() {
	std::vector<int> numbers;
	int x;

	while (scanf("%d", &x) == 1) {
		numbers.push_back(x);
	}

	for (size_t i = 0; i < numbers.size(); ++i) {
		printf("%d ", numbers[i]);
	}
	printf("\n");
	return 0;
}
