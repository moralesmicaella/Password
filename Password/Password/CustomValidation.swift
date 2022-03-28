//
//  CustomValidation.swift
//  Password
//
//  Created by Micaella Morales on 3/27/22.
//

import Foundation

/**
 A function one passes in to do custom validation on the text field.
 
 - Parameter: textValue: The value of text to validate
 - Returns: A Bool indicating whether text is valid, and if not a String containing an error message
 */
typealias CustomValidation = (_ textValue: String?) -> (isValid: Bool, errorMessage: String)?
