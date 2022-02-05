// ----- 문제 읽어오기 -----
let text = Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day6.txt")

let sum = xs => {
  Belt.Array.reduce(xs, 0, (total, curr) => total + curr)
}

let initSet = Js.String2.split("abcdefghijklmnopqrstuvwxyz", "")->Belt.Set.String.fromArray

// Js.String2.t => Belt.Set.String.t
let multiLineToSet = str => {
  str
  ->Js.String2.split("\n")
  ->Belt.Array.map(s => Js.String2.split(s, ""))
  ->Belt.Array.concatMany
  ->Belt.Set.String.fromArray
}

let multiLineToSet2 = str => {
  str
  ->Js.String2.split("\n")
  ->Belt.Array.map(s => Js.String2.split(s, "")) //array<array<string>>
  ->Belt.Array.map(arr => Belt.Set.String.fromArray(arr)) //array<set<string>>
  ->Belt.Array.reduce(initSet, (prev, current) => Belt.Set.String.intersect(prev, current))
}

let allToGroup = str => {
  str->Js.String2.split("\n\n")
}

let program = (input, f) => {
  allToGroup(input)->Belt.Array.map(group => f(group))->Belt.Array.map(Belt.Set.String.size)->sum
}

let part1 = input => {
  program(input, multiLineToSet)->Js.log
}

let part2 = input => {
  program(input, multiLineToSet2)->Js.log
}

part1(text)
part2(text)
