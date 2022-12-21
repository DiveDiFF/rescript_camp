let input = Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day4.sample.txt")

type passportKeyType = Byr | Iyr | Eyr | Hgt | Hcl | Ecl | Pid | Cid
type heightUnitType = Cm | In
type eyeColorType = Amb | Blu | Brn | Gry | Grn | Hzl | Oth
type passportType = {
  byr?: option<int>,
  iyr?: option<int>,
  eyr?: option<int>,
  hgt?: (option<int>, option<heightUnitType>),
  hcl?: option<string>,
  ecl?: option<eyeColorType>,
  pid?: option<string>,
  cid?: string,
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
      | [key, value] =>
        Some({
          switch key {
          | "byr" => {
              byr: switch value->Belt.Int.fromString {
              | Some(v) =>
                switch v >= 1920 && v <= 2002 {
                | true => Some(v)
                | false => None
                }
              | _ => None
              },
            }
          | "iyr" => {
              iyr: switch value->Belt.Int.fromString {
              | Some(v) =>
                switch v >= 2010 && v <= 2020 {
                | true => Some(v)
                | false => None
                }
              | _ => None
              },
            }
          | "eyr" => {
              eyr: switch value->Belt.Int.fromString {
              | Some(v) =>
                switch v >= 2020 && v <= 2030 {
                | true => Some(v)
                | false => None
                }
              | _ => None
              },
            }
          | "hgt" => {
              hgt: switch value->Js.String2.sliceToEnd(~from=-2) {
              | "cm" => (
                  switch value
                  ->Js.String2.substring(~from=0, ~to_=value->Js.String2.indexOf("c") + 1)
                  ->Belt.Int.fromString {
                  | Some(v) =>
                    switch v >= 150 && v <= 193 {
                    | true => Some(v)
                    | false => None
                    }
                  | _ => None
                  },
                  Some(Cm),
                )
              | "in" => (
                  switch value
                  ->Js.String2.substring(~from=0, ~to_=value->Js.String2.indexOf("i") + 1)
                  ->Belt.Int.fromString {
                  | Some(v) =>
                    switch v >= 59 && v <= 76 {
                    | true => Some(v)
                    | false => None
                    }
                  | _ => None
                  },
                  Some(In),
                )
              | _ => (None, None)
              },
            }
          | "hcl" => {
              hcl: switch Js.Re.test_(%re("/^\#[\d|a-f$]{6}/"), value) {
              | true => Some(value)
              | false => None
              },
            }
          | "ecl" => {
              ecl: switch value {
              | "amb" => Some(Amb)
              | "blu" => Some(Blu)
              | "brn" => Some(Brn)
              | "gry" => Some(Gry)
              | "grn" => Some(Grn)
              | "hzl" => Some(Hzl)
              | "oth" => Some(Oth)
              | _ => None
              },
            }
          | "pid" => {
              pid: switch Js.Re.test_(%re("/[0-9]{9}/g"), value) {
              | true => Some(value)
              | false => None
              },
            }
          | "cid" => {cid: value}
          | _ => Js.Exn.raiseError(`this is not valid key`)
          }
        })
      | _ => None
      }
    })
  })

// let validKeys = [Byr, Iyr, Eyr, Hgt, Hcl, Ecl, Pid]

inputList->Js.log

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
