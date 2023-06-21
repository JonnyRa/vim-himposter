let s:lastNamespace = ""

function! HimposterMakeImportForCurrentFile()
  let splitName = split(expand('%'),'/')
  let startOfNamespace = -1
  let index = 0

  let sourceDirectoryNames = ["src", "gen", "selenium", "test"] 
  for bitOfPath in splitName
    let index += 1
    if index(sourceDirectoryNames, bitOfPath) >= 0
      let startOfNamespace=index
    endif
  endfor

  if startOfNamespace == -1
    let startOfNamespace = 0
  endif

  let namespaceBits = splitName[startOfNamespace:]
  let filenameIndex = len(namespaceBits)-1
  let filename = s:RemoveExtension(namespaceBits[filenameIndex])

  let namespaceBits[filenameIndex] = filename

  let s:lastNamespace = join (namespaceBits, ".")
endfunction

function! s:RemoveExtension(filename)
  "need both single quotes and backslash here to make . work!
  let splitFilename = split(a:filename,'\.')

  "filenames dont always have extensions
  if splitFilename != []
    return splitFilename[0]
  endif

  return a:filename
endfunction

function! GetLastNamespace()
  return s:lastNamespace
endfunction

function! HimposterInsertImport()
  put='import ' . GetLastNamespace()
endfunction

function! HimposterAddImportForIdentifierUnderCursor()
  "save view
  let viewInfo = winsaveview()
  let originalFile = expand('%:p')
  "go to tag under cursor
  try
    execute "normal! \<C-]>"
  catch
    echo "Error: couldn't find tag for identifier under cursor"
    return 
  endtry 

  let tagFile = expand('%:p')

  if tagFile == originalFile
    echo "Error: identifier is in current file! - doesn't need an import"
    call winrestview(viewInfo)
    return
  endif

  "generate import for the new file
  call HimposterMakeImportForCurrentFile()
  "switch back to previous buffer
  execute "normal! \<C-^>"
  "go to imports and insert the new one
  call HimposterGoToImports()
  call HimposterInsertImport()
  "restore the view
  call winrestview(viewInfo)
  normal! j
endfunction

function! HimposterGoToImports()
  execute "normal ?^import\\>\\(\\s\\+qualified\\)\\@!\<cr>"
endfunction

if !exists('g:himporterCreateMappings')
  let g:himporterCreateMappings = 0
endif

if g:himporterCreateMappings
  "mapping mnemonics in comments:
  "import generate
  nnoremap <leader>ig :call HimposterMakeImportForCurrentFile()<cr>
  "import insert
  nnoremap <leader>ii :call HimposterInsertImport()<cr>
  "add import 
  nnoremap <leader>ai :call HimposterAddImportForIdentifierUnderCursor()<cr>
  "goto imports
  nnoremap <Leader>gi :call HimposterGoToImports()<cr>
endif
