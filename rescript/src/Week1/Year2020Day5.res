// ----- 문제 읽어오기 -----
let text = Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day5.txt")
let qArray = Js.String2.split(text, "\n") // 문제를 로우별로 qArray에 저장

let answer = 0

// ----- 변수 및 함수 선언 -----
let min = ref(0)
let max = ref(127)
let seatID = ref(0)

let seatArray = []

let makeSeatArray = seat => {
  Js.Array2.push(seatArray, seat)
}

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
  let _ = makeSeatArray(seatID.contents)

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
part_two(qArray)

// seatArray 의 최대값을 반환하며 종료 ->
// SeatArray 를 만드는 함수 ->
// seatArray의 인자 seat를 만드는 함수 ->
// seat를 구하기 위해 min,max를 계산하는 함수 ->
// min,max를 구하기 위해 qArray의 한 요소(한 문장)를 순회 하는 함수 ->
// qArray의 한 문장을 순회하며 한 문자를 판별 하는 함수
