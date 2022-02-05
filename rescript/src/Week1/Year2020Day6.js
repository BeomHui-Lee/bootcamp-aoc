const Fs = require("fs");
const input = Fs.readFileSync("input/Week1/Year2020Day6.txt", "utf8");

const sample = "abc\na\na\nbc\ncd"
const set = new Set(["a", "a", "c"]) // => { a, c }

const multiLineToSet = (str) => {
    // x1 :: Array<string>
    const x1 = str.split("\n")

    // x2 = [[a,b,c], [a], [a], [b,c], [c,d]] :: Array<Array<string>>
    const x2 = x1.flatMap(s => s.split("")) // rescript에 flatmap이 없음. 그래서 map -> concatMany

    // x3 = [a,b,c,a,a,b,c,c,d] :: Array<string>

    // flatMap :: (a -> Option<b>) -> Option<a> -> Option<b>
    const x4 = new Set(x2) // Belt.Set.String.fromArray
    return x4
}

const multiLineToSet2 = (str) => {
    const x1 = str.split("\n")
    return x1
}

// allToGroup :: string => Array<string>
const allToGroup = (str) => {
    return str.split("\n\n")
}

// x1 :: Array<Set<string>>
const x1 = allToGroup(input).map(group => multiLineToSet(group))
const sum = (xs) => xs.reduce((total, curr) => total + curr, 0)
const program = (input, f) => sum(allToGroup(input).map(group => f(group)).map(s => s.size))
const part1 = (input) => program(input, multiLineToSet)
const part2 = (input) => program(input, multiLineToSet2)

// size :: Set<string> => number
// Array<Set<string>> => Array<number>

// console.log(sum(x1.map(s => s.size)))
console.log(part1(input))
// console.log(part2(input))

console.log(allToGroup(input).map(group => multiLineToSet2(group)))

