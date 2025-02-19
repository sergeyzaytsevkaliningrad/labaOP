CGROUP_NAME="hw"
CGROUP_PATH="/sys/fs/cgroup/hw"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo cgcreate -a $USER -t $USER -g memory,cpu:$CGROUP_NAME

cd $CGROUP_PATH

echo 15M > memory.max
echo 15M > memory.high

# Функция для очистки cgroup
echo 75000 100000 > cpu.max

echo 8M > memory.swap.max
echo 8M > memory.swap.high

echo "Max mem:" $(cat memory.max)
echo "High mem:" $(cat memory.high)

echo "Cpu Bound: 75% per 100ms:" $(cat cpu.max)

echo "Max swap sets for OOM:" $(cat memory.swap.max)
echo "High swap sets for OOM:" $(cat memory.swap.high)

cd $SCRIPT_DIR

# Функция для очистки cgroup
cleanup() {
    echo "Удаление cgroup..."
    sudo cgdelete -r memory,cpu:$CGROUP_NAME
}
trap cleanup EXIT

# Убедимся что переданы аргументы
if [ "$#" -lt 4 ]; then
    echo "Использование: $0 <command> <arg1> <arg2> <arg3>"
    exit 1
fi

# Передаем все параметры начиная с первого аргумента
COMMAND=$1
shift

# Запуск процесса в cgroup с помощью cgexec
sudo cgexec -g memory,cpu:$CGROUP_NAME $COMMAND "$@"
