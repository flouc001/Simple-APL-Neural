:Namespace Math
    ∇ r←rand num
      r←((?num⍴0)×0.4)-0.2 ⍝ Number between -0.2 and 0.2
    ∇
    
    ∇ r←mse errors;x
      r←0
      :For x :In ⍳≢errors
          r+←(errors[x])*2
      :EndFor
      r÷←≢errors
⍝      r←(+/⊃errors*2)÷≢errors
    ∇
    
    ∇ r←sum vec
      r←+/vec
    ∇
    
    ∇ r←sigmoid num;e
      e←2.718281828459045
      r←1÷(1+e*(¯1×num))
    ∇
:EndNamespace