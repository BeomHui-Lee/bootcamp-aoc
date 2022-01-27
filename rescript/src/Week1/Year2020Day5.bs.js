// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Fs = require("fs");
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

function makeSeatArray(seat) {
  return seatArray.push(seat);
}

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

function makeSeatID(oneOf_qArray) {
  for(var i = 0 ,i_finish = oneOf_qArray.length; i < i_finish; ++i){
    if (i === 7) {
      seatID.contents = (min.contents << 3);
      min.contents = 0;
      max.contents = 7;
    }
    makeMinMax(oneOf_qArray[i]);
  }
  seatID.contents = seatID.contents + min.contents | 0;
  seatArray.push(seatID.contents);
  min.contents = 0;
  max.contents = 127;
  
}

function part_one(qArray) {
  Belt_Array.forEach(qArray, makeSeatID);
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

part_two(qArray);

var answer = 0;

exports.text = text;
exports.qArray = qArray;
exports.answer = answer;
exports.min = min;
exports.max = max;
exports.seatID = seatID;
exports.seatArray = seatArray;
exports.makeSeatArray = makeSeatArray;
exports.makeMinMax = makeMinMax;
exports.makeSeatID = makeSeatID;
exports.part_one = part_one;
exports.part_two = part_two;
/* text Not a pure module */
