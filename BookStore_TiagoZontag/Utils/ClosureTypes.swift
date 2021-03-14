//
//  Typealias.swift
//  BookStore_TiagoZontag
//
//  Created by Tiago Zontag on 13/03/21.
//

import Foundation

typealias Action = () -> Void
typealias Action1<Input> = (Input) -> Void
typealias Action2<Input1, Input2> = (Input1, Input2) -> Void
typealias Action3<Input1, Input2, Input3> = (Input1, Input2, Input3) -> Void

typealias Predicate = () -> Bool
typealias Predicate1<Input> = (Input) -> Bool
typealias Predicate2<Input1, Input2> = (Input1, Input2) -> Bool
typealias Predicate3<Input1, Input2, Input3> = (Input1, Input2, Input3) -> Bool

typealias Func<Output> = () -> Output
typealias Func1<Input, Output> = (Input) -> Output
typealias Func2<Input1, Input2, Output> = (Input1, Input2) -> Output
typealias Func3<Input1, Input2, Input3, Output> = (Input1, Input2, Input3) -> Output
