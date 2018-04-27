# vim-himposter
tools for manipulating imports in haskell

to enable default mappings set the following variable:

```g:himporterCreateMappings = 1```

this sets the following mappings :

```
"mapping mnemonics in comments:
"import generate
nnoremap <leader>ig :call HimposterMakeImportForCurrentFile()<cr>
"import insert
nnoremap <leader>ii :call HimposterInsertImport<cr>
"add import 
nnoremap <leader>ai :call HimposterAddImportForIdentifierUnderCursor()<cr>
"goto imports
nnoremap <Leader>gi :call HimposterGoToImports()<cr>
```

effectively AddImportForIdentifierUnderCursor uses the other functions and is what you want most of the time

GoToImports is also really useful for editing/viewing/adding imports by hand

the others are mostly useful if AddImport imports the wrong file (it just uses the first tag matched) 
as you can use them manually to achieve the same thing easily:

if you manually find the right file you can do the following:

```
(when in the file you want to import)
MakeImport..
"swap to previous file
<C-^>
GoToImports
InsertImport
go back a few times to get to where you were before
```

