; Example query to capture process name, inputs, and outputs
((process_declaration
  name: (identifier) @process.name
  inputs: (input_list (identifier) @process.input)
  outputs: (output_list (identifier) @process.output)))
