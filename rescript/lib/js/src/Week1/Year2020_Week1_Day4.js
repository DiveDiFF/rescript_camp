// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Fs = require("fs");
var Js_dict = require("rescript/lib/js/js_dict.js");
var Belt_Int = require("rescript/lib/js/belt_Int.js");
var Belt_Array = require("rescript/lib/js/belt_Array.js");
var Belt_Option = require("rescript/lib/js/belt_Option.js");

var input = Fs.readFileSync("input/Week1/Year2020Day4.sample.txt", "utf8");

var inputList = Belt_Array.map(input.split("\n\n"), (function (passport) {
        return Js_dict.fromArray(Belt_Array.keepMap(Belt_Array.concatMany(Belt_Array.map(passport.split("\n"), (function (item) {
                                  return item.split(" ");
                                }))), (function (item) {
                          var match = item.split(":");
                          if (match.length !== 2) {
                            return ;
                          }
                          var key = match[0];
                          var value = match[1];
                          return [
                                  key,
                                  value
                                ];
                        })));
      }));

var validList = Belt_Array.keepMap(inputList, (function (dict) {
        var match = Belt_Option.flatMap(Js_dict.get(dict, "byr"), Belt_Int.fromString);
        var match$1 = Belt_Option.flatMap(Js_dict.get(dict, "iyr"), Belt_Int.fromString);
        var match$2 = Belt_Option.flatMap(Js_dict.get(dict, "eyr"), Belt_Int.fromString);
        var match$3 = Js_dict.get(dict, "hgt");
        var match$4 = Js_dict.get(dict, "hcl");
        var match$5 = Js_dict.get(dict, "ecl");
        var match$6 = Js_dict.get(dict, "pid");
        var match$7 = Js_dict.get(dict, "cid");
        if (match !== undefined && match$1 !== undefined && match$2 !== undefined && match$3 !== undefined && match$4 !== undefined && match$5 !== undefined && match$6 !== undefined) {
          return {
                  byr: match,
                  iyr: match$1,
                  eyr: match$2,
                  hgt: match$3,
                  hcl: match$4,
                  ecl: match$5,
                  pid: match$6,
                  cid: match$7
                };
        }
        
      }));

console.log(validList.length);

var strictValidList = Belt_Array.keepMap(validList, (function (passport) {
        var match = passport.byr >= 1920 && passport.byr <= 2002 ? passport.byr : undefined;
        var match$1 = passport.iyr >= 2010 && passport.iyr <= 2020 ? passport.iyr : undefined;
        var match$2 = passport.eyr >= 2020 && passport.eyr <= 2030 ? passport.eyr : undefined;
        var match$3 = Belt_Int.fromString(passport.hgt.slice(0, -2));
        var match$4 = passport.hgt.slice(-2);
        var match$5;
        if (match$3 !== undefined) {
          switch (match$4) {
            case "cm" :
                match$5 = match$3 >= 150 && match$3 <= 193 ? ({
                      TAG: /* Cm */0,
                      _0: match$3
                    }) : undefined;
                break;
            case "in" :
                match$5 = match$3 >= 59 && match$3 <= 76 ? ({
                      TAG: /* In */1,
                      _0: match$3
                    }) : undefined;
                break;
            default:
              match$5 = undefined;
          }
        } else {
          match$5 = undefined;
        }
        var match$6 = /^\#[\d|a-f$]{6}/.test(passport.hcl) ? passport.hcl : undefined;
        var match$7 = passport.ecl;
        var match$8;
        switch (match$7) {
          case "amb" :
              match$8 = /* Amb */0;
              break;
          case "blu" :
              match$8 = /* Blu */1;
              break;
          case "brn" :
              match$8 = /* Brn */2;
              break;
          case "grn" :
              match$8 = /* Grn */4;
              break;
          case "gry" :
              match$8 = /* Gry */3;
              break;
          case "hzl" :
              match$8 = /* Hzl */5;
              break;
          case "oth" :
              match$8 = /* Oth */6;
              break;
          default:
            match$8 = undefined;
        }
        var match$9 = /^[0-9]{9}$/g.test(passport.pid) ? passport.pid : undefined;
        var match$10 = passport.cid;
        if (match !== undefined && match$1 !== undefined && match$2 !== undefined && match$5 !== undefined && match$6 !== undefined && match$8 !== undefined && match$9 !== undefined) {
          return {
                  byr: match,
                  iyr: match$1,
                  eyr: match$2,
                  hgt: match$5,
                  hcl: match$6,
                  ecl: match$8,
                  pid: match$9,
                  cid: match$10
                };
        }
        
      }));

console.log(strictValidList.length);

exports.input = input;
exports.inputList = inputList;
exports.validList = validList;
exports.strictValidList = strictValidList;
/* input Not a pure module */
