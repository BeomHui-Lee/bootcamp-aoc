const Fs = require("fs");
const text = Fs.readFileSync("input/Week2/Year2020Day2.sample.txt", "utf8");

const answer = (arr) => {
    return arr.reduce((total, curr) => total + (curr ? 1 : 0), 0)
}

const checkRange = (r, arr) => {
    const [min, max] = r.split('-')
    return arr !== null ? (arr.length >= parseInt(min)) && (arr.length <= parseInt(max)) : false
}

const calcArray = (arr) => {
    const [arr_1, arr_2, arr_3] = arr
    const re = new RegExp(arr_2, 'gi')
    const tempArr = arr_3.match(re)

    return checkRange(arr_1, tempArr)
}

const makeArray = (str) => {
    const x1 = str.split("\n") // ::string -> array<string>
    const x2 = x1.map(s => s.replace(":", "").split(" ")) // ::array<string> -> array<array<string>>
    /*
        x2 ::
        [
            [ '1-3', 'a', 'abcde' ],
            [ '1-3', 'b', 'cdefg' ],
            [ '2-9', 'c', 'ccccccccc' ]
        ]
    */
    const x3 = x2.map(arr => calcArray(arr))
    /*
        x3 ::
        [ true, false, true ]
    */
    return answer(x3)
}

/*
input ::
    1-3 a: abcde
    1-3 b: cdefg
    2-9 c: ccccccccc
*/
const part1 = (input) => makeArray(input)

console.log(part1(text))
// console.log(calcArray(text))
