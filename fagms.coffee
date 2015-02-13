###
  Experian template mode

  Experian tokens:
    ##Condition_Start##
    ##(.*)##
    ##Condition_End##

    ##Paragraph_Start rates##
    ##Tempfield_.*##
    ##Paragraph_End rates##

    ||Content_\D*[.*]||

###

fagmsMode =
  start: [
    _ =
      regex: /##Condition_(Start|End)##/,
      token: "keyword"
    _ =
      regex: /##Paragraph_(Start|End) /
      token: "keyword"
      next: "paragraph"
    _ =
      regex: /##Field_/,
      token: "variable-3"
      next: "field"
    _ =
      regex: /##Tempfield_/,
      token: "variable-3"
      next: "field"
    _ =
      regex: /##\(/
      token: "keyword"
      next: 'condition'
    _ =
      regex: /\|\|.*?\[.*?\]\|\|/
      token: "header"
  ]
  paragraph: [
    _ =
      regex: /[a-zA-Z]/
      token: "variable-2"
    _ =
      regex: /##/
      token: "keyword"
      next: "start"
  ]
  field: [
    _ =
      regex: /[a-zA-Z0-9]/
      token: 'variable-2'
    _ =
      regex: /##/
      token: 'variable-3'
      next: 'start'
  ]
  condition: [
    _ =
      regex: /'.*?'/
      token: 'string'
    _ =
      regex: /[a-zA-Z0-9_]/
      token: 'variable-2'
    _ =
      regex: /[-+\/*=<>!]+/
      token: "operator"
    _ =
      regex: /\)##/
      token: 'keyword'
      next: 'start'
  ]

CodeMirror.defineSimpleMode "fagms", fagmsMode

