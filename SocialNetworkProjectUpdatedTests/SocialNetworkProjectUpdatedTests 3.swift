//
//  SocialNetworkProjectUpdatedTests.swift
//  SocialNetworkProjectUpdatedTests
//
//  Created by Philip Twal on 2/6/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import Quick
import Nimble

@testable import SocialNetworkProjectUpdated

class SocialNetworkProjectUpdatedTests: QuickSpec {

    var isValidSignUp: SignUpViewModel!
    
    override func spec(){
        
        beforeEach{
            
            self.isValidSignUp = SignUpViewModel()
        }
        
        afterEach{
            
            self.isValidSignUp = nil
        }
        
        describe("starting signUp testing") {
            
            context("test isValid Function"){
                
                it("testing a not valid input"){
                    
                    let result = self.isValidSignUp.isValid(userName: "", password: "", email: "")
                    expect(result).to(equal(false))
                    
                }
            }
            
            context("test isValid Function"){
                
                it("testing a valid input"){
                    
                    let result = self.isValidSignUp.isValid(userName: "Philip", password: "testpassword", email: "philipfakeemail@gmail.com")
                    expect(result).to(equal(true))
                }
            }
        }
    }
}
