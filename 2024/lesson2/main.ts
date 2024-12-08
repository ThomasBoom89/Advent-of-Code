// console.log(a());
console.log(b());

function isValidA(splitted: number[], direction: boolean): number {
  let result = 1;
  // console.warn("direction is: ", direction);
  for (let i = 0; i < splitted.length - 1; i++) {
    // console.warn(i);
    if (
      direction &&
      (((splitted[i + 1] - splitted[i]) < 1) ||
        ((splitted[i + 1] - splitted[i]) > 3))
    ) {
      result = 0;
    }
    if (
      !direction &&
      (((splitted[i] - splitted[i + 1]) < 1) ||
        ((splitted[i] - splitted[i + 1]) > 3))
    ) {
      result = 0;
    }
  }
  if (!result) {
    console.warn("line: ", splitted);
  }
  return result;
}

function a(): number {
  const data = Deno.readTextFileSync("input");
  const lines = data.split("\n");
  let sum = 0;

  console.warn("count: ", lines.length);

  for (const line of lines) {
    if (line === "") {
      continue;
    }
    const splitted: number[] = line.split(" ").map((value, index, array) => {
      return Number(value);
    });
    if (splitted[0] === splitted[1]) {
      continue;
    }
    if (splitted.join(" ") != line) {
      throw new Error(`line "${line}" not found`);
    }
    // true if up
    const direction = splitted[0] < splitted[1];
    // console.warn(Number(isValid(splitted, direction)))
    sum = sum + isValidA(splitted, direction);
  }
  return sum;
}

function isValidB(
  splitted: number[],
  direction: boolean,
): number {
  let result = 1;
  // console.warn("direction is: ", direction);
  for (let i = 0; i < splitted.length - 1; i++) {
    // console.warn(i);
    if (
      direction &&
      (((splitted[i + 1] - splitted[i]) < 1) ||
        ((splitted[i + 1] - splitted[i]) > 3))
    ) {
      result = 0;
    }
    if (
      !direction &&
      (((splitted[i] - splitted[i + 1]) < 1) ||
        ((splitted[i] - splitted[i + 1]) > 3))
    ) {
      result = 0;
    }
  }
  if (!result) {
    // console.warn("line: ", splitted);
  }
  return result;
}

function b(): number {
  const data = Deno.readTextFileSync("input");
  const lines = data.split("\n");
  let sum = 0;

  console.warn("count: ", lines.length);

  for (const line of lines) {
    if (line === "") {
      continue;
    }
    const splitted: number[] = line.split(" ").map((value, index, array) => {
      return Number(value);
    });
    let direction = splitted[0] < splitted[1];
    if (isValidB(splitted, direction) === 1) {
      sum = sum + 1;
      continue;
    }
    let subsum = 0;

    for (let index = 0; index < splitted.length; index++) {
      const neues = splitted.toSpliced(index, 1);
      direction = neues[0] < neues[1];
      subsum = subsum + isValidB(neues, direction);
    }
    if (subsum > 0) {
      sum = sum + 1;
    }
  }
  return sum;
}
