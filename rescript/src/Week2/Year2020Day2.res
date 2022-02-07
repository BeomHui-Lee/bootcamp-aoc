// ----- 문제 읽어오기 -----
let text = Node.Fs.readFileAsUtf8Sync("input/Week2/Year2020Day2.txt")

// ----- 알고리즘 -----
/*
1. 텍스트를 입력 받아 범위,찾을문자,문자열 로 분할된 배열로 변환하는 함수 (makeSplitArray)
2. 배열의 3요소를 각각 잘게 쪼개서 최소값,최대값, 비교할 문자, 문자열의 배열로 변환 하는 함수
3. (파트1) 배열을 돌면서 비교할 문자와 같은것만 남겨 새로운 배열로 만들어주는 함수
    3-1. 새로운 배열의 길이가 최소,최대값에 속하면 1, 아니면 0으로 리턴해주는 함수
4. (파트2) 배열을 돌면서 최소값,최대값의 인덱스+1에 해당하는 문자만 남겨 새로운 배열로 만들어주는 함수
    4-1. 새로운 배열을 돌면서 비교할문자와 같은것만 남겨, 길이가 1이면 1, 아니면 0으로 리턴하는 함수
5. 1과0으로 이루어진 배열을 돌면서 합계 계산해주는 함수
*/

// ------------------------- 파트 2 ----------------------------
let checkArray = (arr, char) => {
  switch Some(arr) {
  | Some(a) =>
    switch a->Belt.Array.keep(x => x === char[0])->Belt.Array.length {
    | 1 => 1
    | _ => 0
    }
  | None => 0
  }
}

let checkPoint = arr => {
  switch arr {
  | [[min, max], char, array] =>
    array
    ->Belt.Array.keepWithIndex((_x, i) =>
      Some(i + 1) === Belt.Int.fromString(min) || Some(i + 1) === Belt.Int.fromString(max)
    )
    ->checkArray(char)
  | _ => 0
  }
}
// :: [["1","3"],["a"],["a","b","e","a"]] -> ["a","e"] -> 1 or 0
// ------------------------------------------------------------

// ------------------------- 파트 1 ----------------------------
let countArray = (arr, min, max) => {
  switch Some(arr) {
  | Some(a) =>
    switch Some(Belt.Array.length(a)) >= Belt.Int.fromString(min) &&
      Some(Belt.Array.length(a)) <= Belt.Int.fromString(max) {
    | true => 1
    | false => 0
    }
  | None => 0
  }
}

let checkSame = arr => {
  switch arr {
  | [[min, max], char, array] => array->Belt.Array.keep(x => x === char[0])->countArray(min, max)
  | _ => 0
  }
}
// :: [["1","3"],["a"],["a","b","e","a"]] -> ["a","a"] -> 1 or 0
// ------------------------------------------------------------
let answer = bool_arr => {
  bool_arr->Belt.Array.reduce(0, (total, curr) => total + curr)
}

let splitArray = arr => {
  let tempArr = []
  switch arr {
  | [arr_1, arr_2, arr_3] =>
    let _ = Js.Array2.push(tempArr, arr_1->Js.String2.split("-"))
    let _ = Js.Array2.push(tempArr, [arr_2])
    let _ = Js.Array2.push(tempArr, arr_3->Js.String2.split(""))
    tempArr
  | _ => []
  }
}
// :: [ "1-3", "a", "abea" ] -> [["1","3"],["a"],["a","b","e","a"]]

let makeArray = str => {
  str
  ->Js.String2.split("\n") // ::String -> Array<String>
  ->Belt.Array.map(s => s->Js.String2.replace(":", "")->Js.String2.split(" ")) // ::Array<Array<String>>
}
// :: [[ "1-3", "a", "abcde" ],[ "1-3", "b", "cdefg" ],[ "2-9", "c", "ccccccccc" ]]

let program = (input, f) => {
  makeArray(input)->Belt.Array.map(arr => splitArray(arr))->Belt.Array.map(arr => f(arr))->answer
}

let part1 = input => {
  program(input, checkSame)->Js.log
}

let part2 = input => {
  program(input, checkPoint)->Js.log
}

part1(text)
part2(text)
