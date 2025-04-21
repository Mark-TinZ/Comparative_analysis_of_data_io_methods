	#include <boost/iostreams/device/file_descriptor.hpp>
#include <boost/iostreams/stream.hpp>
#include <boost/iostreams/read.hpp>
#include <boost/iostreams/write.hpp>
#include <vector>
#include <string>
#include <cstdlib>  // для std::atoi
#include <unistd.h> // для STDIN_FILENO и STDOUT_FILENO

namespace io = boost::iostreams;

int main() {
    // Входной поток через Boost
    io::file_descriptor_source input(STDIN_FILENO, io::never_close_handle);
    io::stream<io::file_descriptor_source> in(input);

    std::vector<int> numbers;
    std::string buffer;
    char ch;

	// Чтение посимвольно
	while (in.get(ch)) {
		if (ch == '\n' || ch == ' ') {
			if (!buffer.empty()) {
				numbers.push_back(std::atoi(buffer.c_str()));
				buffer.clear();
			}
		} else {
			buffer += ch;
		}
	}

	if (!buffer.empty()) {
		numbers.push_back(std::atoi(buffer.c_str()));
	}

    // Выводной поток через Boost
    io::file_descriptor_sink output(STDOUT_FILENO, io::never_close_handle);
    io::stream<io::file_descriptor_sink> out(output);

    for (size_t i = 0; i < numbers.size(); ++i) {
        out << numbers[i];
    }
    out << "\n";
    out.flush();

    return 0;
}
