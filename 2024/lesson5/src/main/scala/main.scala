import scala.util.control.Breaks._


@main
def main(): Unit =
  lessonA()
  lessonB()

def lessonB(): Unit = {
  val source = scala.io.Source.fromFile("/mnt/media1/projects/github.com/advent-of-code/2024/lesson5/input")
  val rules = collection.mutable.Map[String, Array[String]]()
  var updates = Array[Array[String]]()
  var secondInput = false

  for (line <- source.getLines()) {
    breakable {
      if (line.isEmpty) {
        secondInput = true
        break()
      }
      if (secondInput) {
        updates = updates.appended(line.split(","))
      } else {
        val parts = line.split("\\|")
        if (!rules.contains(parts.apply(1))) {
          rules.put(parts.apply(1), Array(parts.apply(0)))
        } else {
          rules.put(parts.apply(1), rules.apply(parts.apply(1)).appended(parts.apply(0)))
        }
      }
    }
  }

  var sum = 0

  for (updateRow <- updates) {
    breakable {
      var iter = 0
      var maxIter = updateRow.length - 1
      var goodCount = 0
      for (update <- updateRow) {
        if (isGood(iter, updateRow, update, maxIter, rules)) {
          goodCount = goodCount + 1
          if (goodCount == updateRow.length) {
            break
          }
        }
        iter = iter + 1
      }

      var rowTemp = updateRow
      rowTemp = swap(rowTemp, rules)
      var key = ((rowTemp.length) / 2).round
      sum = rowTemp.apply(key).toInt + sum
    }
  }

  println(sum)
  source.close()
}

def swap(updateRow: Array[String], rules: collection.mutable.Map[String, Array[String]]): Array[String] = {
  var iter = 0
  var maxIter = updateRow.length - 1
  for (update <- updateRow) {
    if (!isGood(iter, updateRow, update, maxIter, rules)) {
      var row = isGoodSwap(iter, updateRow, update, maxIter, rules)
      return swap(row, rules)
    }
    iter = iter + 1
  }
  updateRow
}
def isGoodSwap(start: Int, row: Array[String], value: String, end: Int, rules: collection.mutable.Map[String, Array[String]]): Array[String] = {
  if (!rules.contains(value)) {
    return row
  }
  if (start == end) {
    return row
  }

  var jiter = start + 1
  for (gliter <- jiter to end) {
    for (rule <- rules.apply(value)) {
      if (rule == row.apply(gliter)) {
        var temp = row.apply(start)
        row(start) = row.apply(gliter)
        row(gliter) = temp
        return row
      }
    }
  }
  row
}


def lessonA(): Unit = {
  val source = scala.io.Source.fromFile("/mnt/media1/projects/github.com/advent-of-code/2024/lesson5/input")
  val rules = collection.mutable.Map[String, Array[String]]()
  var updates = Array[Array[String]]()
  var secondInput = false

  for (line <- source.getLines()) {
    breakable {
      if (line.isEmpty) {
        secondInput = true
        break()
      }
      if (secondInput) {
        updates = updates.appended(line.split(","))
      } else {
        val parts = line.split("\\|")
        if (!rules.contains(parts.apply(1))) {
          rules.put(parts.apply(1), Array(parts.apply(0)))
        } else {
          rules.put(parts.apply(1), rules.apply(parts.apply(1)).appended(parts.apply(0)))
        }
      }
    }
  }

  var sum = 0

  for (updateRow <- updates) {
    breakable {
      var iter = 0
      var maxIter = updateRow.length - 1
      for (update <- updateRow) {
        if (!isGood(iter, updateRow, update, maxIter, rules)) {
          break
        }
        iter = iter + 1
      }
      val key = ((updateRow.length) / 2).round
      sum = updateRow.apply(key).toInt + sum
    }
  }

  println(sum)
  source.close()
}

def isGood(start: Int, row: Array[String], value: String, end: Int, rules: collection.mutable.Map[String, Array[String]]): Boolean = {
  if (!rules.contains(value)) {
    return true
  }
  if (start == end) {
    return true
  }

  var jiter = start + 1
  for (gliter <- jiter to end) {
    for (rule <- rules.apply(value)) {
      if (rule == row.apply(gliter)) {
        return false
      }
    }
  }
  true
}
