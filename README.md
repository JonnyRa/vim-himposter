# vim-himposter
tools for manipulating imports in haskell

to enable default mappings set the following variable:

```g:himporterCreateMappings = 1```

this sets the following mappings :

```
"mapping mnemonics in comments:
"import generate
nnoremap <leader>ig :call MakeImportForCurrentFile()<cr>
"import insert
nnoremap <leader>ii :call InsertImport<cr>
"add import 
nnoremap <leader>ai :call AddImportForIdentifierUnderCursor()<cr>
"goto imports
nnoremap <Leader>gi :call GoToImports()<cr>
```
