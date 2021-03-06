(*%****************************************************************************
 *  ___                                             ___               _       *
 * / __|  ___   _ __    _ __   __ _   _ _   ___    | _ )  ___   ___  | |_     *
 * \__ \ / -_) | '  \  | '_ \ / _` | | '_| / -_)   | _ \ / _ \ / _ \ |  _|    *
 * |___/ \___| |_|_|_| | .__/ \__,_| |_|   \___|   |___/ \___/ \___/  \__|    *
 *                     |_|                                                    *
 ******************************************************************************
 *                                                                            *
 *                        VELOCITY TEMPLATE ENGINE                            *
 *                                                                            *
 *                                                                            *
 *          https://www.github.com/sempare/sempare.boot.velocity.oss          *
 ******************************************************************************
 *                                                                            *
 * Copyright (c) 2019 Sempare Limited,                                        *
 *                    Conrad Vermeulen <conrad.vermeulen@gmail.com>           *
 *                                                                            *
 * Contact: info@sempare.ltd                                                  *
 *                                                                            *
 * Licensed under the Apache License, Version 2.0 (the "License");            *
 * you may not use this file except in compliance with the License.           *
 * You may obtain a copy of the License at                                    *
 *                                                                            *
 *   http://www.apache.org/licenses/LICENSE-2.0                               *
 *                                                                            *
 * Unless required by applicable law or agreed to in writing, software        *
 * distributed under the License is distributed on an "AS IS" BASIS,          *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   *
 * See the License for the specific language governing permissions and        *
 * limitations under the License.                                             *
 *                                                                            *
 ****************************************************************************%*)
unit Sempare.Boot.Template.Velocity.TestDictionary;

interface

uses
  DUnitX.TestFramework,
  System.Generics.Collections;

type

  [TestFixture]
  TTestVelocityDict = class
  public
    [Test]
    procedure TestDictionary;
    [Test]
    procedure TestNestedDictionary;
  end;

type
  TStringDictionary = TDictionary<string, string>;
  TNestedDictionary = TObjectDictionary<integer, TDictionary<string, string>>;

implementation

uses

  Sempare.Boot.Template.Velocity;

procedure TTestVelocityDict.TestDictionary;
var
  D: TDictionary<string, string>;
begin
  D := TDictionary<string, string>.create;
  D.Add('a', 'value');
  Assert.AreEqual('value', Velocity.Eval('<% a %>', D));
  D.Free;
end;

procedure TTestVelocityDict.TestNestedDictionary;
var
  dict: TNestedDictionary;
begin
  dict := TNestedDictionary.create();
  dict.Add(1, TStringDictionary.create());
  dict.Add(2, TStringDictionary.create());

  dict[1].Add('v', 'value');
  dict[2].Add('v', 'another');

  Assert.AreEqual('value', Velocity.Eval('<% _[1][''v'']%>', dict));
  Assert.AreEqual('another', Velocity.Eval('<% _[2][''v'']%>', dict));

  dict.Free;
end;

initialization

TDUnitX.RegisterTestFixture(TTestVelocityDict);

end.
