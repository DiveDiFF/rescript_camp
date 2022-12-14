// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Fs = require("fs");
var Belt_Array = require("rescript/lib/js/belt_Array.js");
var Caml_array = require("rescript/lib/js/caml_array.js");
var Caml_int32 = require("rescript/lib/js/caml_int32.js");

var input = Fs.readFileSync("input/Week1/Year2020Day3.sample.txt", "utf8");

var roadMap = input.split("\n");

function getNumberOfTree(roadMap, slope) {
  var end = roadMap.length - 1 | 0;
  var path = {
    contents: []
  };
  var getPosition = function (x, y) {
    if (y > end) {
      return ;
    }
    var newRight = Caml_int32.mod_(x + slope.right | 0, Caml_array.get(roadMap, y).length);
    getPosition(newRight, y + slope.down | 0);
    path.contents.push(Caml_array.get(roadMap, y).charAt(newRight));
  };
  getPosition(0, slope.down);
  return path.contents.filter(function (item) {
              return item === "#";
            }).length;
}

var resultList = [
  getNumberOfTree(roadMap, {
        right: 1,
        down: 1
      }),
  getNumberOfTree(roadMap, {
        right: 3,
        down: 1
      }),
  getNumberOfTree(roadMap, {
        right: 5,
        down: 1
      }),
  getNumberOfTree(roadMap, {
        right: 7,
        down: 1
      }),
  getNumberOfTree(roadMap, {
        right: 1,
        down: 2
      })
];

console.log(Belt_Array.reduce(resultList, 1.0, (function (acc, currentVal) {
            return acc * currentVal;
          })));

exports.input = input;
exports.roadMap = roadMap;
exports.getNumberOfTree = getNumberOfTree;
exports.resultList = resultList;
/* input Not a pure module */
