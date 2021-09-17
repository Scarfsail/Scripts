. .\CsNameSpaceSimplification.ps1

Describe "test" {
    It "Namespace without semicolon is suffixed with semicolon" {
        $TestInputData = @'
using SomeUsing;

namespace Some.Old.Namespace.Style 
{
    class SomeClass
    {

    }
}
'@
        
        $TestExpectedData = @'
using SomeUsing;

namespace Some.Old.Namespace.Style;

class SomeClass
{

}

'@
        Convert-CsOldNameSpaceToSimple $TestInputData | Should -Be $TestExpectedData
    }

    It "Four leading spaces should be removed in singleline" {
        Convert-RemoveFourLeadingSpacesFromEachLine "    abc" | Should -Be "abc"
    }

    It "Four leading spaces should be removed in multiline" {
        $inputStr = @'    
    abc


    def
  ghi    
    jkl
'@

$expectedStr = @'    
abc


def
  ghi    
jkl
'@
        Convert-RemoveFourLeadingSpacesFromEachLine $inputStr | Should -Be $expectedStr
    }

}
