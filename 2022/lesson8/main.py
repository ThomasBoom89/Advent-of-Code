tree_dict = {}
wood = []


def file_to_list():
    file_reader = open("input.txt", "r")
    file_content = file_reader.read()
    file_reader.close()
    file_lines = file_content.split("\n")

    for line in file_lines:
        if line == "":
            continue

        int_list = []
        for char in line:
            int_list.append(int(char))
        wood.append(int_list)


def from_top():
    for j in range(len(wood[0])):
        max_value = -1
        for i in range(len(wood)):
            if max_value < wood[i][j]:
                max_value = wood[i][j]
                tree_dict[repr(i) + "_" + repr(j)] = True


def from_bottom():
    for j in range(len(wood[0])):
        max_value = -1
        for i in range(len(wood) - 1, -1, -1):
            if max_value < wood[i][j]:
                max_value = wood[i][j]
                tree_dict[repr(i) + "_" + repr(j)] = True


def from_left():
    for i in range(len(wood)):
        max_value = -1
        for j in range(len(wood[i])):
            if max_value < wood[i][j]:
                max_value = wood[i][j]
                tree_dict[repr(i) + "_" + repr(j)] = True


def from_right():
    for i in range(len(wood)):
        max_value = -1
        for j in range(len(wood[i]) - 1, -1, -1):
            if max_value < wood[i][j]:
                max_value = wood[i][j]
                tree_dict[repr(i) + "_" + repr(j)] = True


def lesson_a():
    file_to_list()
    from_top()
    from_bottom()
    from_left()
    from_right()

    print("length of map")
    print(len(tree_dict))


def lesson_b():
    file_to_list()
    max_sum = 0
    for i in range(0, len(wood)):
        for j in range(0, len(wood)):
            sum_value = 1
            current = wood[i][j]
            k = 1
            while True:
                index = i - k
                if i - 1 < 0:
                    k = 0
                    break

                if index <= 0 or wood[index][j] >= current:
                    break
                k += 1

            sum_value *= k
            k = 1
            while True:
                index = i + k
                if i + 1 >= len(wood):
                    k = 0
                    break

                if index >= len(wood) - 1 or wood[index][j] >= current:
                    break
                k += 1

            sum_value *= k
            k = 1
            while True:
                index = j - k
                if j - 1 < 0:
                    k = 0
                    break

                if index <= 0 or wood[i][index] >= current:
                    break
                k += 1

            sum_value *= k
            k = 1
            while True:
                index = j + k
                if j + 1 >= len(wood):
                    k = 0
                    break

                if index >= len(wood) - 1 or wood[i][index] >= current:
                    break
                k += 1

            sum_value *= k

            if sum_value > max_sum:
                max_sum = sum_value

    print(max_sum)


if __name__ == '__main__':
    lesson_a()
    tree_dict.clear()
    wood.clear()
    lesson_b()
