import java.io.File

fun main(args: Array<String>) {
    lessonA()
    lessonB()
}

private fun lessonA() {
    var count: Int = 0;
    File("../input.txt").readLines().forEach {
        // A X
        val splitted: List<String> = it.split(" ")
        val opponent: String = splitted[0]
        val me: String = splitted[1]
        if (me == "X") {
            count += 1
            if (opponent == "A") {
                count += 3
            } else if (opponent == "C") {
                count += 6
            }
        } else if (me == "Y") {
            count += 2
            if (opponent == "B") {
                count += 3
            } else if (opponent == "A") {
                count += 6
            }
        } else {
            // Z
            count += 3
            if (opponent == "C") {
                count += 3
            } else if (opponent == "B") {
                count += 6
            }
        }
    }
    println(count)
}

private fun lessonB() {
    var count: Int = 0;
    File("../input.txt").readLines().forEach {
        // A X
        val splitted: List<String> = it.split(" ")
        val opponent: String = splitted[0]
        val me: String = splitted[1]
        if (me == "X") {
            count += 0
            if (opponent == "A") {
                count += 3
            } else if (opponent == "B") {
                count += 1
            } else {
                count += 2
            }
        } else if (me == "Y") {
            count += 3
            if (opponent == "A") {
                count += 1
            } else if (opponent == "B") {
                count += 2
            } else {
                count += 3
            }
        } else {
            // Z
            count += 6
            if (opponent == "A") {
                count += 2
            } else if (opponent == "B") {
                count += 3
            } else {
                count += 1
            }
        }
    }
    println(count)
}
