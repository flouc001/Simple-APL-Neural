:Namespace Neural
    :Class Neuron
        :Field Public Instance weights←⍬
        :Field Public Instance bias←⍬
        :Field Public Instance last_inputs←⍬
        :Field Public Instance last_output←⍬
        :Field Public Instance error←⍬
        :Field Public Instance errors←⍬
        :Field Public Instance delta←⍬

        ∇ make num_inputs
          :Access Public
          :Implements Constructor
          weights←#.Math.rand num_inputs
          bias←#.Math.rand 1
        ∇

        ∇ r←process inputs
          :Access Public
          last_inputs←inputs
          sum←+/(inputs×weights)
          sum+←bias
          last_output←#.Math.sigmoid sum
          r←last_output
        ∇
    :EndClass

    :Class Layer
        :Field Public Instance neurons←⍬

        ∇ make(num_neurons num_inputs);x
          :Access Public
          :Implements Constructor
          :For x :In ⍳num_neurons
              neurons,←⎕NEW #.Neural.Neuron num_inputs
          :EndFor
        ∇

        ∇ r←process inputs;neuron
          :Access Public
          r←⍬
          :For neuron :In neurons
              r,←neuron.process inputs
          :EndFor
        ∇
    :EndClass

    :Class Network
        :Field Public Instance layers←⍬
        :Field Public Instance previous_layer←⍬
        :Field Public Instance error_threshold←0.00001
        :Field Public Instance training_iterations←500000
        :Field Public Instance learning_rate←0.3
        :Field Public Instance output_layer←⍬

        ∇ r←process inputs;layer;outputs
          :Access Public
          :For layer :In layers
              r←layer.process inputs
              inputs←r
          :EndFor
        ∇

        ∇ addLayer(num_neurons num_inputs)
          :Access Public
          :If num_inputs≡⍬
              previous_layer←layers[≢layers]
              num_inputs←≢previous_layer.neurons
          :EndIf
          layers,←⎕NEW Neural.Layer(num_neurons num_inputs)
        ∇

        ∇ train examples;iteration;example;inputs;targets;outputs;i;neuron;l;neuronJ;j;neuronI;w;x;error
          :Access Public
          output_layer←layers[≢layers]
          :For iteration :In ⍳training_iterations
              :For example :In examples
                  inputs←⊃example[1]
                  targets←⊃example[2]
                  outputs←process inputs
                  :For i :In ⍳≢output_layer.neurons
                      neuron←output_layer.neurons[i]
                      neuron.error←targets[i]-outputs[i]
                      neuron.errors,←neuron.error
                      neuron.delta←neuron.last_output×(1-neuron.last_output)×neuron.error
                  :EndFor
                  :For l :In ⌽⍳¯1+≢layers
                      :For j :In ≢layers[l].neurons
                          neuronJ←layers[l].neurons[j]
                          neuronJ.error←+/(j∘{⍵.weights[⍺]×⍵.delta}¨layers[l+1].neurons)
                          neuronJ.delta←neuronJ.last_output×(1-neuronJ.last_output)×neuronJ.error
                          :For x :In ⍳≢layers[l+1].neurons
                              neuronI←layers[l+1].neurons[x]
                              :For w :In ≢neuronI.weights
                                  neuronI.weights[w]+←learning_rate×neuronI.last_inputs[w]×neuronI.delta
                              :EndFor
                              neuronI.bias+←learning_rate×neuronI.delta
                          :EndFor
                      :EndFor
                  :EndFor
              :EndFor
         
              error←#.Math.mse⊣⊃,/output_layer.neurons.errors
              :If 0≡(100|iteration)
                  ⎕←iteration,': ',⍕error
              :EndIf
              :If (error≤error_threshold)
                  ∘∘∘
              :EndIf
          :EndFor
        ∇
    :EndClass
:EndNamespace
