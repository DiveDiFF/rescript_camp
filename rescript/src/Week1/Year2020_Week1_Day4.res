let input = Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day4.sample.txt")

type passportKeyType = Byr | Iyr | Eyr | Hgt | Hcl | Ecl | Pid | Cid

type eyeColorType = Amb | Blu | Brn | Gry | Grn | Hzl | Oth
// type passportType = {
//   byr?: option<int>,
//   iyr?: option<int>,
//   eyr?: option<int>,
//   hgt?: (option<int>, option<heightUnitType>),
//   hcl?: option<string>,
//   ecl?: option<eyeColorType>,
//   pid?: option<string>,
//   cid?: option<string>,
// }

type passportType = {
  byr: int,
  iyr: int,
  eyr: int,
  hgt: string,
  hcl: string,
  ecl: string,
  pid: string,
  cid: option<string>,
}

let inputList =
  input
  ->Js.String2.split("\n\n")
  ->Belt.Array.map(passport => {
    passport
    ->Js.String2.split("\n")
    ->Belt.Array.map(item => item->Js.String2.split(" "))
    ->Belt.Array.concatMany
    ->Belt.Array.keepMap(item => {
      switch item->Js.String2.split(":") {
      | [key, value] => Some(key, value)
      | _ => None
      }
    })
    ->Js.Dict.fromArray
  })

let validList: array<passportType> = inputList->Belt.Array.keepMap(dict => {
  switch (
    dict->Js.Dict.get("byr")->Belt.Option.flatMap(Belt.Int.fromString),
    dict->Js.Dict.get("iyr")->Belt.Option.flatMap(Belt.Int.fromString),
    dict->Js.Dict.get("eyr")->Belt.Option.flatMap(Belt.Int.fromString),
    dict->Js.Dict.get("hgt"),
    dict->Js.Dict.get("hcl"),
    dict->Js.Dict.get("ecl"),
    dict->Js.Dict.get("pid"),
    dict->Js.Dict.get("cid"),
  ) {
  | (Some(byr), Some(iyr), Some(eyr), Some(hgt), Some(hcl), Some(ecl), Some(pid), cid) =>
    Some({
      byr,
      iyr,
      eyr,
      hgt,
      hcl,
      ecl,
      pid,
      cid,
    })
  | _ => None
  }
})

// part1

validList->Belt.Array.length->Js.log

// part2

type heightUnitType = Cm(int) | In(int)

type strictPassportType = {
  byr: int,
  iyr: int,
  eyr: int,
  hgt: heightUnitType,
  hcl: string,
  ecl: eyeColorType,
  pid: string,
  cid: option<string>,
}

let strictValidList = validList->Belt.Array.keepMap(passport => {
  switch (
    switch passport.byr >= 1920 && passport.byr <= 2002 {
    | true => Some(passport.byr)
    | false => None
    },
    switch passport.iyr >= 2010 && passport.iyr <= 2020 {
    | true => Some(passport.iyr)
    | false => None
    },
    switch passport.eyr >= 2020 && passport.eyr <= 2030 {
    | true => Some(passport.eyr)
    | false => None
    },
    switch (
      passport.hgt->Js.String2.slice(~from=0, ~to_=-2)->Belt.Int.fromString,
      passport.hgt->Js.String2.sliceToEnd(~from=-2),
    ) {
    | (Some(height), "cm") =>
      switch height >= 150 && height <= 193 {
      | true => Some(Cm(height))
      | false => None
      }
    | (Some(height), "in") =>
      switch height >= 59 && height <= 76 {
      | true => Some(In(height))
      | false => None
      }
    | _ => None
    },
    switch Js.Re.test_(%re("/^\#[\d|a-f$]{6}/"), passport.hcl) {
    | true => Some(passport.hcl)
    | false => None
    },
    switch passport.ecl {
    | "amb" => Some(Amb)
    | "blu" => Some(Blu)
    | "brn" => Some(Brn)
    | "gry" => Some(Gry)
    | "grn" => Some(Grn)
    | "hzl" => Some(Hzl)
    | "oth" => Some(Oth)
    | _ => None
    },
    switch Js.Re.test_(%re("/^[0-9]{9}$/g"), passport.pid) {
    | true => Some(passport.pid)
    | false => None
    },
    passport.cid,
  ) {
  | (Some(byr), Some(iyr), Some(eyr), Some(hgt), Some(hcl), Some(ecl), Some(pid), cid) =>
    Some({
      byr,
      iyr,
      eyr,
      hgt,
      hcl,
      ecl,
      pid,
      cid,
    })
  | _ => None
  }
})
// strictValidList->Js.log

strictValidList->Belt.Array.length->Js.log

// inputList
// ->Belt.Array.map(dict => {
//   switch (
//     switch dict->Js.Dict.get("byr")->Belt.Option.getWithDefault("")->Belt.Int.fromString {
//     | Some(v) =>
//       switch v >= 1920 && v <= 2002 {
//       | true => Some(v)
//       | false => None
//       }
//     | _ => None
//     },
//     switch dict->Js.Dict.get("iyr")->Belt.Option.getWithDefault("")->Belt.Int.fromString {
//     | Some(v) =>
//       switch v >= 2010 && v <= 2020 {
//       | true => Some(v)
//       | false => None
//       }

//     | _ => None
//     },
//     switch dict->Js.Dict.get("eyr")->Belt.Option.getWithDefault("")->Belt.Int.fromString {
//     | Some(v) =>
//       switch v >= 2020 && v <= 2030 {
//       | true => Some(v)
//       | false => None
//       }
//     | _ => None
//     },
//     switch dict->Js.Dict.get("hgt") {
//     | Some(v) =>
//       switch v->Js.String2.sliceToEnd(~from=2) {
//       | "cm" => (
//           switch v
//           ->Js.String2.substring(~from=0, ~to_=v->Js.String2.indexOf("c") + 1)
//           ->Belt.Int.fromString {
//           | Some(v) =>
//             switch v >= 150 && v <= 193 {
//             | true => Some(v)
//             | false => None
//             }
//           | _ => None
//           },
//           Some(Cm),
//         )
//       | "in" => (
//           switch v
//           ->Js.String2.substring(~from=0, ~to_=v->Js.String2.indexOf("i") + 1)
//           ->Belt.Int.fromString {
//           | Some(v) =>
//             switch v >= 59 && v <= 76 {
//             | true => Some(v)
//             | false => None
//             }
//           | _ => None
//           },
//           Some(In),
//         )
//       | _ => (None, None)
//       }
//     | _ => (None, None)
//     },
//     switch dict->Js.Dict.get("hcl") {
//     | Some(v) =>
//       switch Js.Re.test_(%re("/^\#[\d|a-f$]{6}/"), v) {
//       | true => Some(v)
//       | false => None
//       }
//     | _ => None
//     },
//     switch dict->Js.Dict.get("ecl") {
//     | Some(v) =>
//       switch v {
//       | "amb" => Some(Amb)
//       | "blu" => Some(Blu)
//       | "brn" => Some(Brn)
//       | "gry" => Some(Gry)
//       | "grn" => Some(Grn)
//       | "hzl" => Some(Hzl)
//       | "oth" => Some(Oth)
//       | _ => None
//       }
//     | _ => None
//     },
//     switch dict->Js.Dict.get("pid") {
//     | Some(v) =>
//       switch Js.Re.test_(%re("/[0-9]{9}/g"), v) {
//       | true => Some(v)
//       | false => None
//       }
//     | _ => None
//     },
//     dict->Js.Dict.get("cid"),
//   ) {
//   | (byr, iyr, eyr, (value, unit), hcl, ecl, pid, cid) => {
//       byr,
//       iyr,
//       eyr,
//       hgt: (value, unit),
//       hcl,
//       ecl,
//       pid,
//       cid,
//     }
//   }
// })
// ->Js.log

// let inputList =
//   input
//   ->Js.String2.split("\n\n")
//   ->Belt.Array.map(passport => {
//     passport
//     ->Js.String2.split("\n")
//     ->Belt.Array.map(item => item->Js.String2.split(" "))
//     ->Belt.Array.concatMany
//     ->Belt.Array.keepMap(item => {
//       switch item->Js.String2.split(":") {
//       | [key, value] => Some(key, value)
//       | _ => None
//       }
//     })
//     ->Js.Dict.fromArray
//   })
//   ->Belt.Array.map(item => {
//     {
//       byr: switch item->Js.Dict.get("byr")->Belt.Option.getWithDefault("")->Belt.Int.fromString {
//       | Some(v) =>
//         switch v >= 1920 && v <= 2002 {
//         | true => Some(v)
//         | false => None
//         }
//       | _ => None
//       },
//       iyr: switch item->Js.Dict.get("iyr")->Belt.Option.getWithDefault("")->Belt.Int.fromString {
//       | Some(v) =>
//         switch v >= 2010 && v <= 2020 {
//         | true => Some(v)
//         | false => None
//         }

//       | _ => None
//       },
//       eyr: switch item->Js.Dict.get("eyr")->Belt.Option.getWithDefault("")->Belt.Int.fromString {
//       | Some(v) =>
//         switch v >= 2020 && v <= 2030 {
//         | true => Some(v)
//         | false => None
//         }
//       | _ => None
//       },
//       hgt: switch item->Js.Dict.get("hgt") {
//       | Some(v) =>
//         switch v->Js.String2.sliceToEnd(~from=2) {
//         | "cm" => (
//             switch v
//             ->Js.String2.substring(~from=0, ~to_=v->Js.String2.indexOf("c") + 1)
//             ->Belt.Int.fromString {
//             | Some(v) =>
//               switch v >= 150 && v <= 193 {
//               | true => Some(v)
//               | false => None
//               }
//             | _ => None
//             },
//             Some(Cm),
//           )
//         | "in" => (
//             switch v
//             ->Js.String2.substring(~from=0, ~to_=v->Js.String2.indexOf("i") + 1)
//             ->Belt.Int.fromString {
//             | Some(v) =>
//               switch v >= 59 && v <= 76 {
//               | true => Some(v)
//               | false => None
//               }
//             | _ => None
//             },
//             Some(In),
//           )
//         | _ => (None, None)
//         }
//       | _ => (None, None)
//       },
//       hcl: switch item->Js.Dict.get("hcl") {
//       | Some(v) =>
//         switch Js.Re.test_(%re("/^\#[\d|a-f$]{6}/"), v) {
//         | true => Some(v)
//         | false => None
//         }
//       | _ => None
//       },
//       ecl: switch item->Js.Dict.get("ecl") {
//       | Some(v) =>
//         switch v {
//         | "amb" => Some(Amb)
//         | "blu" => Some(Blu)
//         | "brn" => Some(Brn)
//         | "gry" => Some(Gry)
//         | "grn" => Some(Grn)
//         | "hzl" => Some(Hzl)
//         | "oth" => Some(Oth)
//         | _ => None
//         }
//       | _ => None
//       },
//       pid: switch item->Js.Dict.get("pid") {
//       | Some(v) =>
//         switch Js.Re.test_(%re("/[0-9]{9}/g"), v) {
//         | true => Some(v)
//         | false => None
//         }
//       | _ => None
//       },
//       cid: item->Js.Dict.get("cid"),
//     }
//   })

// let validKeys = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

// inputList
// ->Belt.Array.map(item => {
//   item->Js.log
//   item->Belt.Array.map(((key, _)) => key)
// })
// ->Belt.Array.keep(keyArray => {
//   validKeys->Belt.Array.every(item => {
//     keyArray->Js.Array2.includes(item)
//   })
// })
// ->Belt.Array.length
// ->Js.log
