// let text = Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day3.sample.txt")
let text = Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day3.txt")

let qArray = Js.String2.split(text, "\n") // 문제를 로우별로 qArray에 저장
let moveArray = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]] // 파트2 의 이동 칸수를 저장한 배열, 파트1 문제는 moveArray[1]
let num = Js.String2.length(qArray[0]) // 문제 한 줄에 몇개의 문자가 있는지

let tempX = ref(0) // 우측으로 이동하는 값을 체크하는 변수
let tempArray = qArray // 문자열 표기를 위한 배열
let totalString = ref(tempArray[0] ++ "\n")
let count = ref(0.0) // X 개수가 몇개인지 카운트
let countArray = [] // -> 파트 2 에서 사용

let question = part => {
  switch part {
  | "Part1" =>
    Js.log(`---------- 파트 1 ----------`)
    for i in 1 to Belt.Array.length(qArray) - 1 {
      if mod(i, moveArray[1][1]) === 0 {
        // y축 이동
        tempX := tempX.contents + moveArray[1][0] // x축 이동
        tempX.contents > num - 1 ? tempX := tempX.contents - num : tempX := tempX.contents // 우측 끝을 벗어나면 다시 좌측부터(연장 개념)
        let s = ref(tempArray[i])

        switch Js.String2.substrAtMost(s.contents, ~from=tempX.contents, ~length=1) {
        | "#" =>
          s :=
            Js.String2.substrAtMost(s.contents, ~from=0, ~length=tempX.contents) ++
            "X" ++
            Js.String2.substrAtMost(s.contents, ~from=tempX.contents + 1, ~length=num)
          count := count.contents +. 1.0 // X 표시가 찍혔을때 카운트 증가
        | "." =>
          s :=
            Js.String2.substrAtMost(s.contents, ~from=0, ~length=tempX.contents) ++
            "O" ++
            Js.String2.substrAtMost(s.contents, ~from=tempX.contents + 1, ~length=num)
        | _ => Js.log(s)
        }
        tempArray[i] = s.contents
      }
      totalString := totalString.contents ++ tempArray[i] ++ "\n"
    }
    Js.log(totalString.contents) // 화면 표현을 위한 컨텐츠
    Js.log(`답은 ` ++ Js.Float.toString(count.contents) ++ ` 개 입니다.`) // 답
  | "Part2" =>
    Js.log(`---------- 파트 2 ----------`)
    for j in 0 to Belt.Array.length(moveArray) - 1 {
      for i in 1 to Belt.Array.length(qArray) - 1 {
        switch mod(i, moveArray[j][1]) {
        | 0 =>
          tempX := tempX.contents + moveArray[j][0]
          if tempX.contents > num - 1 {
            tempX := tempX.contents - num
          }
          if Js.String2.substrAtMost(qArray[i], ~from=tempX.contents, ~length=1) === "#" {
            count := count.contents +. 1.0
          }
        | _ =>
          let _ = `null`
        }
      }
      tempX := 0
      let _ = Js.Array2.push(countArray, count.contents)
      count := 0.0
    }
    Js.log(countArray)
    count := Belt.Array.reduce(countArray, 1.0, (a, b) => a *. b)
    Js.log(`답은 ` ++ Js.Float.toString(count.contents) ++ ` 개 입니다.`) // 답
  | _ => Js.log("etcPart")
  }
}

question("Part1")
// question("Part2")
