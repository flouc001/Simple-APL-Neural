:Namespace Testing
    ∇ CharacterRecognition;network;zero;one;two;three;outputs;test;binary;decimal
      network←⎕NEW #.Neural.Network
      network.addLayer 10 20
      network.addLayer 2 ⍬
      zero←(0 1 1 0 1 0 0 1 1 0 0 1 1 0 0 1 0 1 1 0)
      one←(0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0)
      two←(0 1 1 0 1 0 0 1 0 0 1 0 0 1 0 0 1 1 1 1)
      three←(1 1 1 1 0 0 0 1 0 1 1 1 0 0 0 1 1 1 1 1)
      test←(1 1 1 1 1 0 0 1 1 0 0 1 1 0 0 1 1 1 1 0)
     
      network.learning_rate←2
      network.train((zero(0 0))(one(0 1))(two(1 0))(three(1 1)))
     
      outputs←network.process test
     
      binary←⌊0.5+outputs
      decimal←2⊥binary
      ⎕←'Expected: ',0
      ⎕←'Recognized ',decimal,outputs
    ∇

    ∇ XOR;network;binary;outputs
      network←⎕NEW #.Neural.Network
      network.addLayer 5 2
      network.addLayer 4 ⍬
      network.addLayer 1 ⍬
     
      network.train(((0 0)0)((0 1)1)((1 0)1)((1 1)0))
      outputs←network.process(0 0)
      binary←⌊0.5+outputs
      ⎕←'Expected: ',0
      ⎕←'Recognized ',binary,outputs
    ∇

    ∇ CharacterRecognition_ANN;network;patterns;noise;outputs
      network←#.ANN.New 20 10 2
      network.error_threshold←0.01
      patterns←getCharPatterns
      network #.ANN.Train patterns
      noise←{⍵≠{(⍳⍵)∊2?⍵}≢⍵}¨⊃¨patterns
      outputs←⌊0.5+network #.ANN.Process¨noise
     
      ⎕←'Expected: ',⊃∘⌽¨patterns
      ⎕←'Recognized ',outputs
    ∇

    ∇ r←getCharPatterns;∆
      r←⍬
     
      ∆←,0 1 1 0
      ∆,←1 0 0 1
      ∆,←1 0 0 1
      ∆,←1 0 0 1
      ∆,←0 1 1 0
      r,←⊂∆(0 0)
     
      ∆←,0 0 1 0
      ∆,←0 0 1 0
      ∆,←0 0 1 0
      ∆,←0 0 1 0
      ∆,←0 0 1 0
      r,←⊂∆(0 1)
     
      ∆←,0 1 1 0
      ∆,←1 0 0 1
      ∆,←0 0 1 0
      ∆,←0 1 0 0
      ∆,←1 1 1 1
      r,←⊂∆(1 0)
     
      ∆←,1 1 1 1
      ∆,←0 0 0 1
      ∆,←0 1 1 1
      ∆,←0 0 0 1
      ∆,←1 1 1 1
      r,←⊂∆(1 1)
    ∇

    ∇ XOR_ANN;network;outputs;patterns
      network←#.ANN.New 2 8 4 1
      network.training_iterations←100000
      patterns←,¨¨((0 0)0)((0 1)1)((1 0)1)((1 1)0)
      network #.ANN.Train patterns
      outputs←⌊0.5+network #.ANN.Process¨⊃¨patterns
      ⎕←'Expected: ',⊃∘⌽¨patterns
      ⎕←'Recognized ',outputs
    ∇
:EndNamespace
