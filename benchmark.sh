#!/bin/bash

INPUT_FILE="input.txt"
SIZE=100000000
COUNT=${1:-5}
BUILD_DIR="build"

# Проверяем, что COUNT - это положительное число
if ! [[ "$COUNT" =~ ^[0-9]+$ ]] || [ "$COUNT" -le 0 ]; then
	echo "Ошибка: аргумент должен быть положительным целым числом."
	exit 1
fi

# Генерация входных данных
echo "Генерация $SIZE чисел в $INPUT_FILE..."
seq 1 $SIZE > $INPUT_FILE

compile_all() {
	echo "Компиляция всех программ..."
	g++ scanf_io.cpp -O2 -o $BUILD_DIR/scanf_io
	g++ cin_io.cpp -O2 -o $BUILD_DIR/cin_io
	g++ cin_io_v2.cpp -O2 -o $BUILD_DIR/cin_io_v2
	g++ boost_io.cpp -O2 -o $BUILD_DIR/boost_io
	g++ boost_io_v2.cpp -O2 -o $BUILD_DIR/boost_io_v2 -lboost_iostreams
}

run_test() {
	NAME=$1
	EXEC=$2
	echo "Тест $NAME:"
	# Цикл для выполнения команды
	for ((i=1; i<=COUNT; i++)); do
		/usr/bin/time -f "$i#: Время: %E \tПамять: %M КБ" ./$EXEC < $INPUT_FILE > /dev/null
	done
	echo
}


# Проверяем аргументы командной строки
for arg in "$@"; do
	case $arg in
		--no-compile)
		NO_COMPILE=true
		shift # Удаляем аргумент из списка
		;;
	esac
done

# Вызываем compile_all, если --no-compile не указан
if [ -z "$NO_COMPILE" ]; then
	compile_all
else
	echo "Компиляция пропущена."
fi

run_test "scanf/printf" $BUILD_DIR/scanf_io
run_test "cin/cout" $BUILD_DIR/cin_io
run_test "cin/cout оптимизация" $BUILD_DIR/cin_io_v2
run_test "Boost" $BUILD_DIR/boost_io
run_test "Boost оптимизация" $BUILD_DIR/boost_io_v2
