// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Fs = require("fs");
var Curry = require("rescript/lib/js/curry.js");
var Belt_Array = require("rescript/lib/js/belt_Array.js");
var Caml_array = require("rescript/lib/js/caml_array.js");
var Caml_splice_call = require("rescript/lib/js/caml_splice_call.js");

var text = Fs.readFileSync("input/Week1/Year2020Day5.txt", "utf8");

var qArray = text.split("\n");

var min = {
  contents: 0
};

var max = {
  contents: 127
};

var seatID = {
  contents: 0
};

var seatArray = [];

function makeMinMax(code) {
  var exit = 0;
  switch (code) {
    case "F" :
    case "L" :
        exit = 1;
        break;
    case "B" :
    case "R" :
        exit = 2;
        break;
    default:
      return ;
  }
  switch (exit) {
    case 1 :
        max.contents = max.contents - (((max.contents - min.contents | 0) + 1 | 0) / 2 | 0) | 0;
        return ;
    case 2 :
        min.contents = (((max.contents - min.contents | 0) + 1 | 0) / 2 | 0) + min.contents | 0;
        return ;
    
  }
}

function part_one(qArray) {
  Belt_Array.forEach(qArray, (function (x) {
          for(var i = 0 ,i_finish = x.length; i < i_finish; ++i){
            if (i === 7) {
              seatID.contents = (min.contents << 3);
              min.contents = 0;
              max.contents = 7;
            }
            makeMinMax(x[i]);
          }
          seatID.contents = seatID.contents + min.contents | 0;
          seatArray.push(seatID.contents);
          min.contents = 0;
          max.contents = 127;
          
        }));
  console.log(Caml_splice_call.spliceApply(Math.max, [seatArray]));
  
}

function part_two(qArray) {
  part_one(qArray);
  seatArray.sort(function (a, b) {
        return a - b | 0;
      });
  for(var i = 1 ,i_finish = seatArray.length; i < i_finish; ++i){
    if (Caml_array.get(seatArray, i) !== (Caml_array.get(seatArray, i - 1 | 0) + 1 | 0)) {
      console.log(Caml_array.get(seatArray, i) - 1 | 0);
    }
    
  }
  
}

function part2(arr) {
  var firstSeat = Caml_array.get(arr, 0) - 1 | 0;
  return Belt_Array.reduce(arr, firstSeat, (function (prev, next) {
                if (next === (prev + 1 | 0)) {
                  return prev + 1 | 0;
                } else {
                  return prev;
                }
              })) + 1 | 0;
}

function part1(arr) {
  return Caml_array.get(arr, arr.length - 1 | 0);
}

function makeSeatID(arr) {
  return Belt_Array.reduceWithIndex(arr, 0, (function (acc, x, i) {
                return (acc + x | 0) + i | 0;
              }));
}

function convertBinary($$char) {
  switch ($$char) {
    case "B" :
    case "R" :
        return 1;
    default:
      return 0;
  }
}

function convertArray(str) {
  return Belt_Array.map(str.split(""), convertBinary);
}

function makeArray(input) {
  return input.split("\n");
}

function program(input) {
  return Belt_Array.map(Belt_Array.map(input.split("\n"), convertArray), makeSeatID);
}

function answer(input, f) {
  console.log(Curry._1(f, program(input).sort(function (a, b) {
                return a - b | 0;
              })));
  
}

answer(text, part1);

answer(text, part2);

exports.text = text;
exports.qArray = qArray;
exports.min = min;
exports.max = max;
exports.seatID = seatID;
exports.seatArray = seatArray;
exports.makeMinMax = makeMinMax;
exports.part_one = part_one;
exports.part_two = part_two;
exports.part2 = part2;
exports.part1 = part1;
exports.makeSeatID = makeSeatID;
exports.convertBinary = convertBinary;
exports.convertArray = convertArray;
exports.makeArray = makeArray;
exports.program = program;
exports.answer = answer;
/* text Not a pure module */
