" Defold config highlighting

syntax keyword defoldKeyword
      \ key_trigger mouse_trigger embedded_instances embedded_components
      \ components id data input action component scale_along_z name

syntax match defoldNumber /\v\d+/
syntax match defoldConstant /\v[A-Z_]+/
syntax region defoldString start=/"/ end=/"/

highlight link defoldKeyword Keyword
highlight link defoldString String
highlight link defoldNumber Number
highlight link defoldConstant Constant

