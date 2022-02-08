// ----- 문제 읽어오기 -----
let text = Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day5.txt")
let qArray = Js.String2.split(text, "\n") // 문제를 로우별로 qArray에 저장

// ----- 변수 및 함수 선언 -----
let min = ref(0)
let max = ref(127)
let seatID = ref(0)
let seatArray = []

let makeMinMax = code => {
  switch code {
  | "F" | "L" => max := max.contents - (max.contents - min.contents + 1) / 2
  | "B" | "R" => min := (max.contents - min.contents + 1) / 2 + min.contents
  | _ => ()
  }
}

let makeSeatID = oneOf_qArray => {
  for i in 0 to Js.String2.length(oneOf_qArray) - 1 {
    if i === 7 {
      seatID := min.contents * 8
      min := 0
      max := 7
    }
    makeMinMax(Js.String2.get(oneOf_qArray, i))
  }
  seatID := seatID.contents + min.contents
  let _ = Js.Array2.push(seatArray, seatID.contents)

  min := 0
  max := 127
}

let part_one = qArray => {
  Belt.Array.forEach(qArray, x => makeSeatID(x))
  Js.log(Js.Math.maxMany_int(seatArray))
}

let part_two = qArray => {
  part_one(qArray)
  let _ = Js.Array.sortInPlaceWith((a, b) => a - b, seatArray)
  for i in 1 to Belt.Array.length(seatArray) - 1 {
    if seatArray[i] !== seatArray[i - 1] + 1 {
      Js.log(seatArray[i] - 1)
    }
  }
}

// ----- 실행 -----
// part_one(qArray)
// part_two(qArray)

// ---------------------------------------------
// ---------------------------------------------
// ---------------------------------------------

let part2 = arr => {
  let firstSeat = arr[0] - 1
  arr->Belt.Array.reduce(firstSeat, (prev, next) => {
    switch next === prev + 1 {
    | true => prev + 1
    | false => prev
    }
  }) + 1
}

let part1 = arr => {
  arr[Belt.Array.length(arr) - 1]
}

let makeSeatID = arr => {
  arr->Belt.Array.reduceWithIndex(0, (acc, x, i) => {
    //   arr->Belt.Array.reduceWithIndex(0, (acc, x, i) => {
    // let exp = Belt.Array.length(arr) - (i + 1)
    // let increment = Js.Math.pow_int(~base=2, ~exp)
    // acc + x * increment
    acc + x + i
  })
}
// :: [0,0,1,0,0,0,1,1,1,0] -> [142]

let convertBinary = char => {
  switch char {
  | "B" | "R" => 1
  | _ => 0
  }
}

let convertArray = str => {
  str->Js.String2.split("")->Belt.Array.map(char => convertBinary(char))
}
// :: "BFFFBBFLRR" -> ["B","F","F","F","B"...] -> [1,0,0,0,1,...]

let makeArray = input => {
  input->Js.String2.split("\n")
}
// :: ["BFFFBBFLRR", "FBBBFFFRLR", ...]

let program = input => {
  input->makeArray->Belt.Array.map(str => convertArray(str))->Belt.Array.map(arr => makeSeatID(arr))
}

let answer = (input, f) => {
  ((a, b) => a - b)->Js.Array.sortInPlaceWith(program(input))->f->Js.log
}

answer(text, part1)
answer(text, part2)
